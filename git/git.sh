#!/bin/bash

successfully() {
  $* || (echo "failed" 1>&2 && exit 1)
}

echo " Enter a username to use for git ... (eg. krimkus)"
  successfully read USERNAME
echo " Enter an e-mail to use for git ... (eg. krimkus@gmail.com)"
  successfully read EMAIL_ADDRESS

echo "Checking for SSH key, generating one if it doesn't exist ..."
  [[ -f ~/.ssh/id_rsa.pub ]] || ssh-keygen -t rsa -C "$EMAIL_ADDRESS" -f ~/.ssh/id_rsa

echo "Setting git global defaults..."
  git config --global user.name $USERNAME
  git config --global user.email $EMAIL_ADDRESS
  git config --global push.default simple
  git config --global core.excludesfile $DIR/git/.gitignore_global
  git config --global color.ui true

