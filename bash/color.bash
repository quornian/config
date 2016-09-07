# Configures colours for the shell and sets colour-related options
# for some commands.
#

# A function for easily inserting colour escape sequences
# Example: "$(__cx '1;32')Bold, green Text$(__cx)"
__cx() { echo -en "\e[${1}m"; }

__themes=(
"deep1      000000 AF0000 AFD700 FF8700 005F87 875F87 008787 AFAFAF \
            5F5F5F D70000 D7FF5F FFAF00 5FAFFF D75FFF 87D7D7 FFFFFF \
            000000 AFAFAF"
"deep2      000000 AF0000 AFD700 FF8700 5F87AF 875F87 008787 AFAFAF \
            5F5F5F D70000 D7FF5F FFAF00 5FAFFF D75FFF 87D7D7 FFFFFF \
            000000 AFAFAF"
"bright     111111 AF5F5F AFD75F FF8700 00AFD7 D787AF 00AF87 D7D7D7 \
            5F5F5F D75F5F D7FF5F FFAF00 5FD7FF FF87D7 5FD7AF FFFFFF \
            111111 D7D7D7"
"brighter   444444 AF5F5F AFD75F FF8700 00AFD7 D75FAF 00AF87 D7D7D7 \
            878787 D75F5F D7FF5F FFAF00 5FD7FF FF87D7 5FD7AF FFFFFF \
            444444 D7D7D7"
"yuck       000000 DD0000 558855 AA8800 0055AA 885588 008888 555555 \
            888888 FF0000 88DD55 DDAA00 5588AA AA55AA 00DDDD 555555 \
            000000 555555"
"chalk      1B2426 D9AE95 B9BA91 CCB48C AFBBB1 C2B5B5 ACBDA2 9B9D98 \
            686A66 F2C3A7 CFD0A2 E4C99C C3D0C6 D7CACA C0D3B4 CDD0C9 \
            1B2426 9B9D98"
"glow       272822 F92672 A6E22E FD971F 66BCEF AE81FF 66D9EF 708090 \
            708090 F92672 A6E22E FD971F 66BCEF AE81FF 66D9EF F8F8F2 \
            181818 FFFFFF"
"cool-blue  0D141F D581A1 7EA578 C0916F 12A5E6 A38FDC 00ACB3 949BAA \
            454B58 D581A1 7EA578 C0916F 12A5E6 A38FDC 00ACB3 E5ECFD \
            0D141F 949BAA"
"cool-2     090E16 D581A1 7EA578 C0916F 12A5E6 A38FDC 00ACB3 949BAA \
            454B58 D581A1 7EA578 C0916F 12A5E6 A38FDC 00ACB3 E5ECFD \
            090E16 949BAA"
"cool-3     090E16 D581A1 7EA578 C0916F 12A5E6 A38FDC 00ACB3 949BAA \
            454B58 D581A1 7EA578 C0916F 12A5E6 A38FDC 00ACB3 B5BCCD \
            090E16 949BAA"
"solarized  073642 DC322F 859900 B58900 268BD2 D33682 2AA198 EEE8D5 \
            002B36 CB4B16 586E75 657B83 839496 6C71C4 93A1A1 FDF6E3 \
            002B36 839496"
"sea        002B36 DC322F 2AA198 B58900 268BD2 6C71C4 2AA198 93A1A1 \
            586E75 DC322F 2AA198 B58900 268BD2 6C71C4 2AA198 FDF6E3 \
            002B36 839496"
"teal       0C1A1D AD7385 7BB674 ADA574 6A83B7 9C73B7 6AB6A7 7B8385 \
            464F50 C8B0BA B0D0B2 C8C8B2 A8B8D2 C0B0D2 A8D0CA C0C8CA \
            0C1A1D 7B8385"
"ambiance   222222 CF7EA9 78CF8A CDA869 AAC6E3 9999CC 24C2C7 777777 \
            333333 CF7EA9 78CF8A CDA869 AAC6E3 9999CC 24C2C7 E6E1DC \
            222222 777777"
"library    090E16 E74C3C 2ECC71 F1C40F 3498DB E67E22 9B59B6 95A5A6 \
            34495E E74C3C 2ECC71 F1C40F 3498DB E67E22 9B59B6 ECF0F1 \
            090E16 ECF0F1"
"base16     090300 DB2D20 01A252 FDED02 01A0E4 A16A94 B5E4F4 A5A2A2 \
            5C5855 DB2D20 01A252 FDED02 01A0E4 A16A94 B5E4F4 F7F7F7 \
            090300 A5A2A2"
"white      FFFFFF E66046 139726 C78317 1674AC 9547B3 358797 3B4753 \
            363F48 E66046 139726 C78317 1674AC 9547B3 358797 242934 \
            FFFFFF 242934"
)

