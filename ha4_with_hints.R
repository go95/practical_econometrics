library(scholar)
library(dplyr)
library(pbapply)

scholars <- read.csv(url("https://raw.githubusercontent.com/go95/practical_econometrics/master/google_scholar_ids.csv"), as.is = TRUE)$ids

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
    new_publications$author1 <- get_profile(scholar)$name
    publications <- rbind(publications, new_publications)
  }
  
  flatten_by_author <- function (row) {
    author <- row['author']
    coauthors <- strsplit(as.character(author), ", ")[[1]]
    row <- as.list(row)
    row[['author2']] <- coauthors
    return(expand.grid(row))
  }
  
  final_publications <- data.frame()
  for (df in pbapply(publications, 1, flatten_by_author)) {
    final_publications <- rbind(final_publications, df)
  }
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
    name <- profile$name
    affiliation <- profile$affiliation
    return(data.frame(name=name, affiliation=affiliation))
  }
  
  universities <- data.frame()
  
  for (row in lapply(scholars$ids, get_name_affiliation)) {
    universities <- rbind(universities, row)
  }
  return(universities)
}

format_name <- function(name) {
  # The function formats scholars name to lowercase and initials
  name <- strsplit(name, " ")[[1]]
  name <- tolower(paste(substr(name[1],1,1), name[2]))
  name
}
