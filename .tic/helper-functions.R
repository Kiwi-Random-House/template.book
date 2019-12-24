# Package Management ------------------------------------------------------
.install_local_package <- function(){
    .library("devtools")
    
    devtools::install_local(
        path = ".",
        dependencies = TRUE,
        upgrade = FALSE,
        build = FALSE,
        build_opts = "--no-multiarch --with-keep.source --no-build-vignettes"
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
    utils::install.packages(pkg, dependencies = TRUE)
    
    return(invisible())
}

.get_field_from_DESCRIPTION <- function(field){
    .read_DESCRIPTION <- function() readLines("DESCRIPTION")
    field_regex <- paste0("^",field,":")
    Date_line <- .read_DESCRIPTION()[grep(field_regex, .read_DESCRIPTION())]
    Date <- trimws(sub(field_regex, "", Date_line))
}





