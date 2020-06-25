library(tic, warn.conflicts = FALSE)
source("./.app/tic/helpers.R")
deploy_branch <- ifelse(is_master_branch(), "gh-pages", "gh-preview")
output_format <- ifelse(is_master_branch() | is_hotfix_branch(), c("bookdown::gitbook", "bookdown::pdf_book"), "bookdown::gitbook")

# Stage: Before Install ---------------------------------------------------
get_stage("before_install") 

# Stage: Install ----------------------------------------------------------
get_stage("install") %>% 
    add_code_step(remotes::install_deps(repos = repo_default(), dependencies = TRUE))

# Stage: Before Script ----------------------------------------------------
get_stage("before_script")

# Stage: Script -----------------------------------------------------------
get_stage("script") 

# Stage: After Success ----------------------------------------------------
get_stage("after_success")

# Stage: After Failure ----------------------------------------------------
get_stage("after_failure") %>%
    add_code_step(print(sessioninfo::session_info(include_base = FALSE)))

# Stage: Before Deploy ----------------------------------------------------
get_stage("before_deploy") %>%
    add_step(step_install_cran("fs")) %>% 
    add_step(step_setup_ssh(private_key_name = "TIC_DEPLOY_KEY")) %>% 
    add_step(step_setup_push_deploy(path = "_book", branch = deploy_branch, remote_url = NULL, orphan = FALSE, checkout = TRUE))

# Stage: Deploy -----------------------------------------------------------
get_stage("deploy") %>%
    add_code_step(setwd("./manuscript")) %>% 
    add_step(step_build_bookdown(input = "index.Rmd", output_format = output_format, output_dir = "_book")) %>%
    add_code_step(setwd("..")) %>% 
    add_code_step(unlink(c("./README.Rmd", "./.gitigore"), force = TRUE)) %>% 
    add_code_step(fs::dir_copy("./manuscript/_book", "./_book", overwrite = TRUE)) %>% 
    add_step(step_do_push_deploy(path = "_book", commit_message = NULL, commit_paths = "."))

# Stage: After Deploy -----------------------------------------------------
get_stage("after_deploy")
