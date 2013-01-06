#!/bin/bash

#for debugging and logging
#set -x
#exec &> /tmp/capture.log

if [[ $# -ne 1 ]]
then
    echo "Usage: ./deploy.sh <branch_name>"
    exit 1
fi

ENV="staging"
[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm"

cd /home/deploy/ruby_apps/TripleSundae
git stash save dirt-before-${1}
git reset HEAD --hard

start=`git log|head -1|cut -f 2 -d " "`
git fetch origin
git checkout ${1}
git pull origin ${1}

bundle install
bundle exec rake db:autoupgrade RAILS_ENV=staging
bundle exec rake assets:precompile RAILS_ENV=staging

thin -C config/staging.yml -e staging -R config.ru stop
thin -C config/staging.yml -e staging -R config.ru -d start

subject="[Build][Staging] TripleSundae"
echo "Deployed branch ${1}" > deployed.txt
echo "These are the commits which were rolled out just now:" >> deployed.txt
git log $start..HEAD >> deployed.txt

cat deployed.txt | mail -s "$subject" tech@reversehack.in
