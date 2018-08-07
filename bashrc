export SHELL
[[ $- != *i* ]] && { [[ -n "$SSH_CLIENT" ]] && source /etc/profile; return; }

[[ -n "$GUIX_ENVIRONMENT" ]] && PS1='[env] \w ' || PS1='\w '

HISTCONTROL=ignoreboth
HISTFILE="$HOME/.bashlog"
HISTFILESIZE=8192
HISTSIZE=8192

export PATH="$HOME/bin${PATH:+:}$PATH"
export LESS=-imRS
export LESSHISTFILE=-
export GTK_IM_MODULE=uim
export QT_IM_MODULE=uim
export XMODIFIERS='@im=uim'

B_TMP="/tmp/_${USER}_tmp"
eval $(dircolors --sh "$HOME/.config/dircolors")
shopt -s checkwinsize
#stty -ixon # stop freezing in vim when ctrl-s
trap 'echo -ne "\e]2;$BASH_COMMAND\a"' DEBUG # dynamic title

alias cp='cp -iv'
alias mv='mv -iv'
alias rm='rm -i'
alias ls='ls --color=auto --time-style=long-iso'
alias l='ls -A'
alias ll='ls -lh'
alias lla='ll -a'
alias lls='ll -S'
alias llt='ll -t'
alias bc='rlwrap bc'
alias diff='diff --color'
alias dmesg='dmesg --color=always'
alias e='emacsclient -nc'
alias g=git
alias guile='rlwrap guile'
#alias lein='rlwrap lein'
alias pstree='pstree -hnp'
#alias rg='rg --colors match:fg:black --colors match:style:nobold --colors path:style:bold --colors line:fg:yellow'
alias tclsh='rlwrap tclsh'
alias sudo='sudo '
alias v=vim
alias 0clock='echo "$(date +%s)"; echo "  UTC:       $(TZ=UTC date)"; echo "* Prague:    $(date)"; echo "  London:    $(TZ=Europe/London date)"; echo "  Los Angls: $(TZ=America/Los_Angeles date)"; echo "  New York:  $(TZ=America/New_York date)"; echo "  Riyadh:    $(TZ=Asia/Riyadh date)"; echo "  Seoul:     $(TZ=Asia/Seoul date)"'
alias 0fonts="fc-list | sed 's/^.\+: //;s/:.\+$//;s/,.*$//' | sort -u | pr -2 -T"
alias 0ip='wget -qO - https://ipinfo.io/ip'
alias 0top-c="ps -Ao pcpu,stat,time,pid,cmd --sort=-pcpu,-time | sed '/^ 0.0 /d'"
alias 0top-d="du -kx | rg -v '\./.+/' | sort -rn"
alias 0top-m="ps -Ao rss,vsz,pid,cmd --sort=-rss,-vsz | awk '{if (\$1>5000) print;}'"
alias 0qmk-build='docker run -e keymap=agaric -e subproject=rev4 -e keyboard=planck --rm -v $HOME/src/qmk_firmware:/qmk:rw edasque/qmk_firmware'

c() { cd "$@" && \
  { local lim=256 count=$(ls --color=n | wc -l);
    [[ $count -gt $lim ]] \
      && echo "skipping ls ($count entries > $lim)" \
      || l; }; }
alias ,='c ..'
alias ,,='c ../..'
alias ,,,='c ../../..'
alias ,,,,='c ../../../..'
alias ,,,,,='c ../../../../..'

0qmk-flash()
{ [ -n "$1" ] \
  && { sudo dfu-programmer atmega32u4 erase \
  && sudo dfu-programmer atmega32u4 flash "$1" \
  && sudo dfu-programmer atmega32u4 reset; } \
  || echo 'no file given'; }
