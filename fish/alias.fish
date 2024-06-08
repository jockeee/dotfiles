##
## Alias
##

# ls options
#   -A, --almost-all: do not list implied . and ..
alias l 'ls -l'
alias la 'ls -la'
alias lad 'ls -lad'
alias laz 'ls -laZ'

if command -q bat
  alias bat 'bat -p'
end

if command -q batcat
  alias bat 'batcat -p'
end

if command -q eza
  # Filtering options
  #   Pass the -a, --all option twice to also show the . and .. directories.
  # Long view options
  #   -a, --all: show hidden and 'dot' files
  #   -g, --group: list each file’s group
  #   --git: list each file’s Git status, if tracked or ignored
  alias ls 'eza -g --git'
  alias la 'eza -gaa --git'
  alias tree 'eza -aT --git-ignore'
end


##
## Abbreviations
##

# c<space> to see it in action
abbr --add g 'git'
abbr --add t 'tmux'
abbr --add tm 'tmux'
abbr --add v 'vim'

if command -q bat; or command -q batcat
  abbr --add c 'bat'
else
  abbr --add c 'cat'
end

if command -q btop
  abbr --add top 'btop'
end

# tmux
# https://github.com/lewisacidic/fish-tmux-abbr
abbr --add ta 'tmux attach -t'
abbr --add tad 'tmux attach -d -t'
abbr --add ts 'tmux new-session -s'
abbr --add tl 'tmux list-sessions'
abbr --add tks 'tmux kill-session -t'

# git
# https://github.com/lewisacidic/fish-git-abbr
abbr --add ga 'git add'
abbr --add gc 'git commit -m'
abbr --add gcl 'git clone'
abbr --add gco 'git checkout'
abbr --add gd 'git diff'
abbr --add gf 'git fetch'
abbr --add gp 'git push'
abbr --add gpl 'git pull'
abbr --add gr 'git remote -v'
abbr --add grs 'git reset'
abbr --add grs! 'git reset --hard'
abbr --add gs 'git status'


##
## Functions
##

# You like the output of batdiff for quick overview.
if command -q bat
  function batdiff
    git diff --name-only --relative --diff-filter=d $argv | xargs bat --diff
  end
  abbr --add d 'batdiff'
end

# used by: gg function
# from   : https://github.com/oh-my-fish/oh-my-fish/blob/master/lib/git/git_is_repo.fish
function is_git_repo -d 'Check if directory is a repository'
  test -d .git
  or begin
    set -l info (command git rev-parse --git-dir --is-bare-repository 2>/dev/null)
    and test $info[2] = false
  end
end

# gg (git add, git commit, git push)
# usage: gg [commit message]
function gg -d 'git add, git commit, git push'
  if not is_git_repo
    echo 'Error: Unable to locate a Git repository.'
    return 1
  end

  set use_ai 0

  if test (count $argv) -eq 0
    if command -q aicommits
      set use_ai 1
    else
      echo "Usage: gg [commit message]"
      return 1
    end
  end

  if test $use_ai -eq 1
    # using aicomments
    # echo statements has bold text
    echo -e "\e[1mgit add -A\e[0m" && git add -A && \
    echo -e "\e[1maicommits\e[0m" && aicommits && \
    echo -e "\e[1mgit push\e[0m" && git push
  else
    # using user supplied commit message
    # echo statements has bold text
    echo -e "\e[1mgit add -A\e[0m" && git add -A && \
    echo -e "\e[1mgit commit -m \"$argv\"\e[0m" && git commit -m "$argv" && \
    echo -e "\e[1mgit push\e[0m" && git push
  end
end

