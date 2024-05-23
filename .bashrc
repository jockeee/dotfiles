# default distro ~/.bashrc above

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
  echo -e '\e[3msudo dnf upgrade\e[0m\n'
  sudo dnf upgrade -y
  echo
  if type -P /usr/bin/flatpak &>/dev/null; then
    echo -e '\e[1mUpdating flatpak apps\e[0m'
    echo -e '\e[3mflatpak update\e[0m\n'
    /usr/bin/flatpak update
    echo
  fi
  upd_npm
  upd_go
}

upd_ubuntu() {
  echo -e '\e[1mUpdating system\e[0m'
  echo -e '\e[3msudo apt update, sudo apt full-upgrade, sudo apt autoremove\e[0m\n'
  sudo apt update
  sudo apt full-upgrade -y
  sudo apt autoremove -y
  echo
  if type -P /usr/bin/snap &>/dev/null; then
    echo -e '\e[1mUpdating snap apps\e[0m'
    echo -e '\e[3msudo snap refresh\e[0m\n'
    sudo /usr/bin/snap refresh    # requires sudo unless authenticated to a Ubuntu One/SSO account
    echo
  fi
  upd_npm
  upd_go
}

upd_npm() {
  if type -P /usr/local/bin/npm &>/dev/null; then
    echo -e '\e[1mUpdating npm (globally)\e[0m'
    echo -e '\e[3msudo npm install -g npm@latest\e[0m'
    sudo /usr/local/bin/npm install -g npm@latest
    echo
    echo "NPM version: $(/usr/local/bin/npm --version)"
    echo
  fi
}

upd_go() {
  if type -P /usr/local/go/bin/go &>/dev/null; then
    echo -e '\e[1mUpdating Go\e[0m'
    echo -e '\e[3mhttps://go.dev/dl\e[0m'
    echo

    os = $(uname -s | tr '[:upper:]' '[:lower:]')
    arch = $(uname -m)
    if [ $arch == 'x86_64' ]; then
      arch = 'amd64'
    fi
    kind = 'archive'
    download_url_base = 'https://golang.org/dl/'
    go_dev_json = $(curl -s https://go.dev/dl/?mode=json)

    current_go_version = $(/usr/local/go/bin/go version | awk '{print $3}')
    latest_go_version = $(echo $go_dev_json | jq -r '.[0].version')

    current_major = $(echo $current_go_version | sed 's/go//' | cut -d. -f1)
    current_minor = $(echo $current_go_version | sed 's/go//' | cut -d. -f2)
    current_patch = $(echo $current_go_version | sed 's/go//' | cut -d. -f3)

    latest_major = $(echo $latest_go_version | sed 's/go//' | cut -d. -f1)
    latest_minor = $(echo $latest_go_version | sed 's/go//' | cut -d. -f2)
    latest_patch = $(echo $latest_go_version | sed 's/go//' | cut -d. -f3)

    need_update = false
    if [ $current_major -lt $latest_major ]; then
      need_update = true
    elif [ $current_major -eq $latest_major ]; then
      if [ $current_minor -lt $latest_minor ]; then
        need_update = true
      elif [ $current_minor -eq $latest_minor ]; then
        if [ $current_patch -lt $latest_patch ]; then
          need_update = true
        fi
      fi
    fi

    selected_json = $(echo $go_dev_json | jq -r --arg os "$os" --arg arch "$arch" --arg kind "$kind" --arg version "$latest_go_version" '.[0].files[] | select(.os == $os and .arch == $arch and .kind == $kind and .version == $version)')

    # if selected_json isn't empty, set download_filename and download_checksum
    if [ -n "$selected_json" ]; then
      download_filename = $(echo $selected_json | jq -r '.filename')
      download_checksum = $(echo $selected_json | jq -r '.sha256')
    else
      echo "Error: Couldn't find the latest version for $os-$arch in the JSON response."
      return 1
    fi

    if [ $need_update == true ]; then
      echo "Update available: $current_go_version -> $latest_go_version"
      
      # ask user to continue
      read -p "Do you want to update? [y/N] " -n 1 -r
      if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        return 0
      fi

      # user wants to update
      # make a temp file
      temp_file = $(mktemp) || return 1 # /tmp/tmp.XXXXXXXXXX

      # download
      curl -sL -o $temp_file $download_url_base$download_filename

      # verify checksum
      checksum = $(sha256sum $temp_file | cut -d' ' -f1)
      if [ $checksum != $download_checksum ]; then
        echo "Error: Checksum verification failed."
        rm $temp_file
        return 1
      fi

      # rmeove the old go directory
      sudo rm -rf /usr/local/go

      # extract the archive
      sudo tar -C /usr/local -xzf $temp_file

      rm $temp_file
    else
      echo "No update available"
    fi

    echo
    echo "Go version: $(/usr/local/go/bin/go version)"
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
