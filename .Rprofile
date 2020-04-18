.First <- function(){
    if(identical(Sys.getenv("R_FIRST_SESSION"), FALSE)) return(invisible()) else Sys.setenv(R_FIRST_SESSION = FALSE)
    message("Enable live book preview: RStudio Addins -> BOOKDOWN -> Preview Book")
    message("Insert citations: RStudio Addins -> CITR")
    DESCRIPTION <- desc::description$new("./DESCRIPTION")
    setwd("./manuscript"); bookdown::clean_book(TRUE); setwd("..")
    unlink(list.files("./manuscript", "\\.md$", full.names = TRUE), force = TRUE, recursive = !TRUE)
}

.Last <- function(){}
