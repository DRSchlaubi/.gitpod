# GPG signing
if [ -n "$GPG_KEY" ]; then
  gpg --verbose --batch --import <(echo "$GPG_KEY" | base64 -d)

  # Fix for invalid ioctl device error
  GPG_TTY=$(tty)
  export GPG_TTY

  if [ -n "$GPG_PASSWORD" ]; then
    # make session never expire and enter password once
    echo "default-cache-ttl 34560000" >~/.gnupg/gpg-agent.conf
    echo "max-cache-ttl 34560000" >~/.gnupg/gpg-agent.conf
    echo "test" | gpg --clearsign --default-key "$GPG_KEY_ID" --passphrase "$GPG_PASSWORD"
  fi

  # enable git commit signing
  echo 'pinentry-mode loopback' >>~/.gnupg/gpg.conf
  git config --global user.signingkey "$GPG_KEY_ID"
  git config --global commit.gpgSign true
fi

# ZSH
if [ "$NO_ZSH" != "true" ]; then
  # switch to zsh
  sudo apt install zsh -y
  sudo chsh gitpod -s "$(which zsh)"

  # Fix GP alias
  alias pod=/usr/bin/gp

  # install ohmyzsh
  CHSH=no
  export CHSH # fix broken chsh check
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

  # install plugins
  git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
  echo "plugins+=zsh-autosuggestions" >>~/.zshrc
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
  echo "plugins+=zsh-syntax-highlighting" >>~/.zshrc
  git clone https://github.com/zsh-users/zsh-completions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-completions
  echo "fpath+=${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-completions/src" >>~/.zshrc

  # install powerlevel10k
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
  #curl -fsSL https://raw.githubusercontent.com/DRSchlaubi/.gitpod/main/.p10k.zsh -o ~/.p10k.zsh
  echo ZSH_THEME="powerlevel10k/powerlevel10k" >>~/.zshrc

  # reload oh-my-zsh instructions again
  echo "source $ZSH/oh-my-zsh.sh" >>~/.zshrc
fi
