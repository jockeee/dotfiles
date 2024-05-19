# ... snip ... default distro ~/.bashrc above

##
## ALIAS
##

alias l='ls -l'
alias la='ls -lA'
alias laz='ls -laZ'
if type -P /usr/bin/eza &>/dev/null; then
  alias ls='eza -g --git'
fi
if type -P /usr/bin/btop &>/dev/null; then
  alias top='btop'
fi

# upd (fedora/ubuntu) - bash style

upd_fedora() {
  echo -e '\e[1mUpdating system\e[0m'
  sudo dnf upgrade -y
  echo
  if type -P /usr/bin/flatpak &>/dev/null; then
    echo -e '\e[1mUpdating flatpak apps\e[0m'
    /usr/bin/flatpak update
    echo
  fi
  if type -P /usr/local/bin/npm &>/dev/null; then
    echo -e '\e[1mUpdating npm (globally)\e[0m'
    sudo /usr/local/bin/npm install -g npm@latest
    echo
    echo "NPM version: $(/usr/local/bin/npm --version)"
    echo
  fi
}

upd_ubuntu() {
  echo -e '\e[1mUpdating system\e[0m'
  sudo apt update
  sudo apt full-upgrade -y
  sudo apt autoremove -y
  echo
  if type -P /usr/bin/snap &>/dev/null; then
    echo -e '\e[1mUpdating snap apps\e[0m'
    sudo /usr/bin/snap refresh    # requires sudo unless authenticated to an Ubuntu One/SSO account
  fi
  if type -P /usr/local/bin/npm &>/dev/null; then
    echo -e '\e[1mUpdating npm (globally)\e[0m'
    sudo /usr/local/bin/npm install -g npm@latest
    echo
    echo "NPM version: $(/usr/local/bin/npm --version)"
    echo
  fi
}

if [ -e /etc/os-release ]; then
  os_id=$(grep -E "^ID=" /etc/os-release | cut -d= -f2)
  
  case $os_id in
    'fedora')
      if type -P /usr/bin/dnf5 &>/dev/null; then
        alias dnf='dnf5'
      fi
      export -f upd_fedora
      alias upd='upd_fedora'
      ;;
    'ubuntu')
      export -f upd_ubuntu
      alias upd='upd_ubuntu'
      ;;
  esac
fi

# zoxide, smarter cd
if type -P /usr/bin/zoxide &>/dev/null; then
  eval "$(zoxide init bash)"
fi
