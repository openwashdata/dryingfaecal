
<!-- README.md is generated from README.Rmd. Please edit that file -->

# dryingfaecal

<!-- badges: start -->
<!-- badges: end -->

The goal of dryingfaecal is to …

## Installation

You can install the development version of dryingfaecal from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("openwashdata/dryingfaecal")
```

## Example

``` r
library(dryingfaecal)

## basic example code
addendum |> 
  head() |>
  tibble::as_tibble()
#> # A tibble: 6 × 16
#>   table_id chapter   type  place date  publication link  faecal_type collect_loc
#>      <int> <chr>     <chr> <chr> <chr> <chr>       <chr> <chr>       <chr>      
#> 1        1 dewateri… Cent… "Pol… 2018… Septien, S… http… "Faecal sl… Durban, So…
#> 2        2 dewateri… Cent… "Pol… 2018… Septien, S… http… "Faecal sl… Durban, So…
#> 3        3 dewateri… Cent… "Pol… 2018… Septien, S… http… "Faecal sl… Durban, So…
#> 4        4 dewateri… Cent… "Pol… 2018… Septien, S… http… "Faecal sl… Durban, So…
#> 5        5 dewateri… Cent… "Pol… 2018… Septien, S… http… "Fresh fae… Durban, So…
#> 6        6 dewateri… Cent… "o S… 2018  Ward, B. J… http… "Faecal sl… o Dakar, S…
#> # ℹ 7 more variables: age <chr>, moisture <chr>, tot_solids <chr>,
#> #   volatile_solids <chr>, ash <chr>, trash_presence <chr>, pretreatment <chr>
```

The dataset contains the following variables:

| variable_name   | description                                                   |
|:----------------|:--------------------------------------------------------------|
| table_id        | ID number of the meta-data table                              |
| chapter         | Name of the chapter of the experimentation                    |
| type            | Type of experimentation data, e.g., centrifugation            |
| place           | Place of the experimentation                                  |
| date            | Date of the experimentation                                   |
| publication     | Publication citation associated with the experiment           |
| link            | Data source web links where the experiment raw data is stored |
| faecal_type     | Type of faecal material                                       |
| collect_loc     | Location of collection                                        |
| age             | Age before collection                                         |
| moisture        | Moisture content                                              |
| tot_solids      | Total solids content                                          |
| volatile_solids | Volatile solids content                                       |
| ash             | Ash content                                                   |
| trash_presence  | Whether trash is present or not                               |
| pretreatment    | Pre-treatment                                                 |
