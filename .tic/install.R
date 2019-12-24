source(".tic/helper-functions.R")

# Package Manager ---------------------------------------------------------
## Set repo URL
.library("desc")
try({
    date <- desc::description$new()$get_field("Date")
    options(repos = paste0("https://mran.microsoft.com/snapshot/", date))
})
message("Default CRAN mirror snapshot taken on ", gsub("^.*/", "", getOption("repos")))
## Install requirements
.install_local_package()
.uninstall_local_package()