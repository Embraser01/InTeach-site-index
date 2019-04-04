workflow "Update Blog search index" {
  on = "repository_dispatch"
  resolves = ["Algolia scraper"]
}

action "action-filter" {
  uses = "actions/bin/filter@master"
  args = "action do-index"
}

action "Algolia scraper" {
  uses = "Embraser01/docsearch-scraper-action@0.0.1"
  args = ["run /github/workspace/algolia-config.json"]
}
