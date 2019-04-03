workflow "Update Blog search index" {
  on = "repository_dispatch"
  resolves = ["Algolia scraper"]
}

action "action-filter" {
  uses = "actions/bin/filter@master"
  args = "action do-index"
}

action "Touch env" {
  uses = "actions/bin/sh@master"
  needs = ["action-filter"]
  args = ["touch .env"]
}

action "Algolia scraper" {
  uses = "docker://algolia/docsearch-scraper"
  needs = ["Touch env"]
  args = "--env-file .env"
}
