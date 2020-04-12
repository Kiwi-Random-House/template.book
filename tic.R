library(tic, warn.conflicts = FALSE)
source("./AppData/tic/helpers.R")
deploy_branch <- ifelse(is_master_branch(), "gh-pages", "gh-preview")

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
    add_step(step_setup_ssh(private_key_name = "TIC_DEPLOY_KEY")) %>% 
    add_step(step_setup_push_deploy(branch = deploy_branch))

# Stage: Deploy -----------------------------------------------------------
get_stage("deploy") %>%
    add_step(step_build_bookdown(input = "", output_format = "all", output_dir = "_book")) %>% 
    add_code_step(print(list.dirs())) %>% 
    add_step(step_do_push_deploy("_book"))

# Stage: After Deploy -----------------------------------------------------
get_stage("after_deploy")
