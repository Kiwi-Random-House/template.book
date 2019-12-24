source(".tic/helper-functions.R")

# Package Manager ---------------------------------------------------------
## Set repo URL
try({
    date <- .get_field_from_DESCRIPTION("Date")
    options(repos = paste0("https://mran.microsoft.com/snapshot/", date))
    message("Default CRAN mirror snapshot taken on ", gsub("^.*/", "", getOption("repos")))
})
## Install requirements
.install_local_package()
.uninstall_local_package()