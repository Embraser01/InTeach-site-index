#!/usr/bin/env bash

pwd

cd /root/docsearch-scraper
touch .env

pipenv install
pipenv run ./docsearch run $GITHUB_WORKSPACE/algolia-config.json
