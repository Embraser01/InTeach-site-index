workflow "Update Blog search index" {
  on = "repository_dispatch"
  resolves = ["Algolia scraper"]
}

action "action-filter" {
  uses = "actions/bin/filter@master"
  args = "action do-index"
}

action "Algolia scraper" {
  uses = "docker://algolia/docsearch-scraper"
  needs = ["action-filter"]
  args = "--env-file=env -e \"CONFIG=$(cat docsearch.json | jq -r tostring)\" "
}
