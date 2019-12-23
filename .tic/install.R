source(".tic/helper-functions.R")
options(repos = Sys.getenv("repos", getOption("repos")))
message("Default CRAN mirror snapshot taken on ", gsub("^.*/", "", getOption("repos")))
