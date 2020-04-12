# High-level Functions ----------------------------------------------------
generate_shield_src <- function(label = "codecov", message = "0%", color = "red"){
    replace_symbols <- function(x){
        x <- gsub("%", "%25", x)
        x <- gsub(" ", "%20", x)
        x <- gsub("-", "--", x)
        x <- gsub("_", "__", x)
        return(x)
    }

    paste0("https://img.shields.io/badge/", replace_symbols(label), "-", replace_symbols(message), "-", color, ".svg")
}
