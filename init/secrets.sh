#!/usr/bin/env bash

SECRETS_DIR="$HOME/.secrets"
SECRETS_FILE="$SECRETS_DIR/chezmoi-secrets.toml"

if [ ! -f $SECRETS_FILE ]; then
  # it's fine if we're missing keys under .secrets
  # because we set to ignore missing keys in chezmoi config
  # The exception is the top level secrets key
  mkdir -p $SECRETS_DIR
  chmod 700 $SECRETS_DIR
  echo '[secrets]' > $SECRETS_FILE
fi

# also setup a local.toml, it's not for secrets but i'm doing basically the same thing
CHEZMOI_PATH=`chezmoi source-path`
LOCAL_FILE="$CHEZMOI_PATH/.chezmoidata/local.toml"
if [ ! -f $LOCAL_FILE ]; then
  # it's fine if we're missing keys under .secrets
  # because we set to ignore missing keys in chezmoi config
  # The exception is the top level secrets key
  echo '[local]' > $LOCAL_FILE
fi
