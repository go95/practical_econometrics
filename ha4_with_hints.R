library(scholar)
library(dplyr)
library(pbapply)

scholars <- read.csv(url(paste0("https://raw.githubusercontent.com/",
  "go95/practical_econometrics/master/google_scholar_ids.csv")), as.is = TRUE)$ids[21:40]

get_publications_author_pair <- function(scholars) {
  # This function takes the list of scholar ids and created a dataframe with
  # columns:
  #   author1 author2 pub_id and other publications info
  # unit of observation:
  #   publication with an author pair
  
  publications <- data.frame()
  for (scholar in scholars) {
    print(scholar)
    new_publications <- get_publications(scholar)
    Sys.sleep(runif(1, 1, 2))
    new_publications$author1 <- get_profile(scholar)$name
    Sys.sleep(runif(1, 1, 2))
    publications <- rbind(publications, new_publications)
  }
  
  flatten_by_author <- function (row) {
    author <- row['author']
    coauthors <- strsplit(as.character(author), ", ")[[1]]
    row <- as.list(row)
    row[['author2']] <- coauthors
    return(expand.grid(row))
  }
  
  final_publications <- do.call(rbind, pbapply(publications, 1, flatten_by_author))
  return(final_publications)
}

get_affiliation_info <- function(scholars) {
  # This function takes the list of scholar ids and created a dataframe with
  # columns:
  #   name, affiliation
  # unit of observation:
  #   a scholar

  get_name_affiliation <- function(scholar_id) {
    profile <- get_profile(scholar_id)
    Sys.sleep(runif(1, 1, 2))
    name <- profile$name
    affiliation <- profile$affiliation
    return(data.frame(name=name, affiliation=affiliation))
  }
  
  universities <- data.frame()
  
  for (row in pblapply(scholars, get_name_affiliation)) {
    universities <- rbind(universities, row)
  }
  return(universities)
}

format_name <- function(name) {
  # The function formats scholars name to lowercase and initials
  format_pair <- function(pair) {
    return(tolower(paste(substr(pair[1],1,1), pair[2])))
  }
  name <- strsplit(as.character(name), " ")
  return(unlist(lapply(name, format_pair)))
}
