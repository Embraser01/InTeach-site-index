workflow "Update Blog search index" {
  on = "repository_dispatch"
  resolves = ["Algolia scraper"]
}

action "Filter Dispatch event" {
  uses = "actions/bin/filter@master"
  args = "action do-index"
}

action "Algolia scraper" {
  uses = "Embraser01/docsearch-scraper-action@0.0.1"
  needs = ["Filter Dispatch event"]
  args = ["run /github/workspace/algolia-config.json"]
  secrets = ["API_KEY", "APPLICATION_ID"]
}
