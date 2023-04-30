#!/usr/bin/env zsh

main() {
  local XFILES_DIR="$HOME/.local/share/xfiles"
  local XFILES_CONFIG="$HOME/.config/xfiles"
  local BRANCH="main"

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
  
  git clone --depth 1 -b $BRANCH https://github.com/famiclone/xfiles "$XFILES_DIR" > /dev/null || { print "Installation was failed!" }

  echo '# Added by xfiles file manager' >> "$ZSHRC"
  echo '[ -f "$HOME/.local/share/xfiles/xfiles" ] && alias xfiles="$HOME/.local/share/xfiles/xfiles"' >> "$ZSHRC"

  print "xfiles installed!"

  return 0
}

main "$@"
