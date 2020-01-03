.First <- function(){
    is_integrating <- function() identical(Sys.getenv("CI"), "true")
    if(is_integrating()) return()
    message("To enable live book preview, go to: RStudio Addins -> BOOKDOWN -> Preview Book")
}
