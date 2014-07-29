#!/usr/bin/env python

"""
"""

import os
import sys
from ast import literal_eval

# Ensure frequency file at least exists
FREQ_FILE = os.path.join(os.environ["HOME"], ".dirfreq")
if not os.path.exists(FREQ_FILE):
    open(FREQ_FILE, 'w').close()

# If recording, do this quickly and exit
if __name__ == "__main__" and len(sys.argv) == 3 and sys.argv[1] == "record":
    import collections
    lines = open(FREQ_FILE).read().splitlines()
    freqs = collections.defaultdict(int, (literal_eval(l) for l in lines))
    freqs[sys.argv[2]] += 1
    open(FREQ_FILE, 'w').write(
            '\n'.join('"%s", %s' % t for t in sorted(
                    freqs.iteritems(), key=lambda x: -x[1])) + '\n')
    sys.exit(0)

import re
import tty
import termios
import argparse

KEY_BS = 127
KEY_ENTER = ord("\n")
KEY_RETURN = ord("\r")
KEY_ESC = 27

SEQ_BS = "\033[D \033[D"
SEQ_RETURN = "\r"
SEQ_ERASE_LINE = "\033[2K"
SEQ_UP = "\033[A"
SEQ_WRAP = "\033[?7h"
SEQ_NOWRAP = "\033[?7l"

CLR_RED = "\033[31m"
CLR_GREEN = "\033[32m"
CLR_BOLD = "\033[1m"
CLR_CLEAR = "\033[m"

class OK(Exception): """Signal OK"""
class CANCEL(Exception): """Signal CANCEL"""


class Completer(object):

    def __init__(self, paths=None):
        freqs = {}
        if paths is None:
            with open(FREQ_FILE) as freqfile:
                for line in freqfile:
                    try:
                        path, freq = literal_eval(line)
                    except:
                        continue
                    freqs[path] = freq
        else:
            for path in paths:
                freqs[path] = 1

        # Initialize Completer fields
        self.freqs = freqs
        self.all_paths = sorted(self.freqs, key=self.freqs.get)
        self.maxfreq = max(self.freqs.values())
        self.maxlen = max(map(len, self.all_paths))
        self.suggestions = []

    def update_suggestions(self, chars, how_many):
        if not chars:
            self.suggestions = []
            return
        scores = {}
        found_words = {}
        for path in self.all_paths:
            score = self._calc_score(path, chars)
            if score == 0:
                continue
            found_word = chars in path
            if found_word:
                score += len(chars)             # n points for whole word
            scores[path] = score
            found_words[path] = (chars if found_word else "")
        
        # Build results sets
        if not scores:
            results = []
        else:
            best = sorted(scores, key=scores.get)[-how_many:]
            results = list(
                {
                    "path": path,
                    "score": scores[path],
                    "word": found_words[path],
                    "disp": path if i < 0*len(best) else
                            self._highlight(path, found_words[path], chars),
                }
                for i, path in enumerate(best, 1)
            )
        self.suggestions = results

    def _calc_score(self, path, chars):
        parts = re.split("[-./_]+", path)

        score_len = float(self.maxlen - len(path)) / self.maxlen

        # Normalized overall frequency score
        score_visit = float(self.freqs[path]) / self.maxfreq

        # Score for char occurrence in the path, in order
        score_char_order = 0
        i = -1
        for ch in chars:
            try:
                i = path.index(ch, i + 1)
                score_char_order += 1
            except ValueError:
                break

        # Score for any char at beginning of part or parts that are covered
        score_beginnings = 0
        score_whole_part = 0
        sw = tuple(chars)
        i = 0

        def match(chars, parts):
            if len(chars) == 0:  # All chars consumed
                return True, 0
            best_sub_count = 0
            for p in xrange(len(parts)):
                for c in range(len(chars))[::-1]:
                    if parts[p].startswith(chars[:c+1]):
                        # Matched, see if the remaining chars can find
                        # matches in the remaining parts
                        success, count = match(chars[c+1:], parts[p+1:])
                        if success:
                            # Earlier parts score higher
                            count += (c + 1) * (len(parts) - p) / len(parts)
                            return True, c+1 + count
                        best_sub_count = max(c + 1, best_sub_count)
            # All parts consumed
            return False, best_sub_count

        _, score_beginnings = match(chars, parts)
        matches = {}
        for ch in chars:
            for part in parts[i:]:
                if part.startswith(ch):
                    matches[ch] = part
        #score_beginnings += len(matches)

        return (1.0 * score_visit +
                2.0 * score_len +
                5.0 * score_char_order +
                5.0 * score_beginnings +
                1.0 * score_whole_part)

    def _highlight(self, path, word, chars):
        cs = set(chars)
        if "-" in cs:
            cs.remove("-")
            cs = "-" + "".join(cs)
        else:
            cs = "".join(cs)
        hi = lambda s: re.sub(r"([%s]+)" % cs, CLR_GREEN + r"\1" + CLR_CLEAR, s)
        #if not word:
        return hi(path)
        parts = path.split(word)
        return (CLR_BOLD + word + CLR_CLEAR).join(hi(part) for part in parts)


