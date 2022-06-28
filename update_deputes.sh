#!/bin/bash

# Go to this directory
cd $(dirname $0)
source config.inc

# Load PyEnv + activate dedicated gazouilloire environment
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"    # if `pyenv` is not already on PATH
eval "$(pyenv init --path)"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"
export PYENV_VIRTUALENV_DISABLE_PROMPT=1
pyenv activate gazouilloire-deputes

# Update list MPs Twitter accounts and generate lists by sex
cd twitter-parlementaires
git pull
MEN_ACCOUNTS=$(grep ',"H",' data/deputes.csv |
 sed 's/,.*$/,/'            |
 sed 's/^"/"@/'             |
 tr "\n" " "                |
 sed 's/, $//'
)
WOMEN_ACCOUNTS=$(grep ',"F",' data/deputes.csv |
 sed 's/,.*$/,/'            |
 sed 's/^"/"@/'             |
 tr "\n" " "                |
 sed 's/, $//'
)

# Update First collect's config with men's accounts and restart it
cd ../part-1
sed "s/##MEN_ACCOUNTS##/$MEN_ACCOUNTS/" config.json.template > config-passwordless.json
sed "s/##USER##/$USER1/" config-passwordless.json   |
 sed "s/##KEY##/$KEY1/"                             |
 sed "s/##SECRET##/$SECRET1/"                       |
 sed "s/##OAUTHTOKEN##/$OAUTHTOKEN1/"               |
 sed "s/##OAUTHSECRET##/$OAUTHSECRET1/" > config.json
gazou restart -t 3000

# Update Second collect's config with women's accounts and restart it
cd ../part-2
sed "s/##WOMEN_ACCOUNTS##/$WOMEN_ACCOUNTS/" config.json.template > config-passwordless.json
sed "s/##USER##/$USER2/" config-passwordless.json   |
 sed "s/##KEY##/$KEY2/"                             |
 sed "s/##SECRET##/$SECRET2/"                       |
 sed "s/##OAUTHTOKEN##/$OAUTHTOKEN2/"               |
 sed "s/##OAUTHSECRET##/$OAUTHSECRET2/" > config.json
gazou restart -t 3000

