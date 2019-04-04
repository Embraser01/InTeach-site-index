# Docsearch-scraper-action

This is a Github action used to generate an _Algolia_ index from a website using
[docsearch-scraper](https://github.com/algolia/docsearch-scraper).

## Usage

Executes each  listed in the Action's `args` via `sh -c`.

```
action "Generate index" {
  uses = "Embraser01//sh@master"
  args = ["run  -ltr"]
}
```

## License
