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
  env = {
    CONFIG = "{\n  \"index_name\": \"blog-inteach-io\",\n  \"start_urls\": [\n    {\n      \"url\": \"https://admiring-einstein-bb643f.netlify.com/(?P<lang>.*?)/blog\",\n      \"variables\": {\n        \"lang\": [\n          \"en\",\n          \"fr\"\n        ]\n      }\n    }\n  ],\n  \"stop_urls\": [],\n  \"selectors\": {\n    \"lvl0\": \"main > header h1\",\n    \"lvl1\": \"main .post-content h1\",\n    \"lvl2\": \"main .post-content h2\",\n    \"lvl3\": \"main .post-content h3\",\n    \"lvl4\": \"main .post-content h4\",\n    \"lvl5\": \"main .post-content h5\",\n    \"text\": \"main .post-content p, main .post-content li\"\n  },\n  \"nb_hits\": 91\n}"
  }
  secrets = ["APPLICATION_ID", "API_KEY"]
}
