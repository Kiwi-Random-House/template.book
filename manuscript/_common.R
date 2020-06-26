# helpers -----------------------------------------------------------------
`%>%` <- magrittr::`%>%`

# bookdown ----------------------------------------------------------------
options(tinytex.verbose = TRUE)
options(bookdown.post.latex = function(lines){
    rep_pos = grep('\\definecolor{shadecolor}{RGB}{248,248,248}',lines, fixed = TRUE)
    lines[rep_pos] = '\\definecolor{shadecolor}{RGB}{230,230,230}'
    lines
})

# knitr -------------------------------------------------------------------
knitr::opts_chunk$set(
    out.width='100%',
    echo = FALSE,
    results = "markup",
    message = FALSE,
    warning = FALSE,
    cache = TRUE,
    comment = "#>",
    fig.retina = 0.8, # figures are either vectors or 300 dpi diagrams
    dpi = 300,
    out.width = "70%",
    fig.align = 'center',
    fig.width = 6,
    fig.asp = 0.618,  # 1 / phi
    fig.show = "hold",
    eval.after = 'fig.cap' # so captions can use link to demos
)

# index.R metadata --------------------------------------------------------
index <- new.env()
DESCRIPTION <- desc::description$new("../DESCRIPTION")
index$title <- function() DESCRIPTION$get_field('Title')
index$author <- function() paste(unlist(DESCRIPTION$get_author())[c('given', 'family')], collapse = ' ')
index$subtitle <- function() DESCRIPTION$get_field('Description')
index$description <- function() DESCRIPTION$get_field('Description')
index$date <- base::Sys.Date
index$url <- function() DESCRIPTION$get_urls()
index$cover_image <- function() NULL # "images/cover.png" 
index$favicon <- function() "favicon.ico"
index$github_repo <- function() tryCatch(
    {remotes <- gh::gh_tree_remote(".."); paste0(remotes$username, '/', remotes$repo)}, 
    error = function(e) return()
)

# bookdown helpers --------------------------------------------------------
bookdown <- new.env()

bookdown$clean_book <- function(){
    bookdown$print_title("Cleaning-up Book Cache")
    bookdown::clean_book(TRUE) # empty cache
}

bookdown$print_install.packages_command <- function(pkgs){
    pkgs <- strwrap(paste(encodeString(pkgs, quote = '"'), collapse = ", "), exdent = 2)
    invisible(paste0(
        "install.packages(c(\n  ", 
        paste(pkgs, "\n", collapse = ""), 
        "))"
    ))
}

bookdown$print_package_info_table <- function(pkgs){
    # Note! chunk options should be: {r, echo = FALSE, results = "asis", cache = FALSE}
    bookdown$create_package_info_table(pkgs) %>%
        knitr::kable(format = "markdown", row.names = FALSE)
}

bookdown$create_package_info_table <- function(pkgs){
    package_info <- function(pkg) 
        packageDescription(pkg, fields = c("Package", "Version", "Title")) %>% 
        unlist() %>% 
        t() %>% 
        as.data.frame(stringsAsFactors = FALSE) %>% 
        dplyr::rename(Description = Title) 
    
    invisible(sapply(pkgs, package_info) %>% t())
}

bookdown$print_title <- function(msg) message(c(bookdown$sep(), "\n## ", msg, bookdown$sep()))

bookdown$sep <- function() paste0("\n", paste0(rep("#", 80), collapse = ""))
