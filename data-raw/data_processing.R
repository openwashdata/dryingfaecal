## code to prepare `data_processing` dataset goes here
library(pdftools)
library(stringr)
library(dplyr)
library(tidyr)
library(tibble)
## Some reference from this amazing blog post: https://www.brodrigues.co/blog/2018-06-10-scraping_pdfs/

# Split the original pdf into different chapters according to toc
master <- "./data-raw/gatesopenres-196902.pdf"
processed_pdf_dir <- "./data-raw/processed_pdf"
dir.create(path = processed_pdf_dir)
# thermodynamics 31-79
thermodynamics <- file.path(processed_pdf_dir, "thermodynamics.pdf")
# kinetics 81-167
kinestics <- file.path(processed_pdf_dir, "kinetics.pdf")
# physiochemical properties 169 - 258
physiochemical <- file.path(processed_pdf_dir, "physiochemical_properties.pdf")
# morphilogical characteristics 260-283
morphilogical <- file.path(processed_pdf_dir, "morphilogical_properties.pdf")
# mechanical properties 285-314
mech <- file.path(processed_pdf_dir, "mechanical_properties.pdf")
# dewatering 316-331
dewatering <- file.path(processed_pdf_dir, "dewatering.pdf")
# disinfection 333-344
disinfection <- file.path(processed_pdf_dir, "disinfection.pdf")
# gas analysis 346-356
gas <- file.path(processed_pdf_dir, "gas_analysis.pdf")

pdf_subset(master, pages = 31:79, thermodynamics)
pdf_subset(master, pages = 81:167, kinestics)
pdf_subset(master, pages = 169:258, physiochemical)
pdf_subset(master, 260:283, morphilogical)
pdf_subset(master, 285:314, mech)
pdf_subset(master, 316:331, dewatering)
pdf_subset(master, 333:344, disinfection)
pdf_subset(master, 346:356, gas)

# extract general information
extract_general_info <- function(txt, start, end){
  txt <- str_sub(txt, start, end) |>
    str_replace_all("\n{2,}", "\n") |>
    str_trim()

  num_newline <- str_count(txt, "\n")
  if (num_newline==2) {
    geninfo <- txt |>
      str_split_1("\n") |>
      str_trim() |>
      str_replace("\\s{2,}", "@")

    geninfo <- separate(tibble(geninfo), col="geninfo", into = c("key", "values"), sep = "@")
  } else {
    values <- txt |>
      str_replace("\n* *Place of experimentation\n*", replacement = "") |>
      str_replace("Type of data\n*", replacement = "") |>
      str_replace("Dates of the experiments", replacement = "")
    if (str_count(values, "\n") > 2){
      newline_idx <- str_locate_all(values, "\n")[[1]][,1]
      squish_start <- newline_idx[1]+1
      squish_end <- tail(newline_idx, n=1)-1
      middle <- str_squish(str_sub(values, squish_start,squish_end))
      values <- paste(str_sub(values, 1, squish_start-1),
                      middle,
                      str_sub(values, squish_end+1))
    }
    values <- values |>
      str_replace_all("\n", "@") |>
      str_squish() |>
      str_split_1("@ ")
    geninfo <- tibble(key=c("Type of data", "Place of experimentation", "Dates of the experiments"),
                      values = values)
  }
  return(geninfo)
}

# extract Publications and Data source files
extract_data_source_links <- function(txt, start, end){
  links <- txt |>
    str_sub(start, end) |>
    str_squish()
  return(links)
}

# extract feedstock
extract_feedstock <- function(txt, start, end){
  txt <- str_sub(txt, start, end) |>
    str_replace_all("\n{2,}", "\n") |>
    str_trim()

  num_newline <- str_count(txt, "\n")
  if (num_newline==8) {
    feedstock <- txt |>
      str_split_1("\n") |>
      str_trim() |>
      str_replace("\\s{2,}", "@")

    feedstock <- separate(tibble(feedstock), col="feedstock", into = c("key", "values"), sep = "@")
  } else {
    values <- txt |>
      str_replace("\n* *Type of faecal material\n*", replacement = "") |>
      str_replace("Location of collection\n*", replacement = "") |>
      str_replace("Age before collection\n*", replacement = "") |>
      str_replace("Moisture content\n*", replacement = "") |>
      str_replace("Total solids content\n*", replacement = "") |>
      str_replace("Volatile solids content\n*", replacement = "") |>
      str_replace("Ash content\n*", replacement = "") |>
      str_replace("\n* *Presence of trash\\?\n*", replacement = "") |>
      str_replace("Pre-treatment\n*", replacement = "")
    if (str_count(values, "\n") > 8){
      newline_idx <- str_locate_all(values, "\n")[[1]][,1]
      squish_start <- newline_idx[1]+1
      squish_end <- tail(newline_idx, n=1)-1
      middle <- str_squish(str_sub(values, squish_start,squish_end))
      values <- paste(str_sub(values, 1, squish_start-1),
                      middle,
                      str_sub(values, squish_end+1))
    }
    values <- values |>
      str_replace_all("\n", "@") |>
      str_squish() |>
      str_split_1("@ ")
    feedstock <- tibble(key=c("Type of faecal material",
                              "Location of collection",
                              "Age before collection",
                              "Moisture content",
                              "Total solids content",
                              "Volatile solids content",
                              "Ash content",
                              "Presence of trash?",
                              "Pre-treatment"),
                      values = values)
  }
  return(feedstock)
}

