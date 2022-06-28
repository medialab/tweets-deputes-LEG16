# Twitter data collection for all MPs of France's XVI'th legislature

## Install

- Create a `gazouilloire` user

- Install [pyenv](https://github.com/pyenv/pyenv-installer)

- Install ElasticSearch 7 & Kibana

- Install a python3 virtualenv with gazouilloire:

```
pyenv install 3.9.13
pyenv virtualenv 3.9.13 gazouilloire-deputes
pyenv activate gazouilloire-deputes
pip install -U pip
pip install gazouilloire
```

- Clone this repository as well as the one with the list of MP's Twitter accounts:

```
git clone https://github.com/medialab/tweets-deputes-LEG16.git
cd tweets-deputes-LEG16
git clone https://github.com/regardscitoyens/twitter-parlementaires
```

- Create `config.inc` and setup two sets of Twitter v1.1 API keys within:

```
cp config.inc{.example,}
vim config.inc
```

- Setup cronjobs with `crontab -e`:

```
# m h  dom mon dow  command

@reboot             bash /home/gazouilloire/deputes-2022/update_deputes.sh
15  4   */2 *   *   bash /home/gazouilloire/deputes-2022/update_deputes.sh
```

- Run data collection of the first 3200 tweets of all accounts using minet:

```
pyenv activate gazouilloire-deputes
pip install minet

minet twitter user-tweets -o 220624_first_accounts_tweets.csv -s twitter --total $(xsv count 220624_first_accounts.csv) twitter 220624_first_accounts.csv
gzip 220624_first_accounts_tweets.csv
```

