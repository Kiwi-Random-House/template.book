# high level steps --------------------------------------------------------
build_steps <- function(stage){
    stage %>%
        add_message(c(add_hashtag_line(), "\n## Build\n", add_hashtag_line())) %>%
        add_code_step(devtools::document(quiet = TRUE)) %>%
        add_step(step_rcmdcheck(error_on = "error"))
}

test_steps <- function(stage){
    stage %>%
        add_message(c(add_hashtag_line(), "\n## Test\n", add_hashtag_line())) %>%
        add_code_step(devtools::load_all(export_all = FALSE)) %>%
        add_code_step(testthat::test_dir("./tests/testthat"))
}

deploy_steps <- function(stage){
    stage %>%
        add_message(c(add_hashtag_line(), "\n## Deploy\n", add_hashtag_line())) %>%
        add_step(step_build_pkgdown())
}

# low level steps ---------------------------------------------------------
add_message <- function(stage, msg){
    expression <- c("stage %>% add_code_step(", paste0("message(\"", paste0(msg, collapse = ""),"\")", collapse = ""), ")")
    eval(parse(text = expression))
}

# branches wrappers -------------------------------------------------------
is_master_branch <- function() "master" %in% ci_get_branch()
is_develop_branch <- function() "develop" %in% ci_get_branch()
is_feature_branch <- function() grepl("feature", ci_get_branch())
is_hotfix_branch <- function() grepl("hotfix", ci_get_branch())
is_release_branch <- function() grepl("release", ci_get_branch())

# helper functions --------------------------------------------------------
ci_get_job_name <- function() tolower(paste0(Sys.getenv("TRAVIS_JOB_NAME"), Sys.getenv("APPVEYOR_JOB_NAME")))
add_hashtag_line <- function() paste0(rep("#", 20), collapse = "")