# convert a chapter pdf to tibble tables
pdf_to_tibble <- function(pdf){
  # Convert pdf in text
  txt <- str_flatten(pdf_text(pdf))
  chaptername <- str_extract(pdf, pattern = "[_a-z]*?(?=\\.pdf)")
  print(paste("Convert", chaptername))
  # Get chapter indices
  geninfo_idx <- str_locate_all(txt, "General information")[[1]]
  feedstock_idx <- str_locate_all(txt, "Feedstock")[[1]]
  exp_idx <- str_locate_all(txt, "Experimental Procedure")[[1]]
  pub_idx <- str_locate_all(txt, "Publications")[[1]]
  datasource_idx <- str_locate_all(txt, "Data source files")[[1]]
  addnotes_idx <- str_locate_all(txt, "Additional Notes")[[1]]

  n_tables <- nrow(geninfo_idx)
  tbl_list <- list()
  for (j in 1:n_tables) {
    geninfo <- extract_general_info(txt, geninfo_idx[j, 2]+1, feedstock_idx[j, 1]-1) |>
      add_row(key = "publication", values = extract_data_source_links(txt, pub_idx[j, 2]+1, datasource_idx[j, 1]-1)) |>
      add_row(key = "link", values = extract_data_source_links(txt, datasource_idx[j, 2]+1, addnotes_idx[j, 1]-1))
    tbl_list[[j]] <- tryCatch(
      {
        feedstock <- extract_feedstock(txt, feedstock_idx[j, 2]+1, exp_idx[j, 1]-1)
        tbl_list[[j]] <- bind_rows(geninfo, feedstock) |>
          pivot_wider(names_from = key, values_from = values)
        },
      error = function(e) {
        print(paste(chaptername, j))
        print(str_trim(str_sub(txt, feedstock_idx[j, 2]+1, exp_idx[j, 1]-1)))
        feedstock <- tibble(key=c("Type of faecal material",
                                  "Location of collection",
                                  "Age before collection",
                                  "Moisture content",
                                  "Total solids content",
                                  "Volatile solids content",
                                  "Ash content",
                                  "Presence of trash?",
                                  "Pre-treatment"),
                            values = NA)
        tb <- bind_rows(geninfo, feedstock) |>
          pivot_wider(names_from = key, values_from = values)
        return(tb)
        }
    )

  }
  chapter_tbl <- bind_rows(tbl_list)
  chapter_tbl <- chapter_tbl |>
    add_column(chapter=chaptername, .before = "Type of data")
  return(chapter_tbl)
}

# Convert pdf metadata tables into tibble
pdffiles <- c(dewatering, disinfection, gas, kinestics, mech, morphilogical, physiochemical, thermodynamics)
chapter_tbl_list <- list()

for (i in 1:length(pdffiles)) {
  chapter_tbl <- pdf_to_tibble(pdffiles[i])
  chapter_tbl_list[[i]] <- chapter_tbl
}

addendum <- tibble(bind_rows(chapter_tbl_list))
# Add buggy tables manually
## dewatering 6
addendum[6, 7:15] <- list("Faecal sludge from septic tanks/holding tanks and pit latrines from a variety
  of sources (incl. households, schools, public toilets,offices, places of worship,
  and restaurants)",
  "o Dakar, Senegal o Dar es Salaam, Tanzania",
  "Variable (from several weeks to several years)",
  "87.0 – 99.8 %wt",
  "0.2 – 13 %wt",
  "26 – 85 %db",
  "15 – 74 %db",
  "No",
  "None")

## dewatering 7
addendum[7, 7:15] <- list("Faecal sludge from septic tanks/holding tanks and pit
                          latrines from a variety of sources (incl. households,
                          schools, public toilets, offices, places of worship,
                          and restaurants)",
                          "o Dakar, Senegal o Dar es Salaam, Tanzania",
                          "Variable (from several weeks to several years)",
                          "87.0 – 99.8 %wt",
                          "0.2 – 13 %wt",
                          "26 – 85 %db",
                          "15 – 74 %db",
                          "No",
                          "None")

## phsio 6
addendum[79, 7:15] <- list("Faecal sludge collected from ventilated improved pit latrines\n Type of faecal material (VIP)",
                        "Durban, South Africa",
                        "Up to 5 years",
                        "~ 80% wt",
                        "~ 20% wt",
                        "~ 50% db",
                        "~ 50% db",
                        "Yes",
                        "Screening to remove the large pieces of trash")

## physio 11
addendum[84, 7:15] <- list("Faecal sludge collected from ventilated improved pit latrines (VIP)",
                "Durban, South Africa",
                "Up to 5 years",
                "~ 80% wt",
                "~ 20% wt",
                "~ 50% db",
                "~ 50% db",
                "Yes",
                "Screening to remove the large pieces of trash")

addendum <- addendum |>
  add_column(table_id = 1:nrow(addendum), .before = "chapter") |>
  rename(type=`Type of data`,
         date=`Dates of the experiments`,
         place=`Place of experimentation`,
         faecal_type = `Type of faecal material`,
         collect_loc = `Location of collection`,
         age = `Age before collection`,
         moisture = `Moisture content`,
         tot_solids = `Total solids content`,
         volatile_solids = `Volatile solids content`,
         ash = `Ash content`,
         trash_presence = `Presence of trash?`,
         pretreatment = `Pre-treatment`
         )

usethis::use_data(addendum, overwrite = TRUE)
