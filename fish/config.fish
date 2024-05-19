if status is-interactive
  # set fish_greeting to empty = not showing
  set -U fish_greeting
  
  # $EDITOR
  set -Ux EDITOR '/usr/bin/vim'

  # remove underlines
  set fish_color_valid_path                        # default: '--underline'
  set fish_pager_color_prefix 'normal' '--bold'    # default: 'normal'  '--bold'  '--underline'

  # add ~/.local/bin to $PATH
  if test -d $HOME/.local/bin
    fish_add_path $HOME/.local/bin
  end
  
  # alias
  if test -f $HOME/.config/fish/alias.fish
    source $HOME/.config/fish/alias.fish
  end

  # zoxide, smarter cd
  if command -q /usr/bin/zoxide
    zoxide init --cmd cd fish | source
  end
end
