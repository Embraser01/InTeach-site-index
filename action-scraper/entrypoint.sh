#!/usr/bin/env bash

cd /root/docsearch-scraper

pipenv run ./docsearch $GITHUB_WORKSPACE/algolia-config.json