# ww (git add, git commit, git push - whatthecommit.com)
# usage: ww accept
# like gg but random commit message from whatthecommit.com
function ww -d 'git add, git commit, git push - whatthecommit.com'
  if not is_git_repo
    echo 'Error: Unable to locate a Git repository.'
    return 1
  end

  if test (count $argv) -ne 1; or test "$argv[1]" != "accept"
      echo "Usage: ww accept"
      return 1
  end

  if ! command -q curl
    echo "Error: Unable to locate 'curl'"
    return 1
  end

  set message (command curl -s https://whatthecommit.com/index.txt)

  if test $status -ne 0
    echo "Error: Couldn't retrieve a commit message from 'whatthecommit.com'"
  end

  # echo statements has bold text
  echo -e "\e[1mgit add -A\e[0m" && git add -A && \
  echo -e "\e[1mgit commit -m \"$message\"\e[0m" && git commit -m "$message" && \
  echo -e "\e[1mgit push\e[0m" && git push
end

# upd (fedora/ubuntu)
if test -e /etc/os-release
  set os_id (grep -E "^ID=" /etc/os-release | cut -d= -f2)
  switch $os_id
    case 'fedora'
      if command -q /usr/bin/dnf5
        alias dnf 'dnf5'
      end

      function upd -d 'system update, flatpak apps update, fisher plugins update'
        echo -e '\e[1mUpdating system\e[0m'
        echo -e '\e[3msudo dnf upgrade\e[0m\n'
        sudo dnf upgrade -y
        echo
        if command -q /usr/bin/flatpak
          echo -e '\e[1mUpdating flatpak apps\e[0m'
          echo -e '\e[3mflatpak update\e[0m\n'
          /usr/bin/flatpak update -y
          echo
        end
        upd_fisher
        upd_go
        upd_npm
      end
    case 'ubuntu'
      function upd -d 'system update, snap apps update, fisher plugins update'
        if command -q /usr/bin/apt
          echo -e '\e[1mUpdating system\e[0m'
          echo -e '\e[3msudo apt update, sudo apt full-upgrade, sudo apt autoremove\e[0m\n'
          sudo /usr/bin/apt update
          sudo /usr/bin/apt full-upgrade -y
          sudo /usr/bin/apt autoremove -y
          echo
        end
        if command -q /usr/bin/snap
          echo -e '\e[1mUpdating snap apps\e[0m'
          echo -e '\e[3msudo snap refresh\e[0m\n'
          sudo /usr/bin/snap refresh    # requires sudo unless authenticated to an Ubuntu One/SSO account
          echo
        end
        upd_fisher
        upd_go
        upd_npm
      end
  end
end

function upd_fisher -d 'fisher update'
  if functions -q fisher
    echo -e '\e[1mUpdating fisher plugins\e[0m'
    echo -e '\e[3mfisher update\e[0m\n'
    fisher update 1>/dev/null
    # echo # above will not output anything unless there is an error
  end
end

function upd_npm -d 'npm update'
  if command -q /usr/local/bin/npm
    echo -e '\e[1mUpdating npm\e[0m'
    echo -e '\e[3msudo npm install -g npm@latest\e[0m'
    sudo /usr/local/bin/npm install -g npm@latest
    echo
    echo "NPM version: $(/usr/local/bin/npm --version)"
    echo
  end
  if functions -q nvm
    echo -e '\e[1mUpdating npm\e[0m'
    echo -e '\e[3mnvm use lts, npm install -g npm@latest\e[0m\n'
    nvm use lts
    npm install -g npm@latest
    echo
    echo "NPM version: $(npm --version)"
    echo
  end
end

function upd_go -d 'golang update'
  # example download url: https://go.dev/dl/go1.22.3.linux-amd64.tar.gz
  if command -q /usr/local/go/bin/go
    echo -e '\e[1mUpdating golang\e[0m'
    echo -e '\e[3mhttps://go.dev/dl\e[0m'
    echo

    # if neither curl nor wget found, exit
    if not command -q curl -a command -q wget
      echo "Error: Neither 'curl' nor 'wget' found"
      return 1
    end

    # if jq not found, exit 
    if not command -q jq
      echo "Error: 'jq' not found"
      return 1
    end

    # if sha256sum not found, exit
    if not command -q sha256sum
      echo "Error: 'sha256sum' not found"
      return 1
    end

    # if mktemp not found, exit
    if not command -q mktemp
      echo "Error: 'mktemp' not found"
      return 1
    end

    # if tar not found, exit
    if not command -q tar
      echo "Error: 'tar' not found"
      return 1
    end

    set os (uname -s | tr '[:upper:]' '[:lower:]')
    set arch (uname -m)
    if test $arch = 'x86_64'
      set arch 'amd64'
    end
    set kind 'archive'
    set download_url_base 'https://go.dev/dl/'

    # download json
    if command -q curl
      set go_dev_json (curl -s 'https://go.dev/dl/?mode=json')
    else
      set go_dev_json (wget -qO- 'https://go.dev/dl/?mode=json')
    end

    if test $status -ne 0
      echo "Error: Couldn't retrieve JSON response from 'https://go.dev/dl/?mode=json'"
      return 1
    end

    set current_go_version (/usr/local/go/bin/go version | awk '{print $3}')
    set latest_go_version (echo $go_dev_json | jq -r '.[0].version')

    set current_major (echo $current_go_version | sed 's/go//' | cut -d. -f1)
    set current_minor (echo $current_go_version | sed 's/go//' | cut -d. -f2)
    set current_patch (echo $current_go_version | sed 's/go//' | cut -d. -f3)

    set latest_major (echo $latest_go_version | sed 's/go//' | cut -d. -f1)
    set latest_minor (echo $latest_go_version | sed 's/go//' | cut -d. -f2)
    set latest_patch (echo $latest_go_version | sed 's/go//' | cut -d. -f3)

    set need_update 0
    if test $current_major -lt $latest_major
      set need_update 1
    else if test $current_major -eq $latest_major
      if test $current_minor -lt $latest_minor
        set need_update 1
      else if test $current_minor -eq $latest_minor
        if test $current_patch -lt $latest_patch
          set need_update 1
        end
      end
    end

    set selected_json (echo $go_dev_json | jq -r --arg os "$os" --arg arch "$arch" --arg kind "$kind" --arg version "$latest_go_version" '.[0].files[] | select(.os == $os and .arch == $arch and .kind == $kind and .version == $version)')

    if test -n "$selected_json"
      set download_filename (echo $selected_json | jq -r '.filename')
      set download_checksum (echo $selected_json | jq -r '.sha256')
    else
      echo "Error: Couldn't find the latest version for $os-$arch in the JSON response"
      return 1
    end

    if test $need_update -eq 1
      echo "Update available: $current_go_version -> $latest_go_version"
      echo

      # read -l -P "Do you want to update? [y/N]: " continue
      # if test $continue != "y" -a $continue != "Y"
      #   return 0
      # end
      # echo

      # check archive type based on filename
      switch $download_filename
      case '*.tar*'
        set archive_type 'tar'
      case '*'
        echo "Error: Unknown archive type, expected a tar archive"
        echo "Filename: $download_filename"
        return 1
      end

      # download go
      set temp_file "/tmp/tmp.golang_install"
      if command -q curl
        curl -L -o $temp_file "$download_url_base$download_filename"
      else
        wget -q --show-progress -O $temp_file "$download_url_base$download_filename"
      end

      if test $status -ne 0
        echo "Error: Download failed"
        if test -e $temp_file
          rm $temp_file
        end
        return 1
      end

      if not test -e $temp_file
        echo "Error: Couldn't find the downloaded archive"
        return 1
      end

      # verify checksum
      set checksum (sha256sum $temp_file | cut -d' ' -f1)
      if test $checksum != $download_checksum
        echo "Error: Checksum verification failed"
        rm $temp_file
        return 1
      end

      # update
      sudo rm -rf /usr/local/go
      sudo tar -C /usr/local -xf $temp_file

      if test $status -ne 0
        echo "Error: Archive extraction failed"
        sudo rm -rf /usr/local/go
        rm $temp_file
        return 1
      end

      rm $temp_file
    else
      echo "No update available"
    end

    echo
    echo "Go version: $(/usr/local/go/bin/go version | awk '{print $3}')"
    echo
  end
end

function install_go -d 'golang install'
  # example download url: https://go.dev/dl/go1.22.3.linux-amd64.tar.gz
  echo -e '\e[1mInstalling golang\e[0m'
  echo -e '\e[3mhttps://go.dev/dl\e[0m'
  echo

  # if neither curl nor wget found, exit
  if not command -q curl -a command -q wget
    echo "Error: Neither 'curl' nor 'wget' found"
    return 1
  end

  # if jq not found, exit 
  if not command -q jq
    echo "Error: 'jq' not found"
    return 1
  end

  # if sha256sum not found, exit
  if not command -q sha256sum
    echo "Error: 'sha256sum' not found"
    return 1
  end

  # if mktemp not found, exit
  if not command -q mktemp
    echo "Error: 'mktemp' not found"
    return 1
  end

  # if tar not found, exit
  if not command -q tar
    echo "Error: 'tar' not found"
    return 1
  end

  set os (uname -s | tr '[:upper:]' '[:lower:]')
  set arch (uname -m)
  if test $arch = 'x86_64'
    set arch 'amd64'
  end
  set kind 'archive'
  set download_url_base 'https://go.dev/dl/'

  # download json
  if command -q curl
    set go_dev_json (curl -s 'https://go.dev/dl/?mode=json')
  else
    set go_dev_json (wget -qO- 'https://go.dev/dl/?mode=json')
  end

  if test $status -ne 0
    echo "Error: Couldn't retrieve JSON response from 'https://go.dev/dl/?mode=json'"
    return 1
  end

  set latest_go_version (echo $go_dev_json | jq -r '.[0].version')
  set selected_json (echo $go_dev_json | jq -r --arg os "$os" --arg arch "$arch" --arg kind "$kind" --arg version "$latest_go_version" '.[0].files[] | select(.os == $os and .arch == $arch and .kind == $kind and .version == $version)')

  if test -n "$selected_json"
    set download_filename (echo $selected_json | jq -r '.filename')
    set download_checksum (echo $selected_json | jq -r '.sha256')
  else
    echo "Error: Couldn't find the latest version for $os-$arch in the JSON response"
    return 1
  end

  echo "Version available: $latest_go_version"
  echo

  read -l -P "Do you want to install Go? [y/N]: " continue
  if test $continue != "y" -a $continue != "Y"
    return 0
  end
  echo

  # check archive type based on filename
  switch $download_filename
  case '*.tar*'
    set archive_type 'tar'
  case '*'
    echo "Error: Unknown archive type, expected a tar archive"
    echo "Filename: $download_filename"
    return 1
  end

  # download go
  set temp_file (mktemp)
  if command -q curl
    curl -L -o $temp_file "$download_url_base$download_filename"
  else
    wget -q --show-progress -O $temp_file "$download_url_base$download_filename"
  end

  if test $status -ne 0
    echo "Error: Download failed"
    if test -e $temp_file
      rm $temp_file
    end
    return 1
  end

  if not test -e $temp_file
    echo "Error: Couldn't find the downloaded archive"
    return 1
  end

  # verify checksum
  set checksum (sha256sum $temp_file | cut -d' ' -f1)
  if test $checksum != $download_checksum
    echo "Error: Checksum verification failed"
    rm $temp_file
    return 1
  end

  # install
  sudo rm -rf /usr/local/go
  sudo tar -C /usr/local -xf $temp_file

  if test $status -ne 0
    echo "Error: Archive extraction failed"
    sudo rm -rf /usr/local/go
    rm $temp_file
    return 1
  end

  rm $temp_file

  echo
  echo "Go version: $(/usr/local/go/bin/go version | awk '{print $3}')"
  echo
end

function upd_bashrc -d 'update bashrc'
  echo -e '\e[1mUpdating ~/.bashrc\e[0m\n'

  if not test -e ~/.dotfiles/.bashrc
    echo "Error: Couldn't find ~/.dotfiles/.bashrc"
    return 1
  end

  # create backup
  if test -e ~/.bashrc
    cp ~/.bashrc ~/.bashrc.bak
  end

  # remove current additions
  sed -i '/# default distro ~\/.bashrc above/,$ d' ~/.bashrc
  if test $status -ne 0
    echo "Error: Couldn't clean ~/.bashrc from current additions."
    mv ~/.bashrc.bak ~/.bashrc
    return 1
  end

  # add new additions
  cat ~/.dotfiles/.bashrc >> ~/.bashrc
  if test $status -ne 0
    echo "Error: Couldn't update ~/.bashrc"
    mv ~/.bashrc.bak ~/.bashrc
    return 1
  end

  # no source, we are in fish
  # source ~/.bashrc

  rm -f ~/.bashrc.bak

  echo "Version: $(grep -E "^# VERSION" ~/.bashrc | cut -d' ' -f3)"
end
