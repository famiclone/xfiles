#!/usr/bin/env zsh

main() {
  local XFILES_DIR="$HOME/.local/share/xfiles"
  local XFILES_CONFIG="$HOME/.config/xfiles"

  [[ -d "$XFILES_DIR" ]] && {
    print "Xfiles directory exists"
    exit
  }

  ! [[ -d "$XFILES_CONFIG" ]] && {
    print "No xfilesrc file found, creating..."
    mkdir "$XFILES_CONFIG" &&
    touch "$XFILES_CONFIG"/xfilesrc &&
    echo "" > "$XFILES_CONFIG"/xfilesrc
    
    print "xfilesrc file created!"
  }
  
  git clone --depth 1 --branch main https://github.com/famiclone/xfiles "$XFILES_DIR" > /dev/null || { print "Installation was failed!" }

  #echo '# Added by xfiles file manager' >> "$ZSHRC"
  #echo '[ -f "$HOME/.local/share/xfiles/xfiles" ] && source "$HOME/.local/share/xfiles/xfiles"' >> "$ZSHRC"

  source "$ZSHRC"

  printf "xfiles v%s installed!\n" $(git tag | head -n1)

  return 0
}

main "$@"
