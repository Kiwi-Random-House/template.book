.First <- function(){
    if(identical(Sys.getenv("R_FIRST_SESSION"), FALSE)) return(invisible()) else Sys.setenv(R_FIRST_SESSION = FALSE)
    message("Enable live book preview: RStudio Addins -> BOOKDOWN -> Preview Book")
    message("Insert citations: RStudio Addins -> CITR")
}

.Last <- function(){
    message("Cleaing Up")
    
    unlink("./manuscript/_book", force = TRUE, recursive = TRUE)
    unlink("./manuscript/_bookdown_files", force = TRUE, recursive = TRUE)
}
