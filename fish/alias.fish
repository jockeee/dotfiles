##
## ALIAS
##

alias l 'ls -l'
alias la 'ls -lA'
alias laz 'ls -laZ'

alias bat 'bat -p'
if command -q /usr/bin/eza
  alias ls 'eza -g --git'
  alias tree 'eza -aT --git-ignore'
end


##
## ABBREVIATIONS
##

# c<space> to see it in action
abbr --add c 'bat'
abbr --add v 'vim'
abbr --add t 'tmux'
abbr --add tm 'tmux'
abbr --add g 'git'

if command -q /usr/bin/btop
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
## FUNCTIONS
##

# you like batdiff, it shows all changed files if no filename is given.
# you like the output, very readable for quick overview.
function batdiff
  git diff --name-only --relative --diff-filter=d $argv | xargs bat --diff
end
abbr --add bd 'batdiff'

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
  switch (grep -E "^ID=" /etc/os-release | cut -d= -f2)
    case 'fedora'
      if command -q /usr/bin/dnf5
        alias dnf 'dnf5'
      end

      function upd -d 'system update, flatpak apps update, fisher plugins update'
        echo -e '\e[1mUpdating system\e[0m'
        sudo dnf upgrade -y
        echo
        if command -q /usr/bin/flatpak
          echo -e '\e[1mUpdating flatpak apps\e[0m'
          /usr/bin/flatpak update
          echo
        end
        if functions -q fisher
          echo -e '\e[1mUpdating fisher plugins\e[0m'
          fisher update 1>/dev/null
          echo
        end
        if command -q /usr/local/bin/npm
          echo -e '\e[1mUpdating npm (globally)\e[0m'
          sudo /usr/local/bin/npm install -g npm@latest
          echo
          echo "NPM version: $(/usr/local/bin/npm --version)"
          echo
        end
      end
    case 'ubuntu'
      function upd -d 'system update, snap apps update, fisher plugins update'
        if command -q /usr/bin/apt
          echo -e '\e[1mUpdating system\e[0m'
          sudo /usr/bin/apt update
          sudo /usr/bin/apt full-upgrade -y
          sudo /usr/bin/apt autoremove -y
          echo
        end
        if command -q /usr/bin/snap
          echo -e '\e[1mUpdating snap apps\e[0m'
          sudo /usr/bin/snap refresh    # requires sudo unless authenticated to an Ubuntu One/SSO account
        end
        if functions -q fisher
          echo -e '\e[1mUpdating fisher plugins\e[0m'
          fisher update 1>/dev/null
          echo
        end
        if command -q /usr/local/bin/npm
          echo -e '\e[1mUpdating npm (globally)\e[0m'
          sudo /usr/local/bin/npm install -g npm@latest
          echo
          echo "NPM version: $(/usr/local/bin/npm --version)"
          echo
        end
      end
  end
end

