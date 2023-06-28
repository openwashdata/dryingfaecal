## code to prepare `data_processing` dataset goes here
library(pdftools)
library(stringr)
library(dplyr)
library(tidyr)
library(tibble)

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
    tryCatch(
      {
        tbl_list[[j]] <- extract_general_info(txt, geninfo_idx[j, 2]+1, feedstock_idx[j, 1]-1) |>
          add_row(key = "publications", values = extract_data_source_links(txt, pub_idx[j, 2]+1, datasource_idx[j, 1]-1)) |>
          add_row(key = "data_source_links", values = extract_data_source_links(txt, datasource_idx[j, 2]+1, addnotes_idx[j, 1]-1)) |>
          pivot_wider(names_from = key, values_from = values)},
      error = function(e) {
        print(paste(chaptername, j))
        print(e)
        print(substr(txt, geninfo_idx[j,2]+1, feedstock_idx[j, 1]-1))

        }
    )
  }
  chapter_tbl <- bind_rows(tbl_list)
  chapter_tbl <- chapter_tbl |> add_column(chapter=chaptername)
  return(chapter_tbl)
}

pdffiles <- c(dewatering, disinfection, gas, kinestics, mech, morphilogical, physiochemical, thermodynamics)
chapter_tbl_list <- list()

for (i in 1:length(pdffiles)) {
  chapter_tbl <- pdf_to_tibble(pdffiles[i])
  chapter_tbl_list[[i]] <- chapter_tbl
}

addendum <- bind_rows(chapter_tbl_list)
addendum <- addendum |> add_column(table_id = 1:nrow(addendum), .before = "Type of data")

usethis::use_data(addendum, overwrite = TRUE)
