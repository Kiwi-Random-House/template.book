# Package Management ------------------------------------------------------
.install_local_package <- function(){
    .library("devtools")
    devtools::install_local(
        path = ".",
        dependencies = TRUE,
        upgrade = FALSE,
        build = FALSE,
        build_opts = "--no-multiarch --with-keep.source --no-build-vignettes",
        Ncpus = parallel::detectCores()
    )
    return(invisible())
}

.uninstall_local_package <- function(){
    .uninstall_package(package_name)
    return(invisible())
}

.uninstall_package <- function(package){
    try(utils::remove.packages(package), silent = TRUE)
    return(invisible())
}

# Low-level helper functions ----------------------------------------------
.library <- function(package){
    suppressWarnings(.install_package(package))
    library(package, character.only = TRUE)
}

.install_package <- function(pkg){
    is_package_installed <- function(pkg) pkg %in% rownames(utils::installed.packages())
    
    if(is_package_installed(pkg)) return(invisible())
    
    message("--> Installing {", pkg, "}")
    utils::install.packages(
        pkg,
        dependencies = TRUE,
        Ncpus = parallel::detectCores()
    )
    
    return(invisible())
}