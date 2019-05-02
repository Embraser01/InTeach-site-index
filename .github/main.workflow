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

workflow "Scrap sites" {
  resolves = ["Scrap InTeach - Blog", "Scrap InTeach - Docs"]
  on = "schedule(0 0 * * *)"
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

workflow "Force site build" {
  on = "schedule(5 * * * *)"
  resolves = ["HTTP client"]
}

action "HTTP client" {
  uses = "swinton/httpie.action@8ab0a0e926d091e0444fcacd5eb679d2e2d4ab3d"
  args = "POST https://api.netlify.com/build_hooks/$HOOK_ID"
  secrets = ["HOOK_ID"]
}
