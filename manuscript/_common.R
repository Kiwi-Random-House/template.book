# The DESCRIPTION file ----------------------------------------------------
assign("DESCRIPTION", desc::description$new("../DESCRIPTION"), envir = globalenv())

# Book Metadata -----------------------------------------------------------
index <- new.env()
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

# Helpers -----------------------------------------------------------------
knitr::opts_chunk$set(
    out.width='100%',
    echo = FALSE,
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