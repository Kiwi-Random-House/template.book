assign("DESCRIPTION", desc::description$new("../DESCRIPTION"), envir = globalenv())

HTML <- knitr::is_html_output()

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
    echo = FALSE,
    message = FALSE,
    warning = FALSE,
    cache = TRUE,
    comment = "## R output ## ",
    # comment = "#>",
    fig.retina = 0.8, # figures are either vectors or 300 dpi diagrams
    dpi = 300,
    out.width = "70%",
    fig.align = 'center',
    fig.width = 6,
    fig.asp = 0.618,  # 1 / phi
    fig.show = "hold",
    eval.after = 'fig.cap' # so captions can use link to demos
)