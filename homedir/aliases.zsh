#!/bin/sh

alias git=hub

# Easier navigation: .., ~ and -
alias ..="cd .."
alias ~="cd ~"
alias desktop="cd ~/Desktop"

# python
alias ipy="ipython"
alias jn="jupyter notebook"
alias pipdeps="pip install -U --force --no-deps ."
alias f8="flake8"
alias wk="workon"

# similar to workon for non-python
alias ws="cd ~/WorkSpace && cd"

# Utilities
alias mdiff="mvim -d"

alias history="mvim ~/.zsh_history"

# Empty the Trash on all mounted volumes and the main HDD.
# Also, clear Apple’s System Logs to improve shell startup speed.
# Finally, clear download history from quarantine. https://mths.be/bum
alias emptytrash="sudo rm -rfv /Volumes/*/.Trashes; sudo rm -rfv ~/.Trash; sudo rm -rfv /private/var/log/asl/*.asl; sqlite3 ~/Library/Preferences/com.apple.LaunchServices.QuarantineEventsV* 'delete from LSQuarantineEvent'"

# Directory listings
LS_COLORS='no=01;37:fi=01;37:di=07;96:ln=01;36:pi=01;32:so=01;35:do=01;35:bd=01;33:cd=01;33:ex=01;31:mi=00;05;37:or=00;05;37:'
# -G Add colors to ls
# -l Long format
# -h Short size suffixes (B, K, M, G, P)
# -p Postpend slash to folders
alias ls='ls -G -h -p -a'
alias ll='ls -l -G -h -p -a '

# Print each PATH entry on a separate line
alias path='echo -e ${PATH//:/\\n}'

# Copy and paste and prune the usless newline
alias pbcopynn='tr -d "\n" | pbcopy'

alias gcp="gcloud config configurations activate"
alias gcprun='gcloud beta run deploy'

alias fs="fulfil-server --reload"

alias airscan="/System/Library/PrivateFrameworks/Apple80211.framework/Versions/A/Resources/airport"
alias ack=ag
