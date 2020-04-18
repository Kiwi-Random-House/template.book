DESCRIPTION <- desc::description$new("../DESCRIPTION")

makesvg <- function(name = "svg", width = 300, height = 200) {
    if (name == "svg") {
        selector <- "svg"
    } else {
        selector <- paste0("svg#", name)
    }
    
    cat(paste0("<svg id='", name, "' width='", width,"' height='", height, "'>\n"))
    cat(paste0("<rect x='0' y='0' width='", width, "' height ='",  height, "' fill = 'lightblue'></rect>\n"))
    cat(paste0("<text x='10' y='", height - 10, "' style = 'font-size: 80%;'>", selector, "</text>\n"))
    cat("</svg>")
}

knitr::opts_chunk$set(
    out.width='100%',
    echo = TRUE,
    comment = "## R output ## ",
    message = FALSE,
    warning = FALSE
)

# ```{r setup, include=FALSE}
# # str(knitr::opts_chunk$get())
# knitr::opts_chunk$set(
#     echo = FALSE, 
#     message = FALSE,
#     warning = FALSE,
#     fig.align = "center",
#     out.width = "100%"
# )
# ```


HTML <- knitr::is_html_output()