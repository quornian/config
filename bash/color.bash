# Configures colours for the shell and sets colour-related options
# for some commands.
#

# A function for easily inserting colour escape sequences
# Example: "$(__cx '1;32')Bold, green Text$(__cx)"
__cx() { echo -en "\e[${1}m"; }

themes=(
"deep1      000000 AF0000 AFD700 FF8700 005F87 875F87 008787 AFAFAF \
            5F5F5F D70000 D7FF5F FFAF00 5FAFFF D75FFF 87D7D7 FFFFFF \
            000000 AFAFAF"
"deep2      000000 AF0000 AFD700 FF8700 5F87AF 875F87 008787 AFAFAF \
            5F5F5F D70000 D7FF5F FFAF00 5FAFFF D75FFF 87D7D7 FFFFFF \
            000000 AFAFAF"
"bright     3A3A3A AF5F5F AFD75F FF8700 00AFD7 D787AF 00AF87 D7D7D7 \
            5F5F5F D75F5F D7FF5F FFAF00 5FD7FF FF87D7 5FD7AF FFFFFF \
            3A3A3A D7D7D7"
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
"solarized  073642 DC322F 859900 B58900 268BD2 D33682 2AA198 EEE8D5 \
            002B36 CB4B16 586E75 657B83 839496 6C71C4 93A1A1 FDF6E3 \
            002B36 839496"
"sea        002B36 DC322F 2AA198 B58900 268BD2 6C71C4 2AA198 93A1A1 \
            586E75 DC322F 2AA198 B58900 268BD2 6C71C4 2AA198 FDF6E3 \
            002B36 839496"
"teal       0C1A1D AD7385 7BB674 ADA574 6A83B7 9C73B7 6AB6A7 7B8385 \
            464F50 C8B0BA B0D0B2 C8C8B2 A8B8D2 C0B0D2 A8D0CA C0C8CA \
            0C1A1D 7B8385"
)

set-theme() {
    local sought="$1"
    local code="$(
        for theme in "${themes[@]}"
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

    # Apply theme to gnome-terminal
    local profile="/apps/gnome-terminal/profiles/Default"
    local palette="#$__c0:#$__c1:#$__c2:#$__c3:#$__c4:#$__c5:#$__c6:#$__c7"
    palette="$palette:#$__c8:#$__c9:#$__cA:#$__cB:#$__cC:#$__cD:#$__cE:#$__cF"
    gconftool-2 --type string --set "$profile/background_color" "#$__cbg"
    gconftool-2 --type string --set "$profile/foreground_color" "#$__cfg"
    gconftool-2 --type string --set "$profile/palette" "$palette"
    gconftool-2 --type string --set "$profile/cursor_blink_mode" "off"

    # Apply theme to xterm
    cat >"$HOME/.Xresources" <<END
UXTerm*background: rgb:${__cbg:0:2}/${__cbg:2:2}/${__cbg:4:2}
UXTerm*foreground: rgb:${__cfg:0:2}/${__cfg:2:2}/${__cfg:4:2}
UXTerm*color0: rgb:${__c0:0:2}/${__c0:2:2}/${__c0:4:2}
UXTerm*color1: rgb:${__c1:0:2}/${__c1:2:2}/${__c1:4:2}
UXTerm*color2: rgb:${__c2:0:2}/${__c2:2:2}/${__c2:4:2}
UXTerm*color3: rgb:${__c3:0:2}/${__c3:2:2}/${__c3:4:2}
UXTerm*color4: rgb:${__c4:0:2}/${__c4:2:2}/${__c4:4:2}
UXTerm*color5: rgb:${__c5:0:2}/${__c5:2:2}/${__c5:4:2}
UXTerm*color6: rgb:${__c6:0:2}/${__c6:2:2}/${__c6:4:2}
UXTerm*color7: rgb:${__c7:0:2}/${__c7:2:2}/${__c7:4:2}
UXTerm*color8: rgb:${__c8:0:2}/${__c8:2:2}/${__c8:4:2}
UXTerm*color9: rgb:${__c9:0:2}/${__c9:2:2}/${__c9:4:2}
UXTerm*color10: rgb:${__cA:0:2}/${__cA:2:2}/${__cA:4:2}
UXTerm*color11: rgb:${__cB:0:2}/${__cB:2:2}/${__cB:4:2}
UXTerm*color12: rgb:${__cC:0:2}/${__cC:2:2}/${__cC:4:2}
UXTerm*color13: rgb:${__cD:0:2}/${__cD:2:2}/${__cD:4:2}
UXTerm*color14: rgb:${__cE:0:2}/${__cE:2:2}/${__cE:4:2}
UXTerm*color15: rgb:${__cF:0:2}/${__cF:2:2}/${__cF:4:2}
UXTerm*font: -*-fixed-medium-*-*-*-18-*-*-*-*-*-*-*
UXTerm*boldFont: -*-fixed-medium-*-*-*-18-*-*-*-*-*-*-*
UXTerm*boldMode: false
UXTerm*charClass: 33:48,35:48,37:48,43:48,45-47:48,64:48,95:48,126:48
UXTerm*scrollBar: false
END
    xrdb -merge "$HOME/.Xresources"

    # Apply theme to xfce terminal
    cat >"$HOME/.terminalrc" <<END
[Configuration]
FontName=Monospace 9
FontAntiAlias=FALSE
ColorBackground=#$__c0
ColorForeground=#$__c7
ColorCursor=#$__c7
ColorPalette1=#$__c0
ColorPalette2=#$__c1
ColorPalette3=#$__c2
ColorPalette4=#$__c3
ColorPalette5=#$__c4
ColorPalette6=#$__c5
ColorPalette7=#$__c6
ColorPalette8=#$__c7
ColorPalette9=#$__c8
ColorPalette10=#$__c9
ColorPalette11=#$__cA
ColorPalette12=#$__cB
ColorPalette13=#$__cC
ColorPalette14=#$__cD
ColorPalette15=#$__cE
ColorPalette16=#$__cF
MiscAlwaysShowTabs=FALSE
MiscBell=FALSE
MiscBordersDefault=FALSE
MiscCursorBlinks=FALSE
MiscCursorShape=TERMINAL_CURSOR_SHAPE_BLOCK
MiscDefaultGeometry=150x30
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
}

preview-themes() {
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
    for theme in "${themes[@]}"
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
}

# Check if it's the linux framebuffer, otherwise assume we have a
# 256-colour terminal emulator we can use.
__cs="$(tput colors 2>/dev/null)"
if [[ "$TERM" = "linux" ]]
then
    source "$HOME/.bash/color-low.bash"
    sleep 1; tput clear
else
    source "$HOME/.bash/color-high.bash"
fi
