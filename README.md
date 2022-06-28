# Twitter data collection for all MPs of France's XVI'th legislature

## Install

- Create a `gazouilloire` user

- Install [pyenv](https://github.com/pyenv/pyenv-installer)

- Install ElasticSearch 7 & Kibana

- Install a python3 virtualenv with gazouilloire:

```
pyenv install 3.9.13
pyenv virtualenv 3.9.13 gazouilloire-deputes
pip install -U pip
pip install gazouilloire minet
```

- Clone this repository as well as the one with the list of MP's Twitter accounts:

```
git clone https://github.com/medialab/tweets-deputes-LEG16.git
cd tweets-deputes-LEG16
git clone https://github.com/regardscitoyens/twitter-parlementaires
```

- Setup cronjobs with `crontab -e`:

```
# m h  dom mon dow  command

@reboot             bash /home/gazouilloire/deputes-2022/update_deputes.sh
15  4   */2 *   *   bash /home/gazouilloire/deputes-2022/update_deputes.sh
```

