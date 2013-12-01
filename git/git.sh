#!/bin/bash

successfully() {
  $* || (echo "failed" 1>&2 && exit 1)
}

echo "Checking for SSH key, generating one if it doesn't exist ..."
if [ ! -f ~/.ssh/id_rsa.pub ]; then
  echo " Enter an e-mail to use for an ssh key ... (eg. krimkus@gmail.com)"
  successfully read EMAIL_ADDRESS
  ssh-keygen -t rsa -C "$EMAIL_ADDRESS" -f ~/.ssh/id_rsa
fi

echo "Setting git global defaults..."

if [ ! -n "$(git config --global user.name)" ]; then
  echo " Enter a username to use for git ... (eg. krimkus)"
  successfully read USERNAME
  git config --global user.name $USERNAME
fi

if [ ! -n "$(git config --global user.email)" ]; then
  if [ ! $EMAIL_ADDRESS ]; then
    echo " Enter an e-mail to use for git ... (eg. krimkus@gmail.com)"
    successfully read EMAIL_ADDRESS
  fi
  git config --global user.email $EMAIL_ADDRESS
fi

git config --global push.default simple
git config --global core.excludesfile $DIR/git/.gitignore_global
git config --global color.ui true
