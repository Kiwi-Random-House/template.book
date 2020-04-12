library(tic, warn.conflicts = FALSE)
source("./AppData/tic/helpers.R")

# Macros ------------------------------------------------------------------
do_bookdown(path = "./manuscript", branch = ifelse(is_master_branch(), "gh-pages", "gh-preview"))

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
# if(is_master_branch() | is_develop_branch())
#     get_stage("before_deploy") %>% 
#     add_code_step(blogdown::install_hugo()) %>% 
#     add_step(step_setup_ssh(private_key_name = "TIC_DEPLOY_KEY")) %>% 
#     add_step(step_setup_push_deploy(path = "public", branch = "gh-pages", remote_url = NULL, orphan = FALSE, checkout = TRUE))

# Stage: Deploy -----------------------------------------------------------
# if(is_master_branch() | is_develop_branch())
#     get_stage("deploy") %>% 
#     add_step(step_build_blogdown()) %>% 
#     add_step(step_do_push_deploy(path = "public", commit_message = NULL, commit_paths = "."))

# Stage: After Deploy -----------------------------------------------------
# if(is_master_branch() | is_develop_branch())
#     get_stage("after_deploy")
