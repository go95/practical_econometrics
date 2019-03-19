library(scholar)
library(dplyr)
library(pbapply)

scholars <- read.csv(url(paste0("https://raw.githubusercontent.com/",
  "go95/practical_econometrics/master/google_scholar_ids.csv")), as.is = TRUE)$ids[1:20]

get_publications_author_pair <- function(scholars) {
  # This function takes the list of scholar ids and creates a dataframe with
  # columns:
  #   author1 author2 pub_id and other publications info
  # unit of observation:
  #   author pair (with the first author from scholars vector and their joint publication 
  
  publications <- data.frame()
  for (scholar in scholars) {
    print(scholar)
    new_publications <- get_publications(scholar)
    Sys.sleep(1)
    new_publications$author1 <- get_profile(scholar)$name
    Sys.sleep(1)
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
    Sys.sleep(1)
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
  name <- strsplit(as.character(name), " ")[[1]]
  name <- tolower(paste(substr(name[1],1,1), name[2]))
  name
}
