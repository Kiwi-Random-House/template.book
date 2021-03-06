# First -------------------------------------------------------------------
.First <- function(){
    assign(".Rprofile", new.env(), envir = globalenv())
    
    # Helpers
    .Rprofile$NEW_SESSION <- new.env()
    .Rprofile$NEW_SESSION$unset <- function() Sys.unsetenv("NEW_SESSION")
    .Rprofile$NEW_SESSION$set <- function() Sys.setenv(NEW_SESSION = FALSE)
    .Rprofile$NEW_SESSION$get <- function() as.logical(Sys.getenv("NEW_SESSION"))
    .Rprofile$bookdown$clean_book <- function(){
        unlink <- function(x) base::unlink(x, force = TRUE, recursive = TRUE)
        setwd("./manuscript"); bookdown::clean_book(TRUE); setwd("..")
        unlink(list.files("./manuscript", "\\.md$|\\.rds$|\\.bak$", full.names = TRUE))
        unlink(paste0("./manuscript/", c("_bookdown_files", "_book")))
    }
    get_repos <- function(){
        DESCRIPTION <- readLines("DESCRIPTION")
        Date <- trimws(gsub("Date:", "", DESCRIPTION[grepl("Date:", DESCRIPTION)]))
        URL <- if(length(Date) == 1) paste0("https://mran.microsoft.com/snapshot/", Date) else "https://cran.rstudio.com/"
        return(URL)
    }
    
    # Programming Logic
    ## .First watchdog
    if(isFALSE(.Rprofile$NEW_SESSION$get())) return() else .Rprofile$NEW_SESSION$set()
    
    ## Set global options
    options(startup.check.options.ignore = "stringsAsFactors")
    
    ## Initiate the package management system
    options(Ncpus = 8, repos = structure(c(CRAN = get_repos())), dependencies = "Imports", build = FALSE)    
    
    ## Set global variables
    try({setwd("./manuscript"); source("_common.R"); setwd("..")})

    ## Cleanup
    # .Rprofile$bookdown$clean_book()
    
    ## Information
    message("Enable live book preview: RStudio Addins -> BOOKDOWN -> Preview Book")
    message("Insert citations: RStudio Addins -> CITR")
    
}

# Last --------------------------------------------------------------------
.Last <- function(){
    ## .First watchdog
    .Rprofile$NEW_SESSION$unset()
    
    ## Cleanup
    .Rprofile$bookdown$clean_book()
}
