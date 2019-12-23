options(repo = Sys.getenv("repo", getOption("repo")))
message("Default CRAN mirror snapshot taken on ", gsub("^.*/", "", getOption("repos")))
