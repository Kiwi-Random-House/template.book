remotes::install_github("ropenscilabs/travis", quiet = TRUE)
remotes::install_cran("usethis", quiet = TRUE)

travis::auth_github()
travis::browse_travis_token()