theme() {
    case $1 in
        list)
            for theme in "${__themes[@]}"
            do
                read name colors <<<"$theme"
                echo "$name"
            done
            ;;
        show)
            shift 1
            local sought="$1"
            local found=
            for theme in "${__themes[@]}"
            do
                read name colors <<<"$theme"
                if [ "$name" = "$sought" ]
                then
                    echo $colors
                    found=1
                    break
                fi
            done
            if [ -z "$found" ]
            then
                echo >&2 "Not found: $sought"
                return 1
            fi
            ;;
        apply)
            set -o pipefail
            shift 1
            local sought="$1"
            read c0 c1 c2 c3 c4 c5 c6 c7 \
                 c8 c9 cA cB cC cD cE cF \
                 cbg cfg <<<"`theme show $sought`"
            if [ -z "$cfg" ]
            then
                return 1
            fi

            # Apply theme to gnome-terminal
            local profile="/apps/gnome-terminal/profiles/Default"
            local palette="#$c0:#$c1:#$c2:#$c3:#$c4:#$c5:#$c6:#$c7"
            palette="$palette:#$c8:#$c9:#$cA:#$cB:#$cC:#$cD:#$cE:#$cF"
            gconftool-2 --type string --set "$profile/background_color" "#$cbg"
            gconftool-2 --type string --set "$profile/foreground_color" "#$cfg"
            gconftool-2 --type string --set "$profile/palette" "$palette"
            gconftool-2 --type string --set "$profile/cursor_blink_mode" "off"

            # Apply theme to xterm
            cat >"$HOME/.Xresources.d/color" <<END
UXTerm*background: rgb:${cbg:0:2}/${cbg:2:2}/${cbg:4:2}
UXTerm*foreground: rgb:${cfg:0:2}/${cfg:2:2}/${cfg:4:2}
UXTerm*color0: rgb:${c0:0:2}/${c0:2:2}/${c0:4:2}
UXTerm*color1: rgb:${c1:0:2}/${c1:2:2}/${c1:4:2}
UXTerm*color2: rgb:${c2:0:2}/${c2:2:2}/${c2:4:2}
UXTerm*color3: rgb:${c3:0:2}/${c3:2:2}/${c3:4:2}
UXTerm*color4: rgb:${c4:0:2}/${c4:2:2}/${c4:4:2}
UXTerm*color5: rgb:${c5:0:2}/${c5:2:2}/${c5:4:2}
UXTerm*color6: rgb:${c6:0:2}/${c6:2:2}/${c6:4:2}
UXTerm*color7: rgb:${c7:0:2}/${c7:2:2}/${c7:4:2}
UXTerm*color8: rgb:${c8:0:2}/${c8:2:2}/${c8:4:2}
UXTerm*color9: rgb:${c9:0:2}/${c9:2:2}/${c9:4:2}
UXTerm*color10: rgb:${cA:0:2}/${cA:2:2}/${cA:4:2}
UXTerm*color11: rgb:${cB:0:2}/${cB:2:2}/${cB:4:2}
UXTerm*color12: rgb:${cC:0:2}/${cC:2:2}/${cC:4:2}
UXTerm*color13: rgb:${cD:0:2}/${cD:2:2}/${cD:4:2}
UXTerm*color14: rgb:${cE:0:2}/${cE:2:2}/${cE:4:2}
UXTerm*color15: rgb:${cF:0:2}/${cF:2:2}/${cF:4:2}
END
            xrdb -merge "$HOME/.Xresources"

            # Apply theme to xfce terminal
            cat >"$HOME/.config/xfce4/terminal/terminalrc" <<END
