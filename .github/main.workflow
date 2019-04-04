workflow "Update Blog search index" {
  on = "repository_dispatch"
  resolves = ["Algolia scraper"]
}

action "action-filter" {
  uses = "actions/bin/filter@master"
  args = "action do-index"
}

action "Algolia scraper" {
  uses = "./action-scraper"
  needs = ["action-filter"]
  secrets = ["API_KEY", "APPLICATION_ID"]
}
