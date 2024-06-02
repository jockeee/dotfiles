if status is-interactive
  # set fish_greeting to empty = not showing
  set -U fish_greeting

  # $EDITOR
  set -Ux EDITOR '/usr/bin/vim'

  # remove underlines
  set fish_color_valid_path                        # default: '--underline'
  set fish_pager_color_prefix 'normal' '--bold'    # default: 'normal'  '--bold'  '--underline'

  # alias
  if test -f $HOME/.config/fish/alias.fish
    source $HOME/.config/fish/alias.fish
  end

  # $PATH: ~/.local/bin
  if test -d $HOME/.local/bin
    fish_add_path $HOME/.local/bin
  end

  # $PATH: /usr/local/go/bin
  if test -d /usr/local/go/bin
    fish_add_path /usr/local/go/bin
  end

  # $PATH: ~/go/bin
  if test -d $HOME/go/bin
    fish_add_path $HOME/go/bin
  end

  # $PATH: ~/.cargo/bin
  if test -d $HOME/.cargo/bin
    fish_add_path $HOME/.cargo/bin
  end

  # zoxide, smarter cd
  if command -q zoxide
    zoxide init --cmd cd fish | source
  end
end
