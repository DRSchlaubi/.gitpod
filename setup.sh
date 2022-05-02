# GPG signing commits
if [ -n "$GPG_KEY" ]; then
  gpg --verbose --batch --import <(echo "$GPG_KEY"|base64 -d)

  # Fix for invalid ioctl device error
  GPG_TTY=$(tty)
  export GPG_TTY

  if [ -n "$GPG_PASSWORD" ]; then
    # make session never expire and enter password once
    echo "default-cache-ttl 34560000" > ~/.gnupg/gpg-agent.conf
    echo "max-cache-ttl 34560000" > ~/.gnupg/gpg-agent.conf
    echo "test" | gpg --clearsign --default-key "$GPG_KEY_ID" --passphrase "$GPG_PASSWORD"
  fi

  # enable git commit signing
  echo 'pinentry-mode loopback' >> ~/.gnupg/gpg.conf
  git config --global user.signingkey "$GPG_KEY_ID"
  git config --global commit.gpgSign true
fi