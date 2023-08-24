echo standard format
for i in {0..255}; do echo -en "\e[38;05;${i}m $(printf '%3d' $i)\e[0m"; done; echo
echo tput
for i in {0..255}; do echo -n "$(tput setaf $i) $(printf '%3d' $i)$(tput sgr0)"; done; echo
