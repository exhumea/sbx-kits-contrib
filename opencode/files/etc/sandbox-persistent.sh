# cf. <https://github.com/anomalyco/opencode/issues/49796>
# cf. <README.md> and <grafana/grafana.dockerfile>
# <!> does NOT work for startup when putting in /etc/profile.d/
if ! [[ "${NO_PROXY:-}" == *"0.0.0.0"* ]]; then
  export NO_PROXY="${NO_PROXY:+$NO_PROXY,}0.0.0.0"
  export no_proxy="$NO_PROXY"
fi

# avoid telemetry on various tools
export DO_NOT_TRACK=1

# headless Qt (for QGIS especially)
export QT_QPA_PLATFORM=offscreen

# QGIS variables
export QGIS_PREFIX_PATH=/usr
export PYTHONPATH=/usr/share/qgis/python${PYTHONPATH:+:$PYTHONPATH}

# snippets from /etc/profile also needed for non-login shells (esp. bash-completion, including git-prompt)
export NODE_EXTRA_CA_CERTS=/etc/ssl/certs/ca-certificates.crt

if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# ref: <https://git-scm.com/book/en/v2/Appendix-A:-Git-in-Other-Environments-Git-in-Bash>
GIT_PS1_SHOWDIRTYSTATE=1
GIT_PS1_SHOWUNTRACKEDFILES=1
GIT_PS1_SHOWCONFLICTSTATE=1
#GIT_PS1_SHOWUPSTREAM=git
GIT_PS1_SHOWCOLORHINTS=1 # should use PROMPT_COMMAND logic instead

PS1='\[\e[1;38;5;7m\]\u@\[\e[38;5;9m\]\h\[\e[0m\]:\[\e[38;5;178m\]\w\[\e[0m\]$(__git_ps1 " (%s) ")$ '

# needed for opencode integrated shell to also have these aliases
shopt -s expand_aliases

if [ -f /etc/bash.bash_aliases ]; then
  . /etc/bash.bash_aliases
fi