class Screen(object):

    def __init__(self, lines=5, completer=None):
        if completer is None:
            completer = Completer()
        self.completer = completer

        # Set up the terminal
        fd = sys.stdin.fileno()
        self._term_settings = termios.tcgetattr(fd)

        # Set stdin to raw mode
        tty.setraw(fd)

        # Define the output
        self.write = sys.stderr.write

        self.chars = []

        # Erase current line and make (lines-1) new ones
        self.nlines = lines
        self.write(SEQ_RETURN + SEQ_ERASE_LINE + (":\n" * lines) + "> ")

    def __del__(self):
        self.write(SEQ_WRAP)
        fd = sys.stdin.fileno()
        termios.tcsetattr(fd, termios.TCSADRAIN, self._term_settings)

    def clrscr(self):
        self.write(SEQ_RETURN + SEQ_ERASE_LINE +
                   (SEQ_UP + SEQ_ERASE_LINE) * self.nlines)

    def draw(self):
        # Move up, display up to nlines suggestions
        self.completer.update_suggestions("".join(self.chars), self.nlines)
        sugs = self.completer.suggestions
        none = not bool(sugs)
        empty = {"disp": ":", "score": 0}
        sugs = [empty] * max(0, self.nlines - len(sugs)) + sugs
        self.write(SEQ_UP * self.nlines + SEQ_RETURN)
        min_score = 0*min(s["score"] for s in sugs)
        max_score = max(s["score"] for s in sugs) or 1
        for i in range(self.nlines):
            self.write(SEQ_ERASE_LINE + SEQ_NOWRAP +
                    "{1:6s} {0[disp]}".format(
                        sugs[i],
                        ("*" * int(5 * (sugs[i]["score"] - min_score) / (max_score - min_score))).rjust(5)
                    ) + "\r\n")
        self.write(SEQ_ERASE_LINE + "> ")
        
        if none:
            sys.stderr.write(CLR_BOLD + CLR_RED + "".join(self.chars) + CLR_CLEAR)
        else:
            sys.stderr.write("".join(self.chars))


    def handle_char(self, ch):
        self.chars.append(ch)


    def handle_special(self, code):
        if code == KEY_BS:
            if not self.chars:
                raise CANCEL()
            self.chars.pop()
        elif code in [KEY_ENTER, KEY_RETURN]:
            raise OK()
        elif code == KEY_ESC:
            raise CANCEL()
        else:
            raise CANCEL()

    def do_interact(self):
        try:
            while not sys.stdin.closed:
                self.draw()
                ch = sys.stdin.read(1)
                if ch.isalnum() or ch in "/.-_":
                    self.handle_char(ch)
                else:
                    self.handle_special(ord(ch))
        except OK:
            self.clrscr()
            if self.completer.suggestions:
                sys.stdout.write(self.completer.suggestions[-1]["path"] + "\n")
                return 0
        except CANCEL:
            self.clrscr()
        return 1


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("mode", choices=["record", "suggest"])
    args = parser.parse_args()

    # Chose a completion source
    completer = Completer()

    if args.mode == "suggest":
        fd = sys.stdin.fileno()
        try:
            screen = Screen(3, completer)
            exit_code = screen.do_interact()
        finally:
            sys.stderr.write(CLR_CLEAR)
        sys.exit(exit_code)

    else:
        raise RuntimeError("Should handle other modes at top")


if __name__ == "__main__":
    main()

