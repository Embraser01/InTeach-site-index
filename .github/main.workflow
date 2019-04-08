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
  args = ["run /github/workspace/sites/inteach-blog.json"]
  secrets = ["API_KEY", "APPLICATION_ID"]
}

workflow "New workflow" {
  on = "schedule(0 0 * * *)"
  resolves = ["Scrap InTeach - Blog", "Scrap InTeach - Docs"]
}

action "Scrap InTeach - Blog" {
  uses = "./action-scraper"
  args = "run /github/workspace/sites/inteach-blog.json"
  secrets = ["API_KEY", "APPLICATION_ID"]
}

action "Scrap InTeach - Docs" {
  uses = "./action-scraper"
  args = "run /github/workspace/sites/inteach-docs.json"
  secrets = ["API_KEY", "APPLICATION_ID"]
}
