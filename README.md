# .gitpod

My Gitpod.io dotfiles

# GPG Signing

In order to setup GPG signing you need to set the following environment variables

| name | value |
|--|-------|
| `GPG_KEY` | `gpg --armor --export-secret-key <identifier> | base64 |
| `GPG_KEY_ID` | LONG id of the gpg key |

If you are using JetBrains you can also set `GPG_PASSWORD` as a workaround
for [CWM-4678](https://youtrack.jetbrains.com/issue/CWM-4678/You-cannot-sign-commits)

# ZSH theme

This uses an opinionated ZSH and powerlevel10k config, if you don't want to use it set `NO_ZSH=true`

## JetBrains Gateway

If you want to use JetBrains Gateway you need to [download these fonts](https://github.com/romkatv/powerlevel10k#fonts)
to your local machine
and [set them as the console font](https://www.jetbrains.com/help/idea/configuring-colors-and-fonts.html#fonts)
in the client