[Configuration]
FontName=Monospace 9
FontAntiAlias=FALSE
ColorBackground=#$c0
ColorForeground=#$c7
ColorCursor=#$c7
ColorPalette=#${c0:0:2}${c0:0:2}${c0:2:2}${c0:2:2}${c0:4:2}${c0:4:2};\
#${c1:0:2}${c1:0:2}${c1:2:2}${c1:2:2}${c1:4:2}${c1:4:2};\
#${c2:0:2}${c2:0:2}${c2:2:2}${c2:2:2}${c2:4:2}${c2:4:2};\
#${c3:0:2}${c3:0:2}${c3:2:2}${c3:2:2}${c3:4:2}${c3:4:2};\
#${c4:0:2}${c4:0:2}${c4:2:2}${c4:2:2}${c4:4:2}${c4:4:2};\
#${c5:0:2}${c5:0:2}${c5:2:2}${c5:2:2}${c5:4:2}${c5:4:2};\
#${c6:0:2}${c6:0:2}${c6:2:2}${c6:2:2}${c6:4:2}${c6:4:2};\
#${c7:0:2}${c7:0:2}${c7:2:2}${c7:2:2}${c7:4:2}${c7:4:2};\
#${c8:0:2}${c8:0:2}${c8:2:2}${c8:2:2}${c8:4:2}${c8:4:2};\
#${c9:0:2}${c9:0:2}${c9:2:2}${c9:2:2}${c9:4:2}${c9:4:2};\
#${cA:0:2}${cA:0:2}${cA:2:2}${cA:2:2}${cA:4:2}${cA:4:2};\
#${cB:0:2}${cB:0:2}${cB:2:2}${cB:2:2}${cB:4:2}${cB:4:2};\
#${cC:0:2}${cC:0:2}${cC:2:2}${cC:2:2}${cC:4:2}${cC:4:2};\
#${cD:0:2}${cD:0:2}${cD:2:2}${cD:2:2}${cD:4:2}${cD:4:2};\
#${cE:0:2}${cE:0:2}${cE:2:2}${cE:2:2}${cE:4:2}${cE:4:2};\
#${cF:0:2}${cF:0:2}${cF:2:2}${cF:2:2}${cF:4:2}${cF:4:2}
MiscAlwaysShowTabs=FALSE
MiscBell=FALSE
MiscCursorBlinks=FALSE
MiscCursorShape=TERMINAL_CURSOR_SHAPE_BLOCK
MiscInheritGeometry=FALSE
MiscMenubarDefault=FALSE
MiscMouseAutohide=TRUE
MiscToolbarsDefault=FALSE
MiscConfirmClose=TRUE
MiscCycleTabs=TRUE
MiscTabCloseButtons=TRUE
MiscTabCloseMiddleClick=TRUE
MiscTabPosition=GTK_POS_TOP
MiscHighlightUrls=TRUE
END
            # Record whether we're using a light background
            if [[ $((16#${cfg:2:2})) > 128 ]]
            then
                echo 1 > $HOME/.config/managed/.light-theme
            else
                echo 0 > $HOME/.config/managed/.light-theme
            fi

            ;;
        preview)
            shift 1
            local sought="$1"
            if [ "$sought" == "all" ]
            then
                # Write an HTML file to represent the colours
                local file="$HOME/.bash/color-preview.html"
                local theme name c0 c1 c2 c3 c4 c5 c6 c7 c8 c9 cA cB cC cD cE cF cbg cfg
                cat >"$file" <<END
<!DOCTYPE html>
<html><head><style type="text/css">
    body { margin: 0; }
    .pal { width: 300px; }
    .pal td { width: 30px; height: 30px; }
</style></head>
<body>
END
                for theme in "${__themes[@]}"
                do
                    read name c0 c1 c2 c3 c4 c5 c6 c7 \
                              c8 c9 cA cB cC cD cE cF \
                              cbg cfg <<<"$theme"
                    cat >>"$file" <<END
    <table style="background:#$cbg" width="100%">
    <tr><td width="300px">
    <table cellspacing="5px" class="pal">
    <tr>
        <td style="color:#$cfg" colspan="8">$name</td>
    </tr>
    <tr>
        <td style="background:#$c0">&nbsp;</td>
        <td style="background:#$c1">&nbsp;</td>
        <td style="background:#$c2">&nbsp;</td>
        <td style="background:#$c3">&nbsp;</td>
        <td style="background:#$c4">&nbsp;</td>
        <td style="background:#$c5">&nbsp;</td>
        <td style="background:#$c6">&nbsp;</td>
        <td style="background:#$c7">&nbsp;</td>
    </tr>
    <tr>
        <td style="background:#$c8">&nbsp;</td>
        <td style="background:#$c9">&nbsp;</td>
        <td style="background:#$cA">&nbsp;</td>
        <td style="background:#$cB">&nbsp;</td>
        <td style="background:#$cC">&nbsp;</td>
        <td style="background:#$cD">&nbsp;</td>
        <td style="background:#$cE">&nbsp;</td>
        <td style="background:#$cF">&nbsp;</td>
    </tr>
    </table>
    </td>
    <td style="background:#$cbg; color:#$cfg; width: 20em" rowspan="2"><pre
><span style="color:#$c8; font-weight:bold;">#</span>
<span style="color:#$c8; font-weight:bold;"># Comment</span>
<span style="color:#$c8; font-weight:bold;">#</span>
<span style="color:#$cA; font-weight:bold;">def</span> <span
    style="color:#$c6">function</span>(arg):
    <span style="color:#$c4">"""Doctring</span>
    <span style="color:#$c4"></span>
    <span style="color:#$c4">"""</span>
    x = <span style="color:#$c3">14.5</span>
    <span style="color:#$cA; font-weight:bold;">return</span> x
</pre></td>
    </tr></table>
END
                done
                cat >>"$file" <<END
</body>
</html>
END
                ${BROWSER-firefox} ~/.bash/color-preview.html
            else
                local code="$(
                    for theme in "${__themes[@]}"
                    do
                        read name c0 c1 c2 c3 c4 c5 c6 c7 \
                                  c8 c9 cA cB cC cD cE cF \
                                  cbg cfg <<<"$theme"
                        if [ "$name" = "$sought" ]
                        then
                            echo "export __c0=$c0 __c1=$c1 __c2=$c2 __c3=$c3"
                            echo "export __c4=$c4 __c5=$c5 __c6=$c6 __c7=$c7"
                            echo "export __c8=$c8 __c9=$c9 __cA=$cA __cB=$cB"
                            echo "export __cC=$cC __cD=$cD __cE=$cE __cF=$cF"
                            echo "export __cbg=$cbg __cfg=$cfg"
                        fi
                    done
                )"
                $code
                echo -en "\033]4;0;#$__c0\007"
                echo -en "\033]4;1;#$__c1\007"
                echo -en "\033]4;2;#$__c2\007"
                echo -en "\033]4;3;#$__c3\007"
                echo -en "\033]4;4;#$__c4\007"
                echo -en "\033]4;5;#$__c5\007"
                echo -en "\033]4;6;#$__c6\007"
                echo -en "\033]4;7;#$__c7\007"
                echo -en "\033]4;8;#$__c8\007"
                echo -en "\033]4;9;#$__c9\007"
                echo -en "\033]4;10;#$__cA\007"
                echo -en "\033]4;11;#$__cB\007"
                echo -en "\033]4;12;#$__cC\007"
                echo -en "\033]4;13;#$__cD\007"
                echo -en "\033]4;14;#$__cE\007"
                echo -en "\033]4;15;#$__cF\007"
                echo -en "\033]10;#$__cfg;#$__cbg\007"
            fi
            ;;
    esac
}

# Check if it's the linux framebuffer, otherwise assume we have a
# 256-colour terminal emulator we can use.
__cs="$(tput colors 2>/dev/null)"
export LIGHTBG="$(cat $HOME/.config/managed/.light-theme 2>&- || echo 0)"
if [[ "$TERM" = "linux" ]]
then
    source "$HOME/.bash/color-low.bash"
    sleep 1; tput clear
else
    source "$HOME/.bash/color-high.bash"
fi
