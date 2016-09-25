#!/usr/bin/env bash

if [ "${TRAVIS_PULL_REQUEST}" != "false" ]; then
    echo "Not deploying pull request."
    exit
fi

echo -e "\nRunning Travis Deployment"
echo "Setting up Git Access"
git remote set-url origin "https://${GH_TOKEN}:@github.com/Mandaryn/swinginlodz.git"
git config --global user.name ${GH_COMMIT_AUTHOR}
git config --global user.email ${GH_COMMIT_EMAIL}
bundle exec rake deploy
