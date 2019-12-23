source(".tic/helper-functions.R")

# Package Manager ---------------------------------------------------------
## Set repo URL
options(repos = Sys.getenv("repos", getOption("repos")))
message("Default CRAN mirror snapshot taken on ", gsub("^.*/", "", getOption("repos")))
## Install requirements
.install_local_package()
.uninstall_local_package()