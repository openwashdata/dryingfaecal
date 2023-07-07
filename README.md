
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

This is a basic example which shows you how to solve a common problem:

``` r
library(dryingfaecal)

## basic example code
addendum |> 
  head() |>
  tibble::as_tibble()
#> # A tibble: 6 × 16
#>   table_id chapter    type  place date  publication link  Type of faecal mater…¹
#>      <int> <chr>      <chr> <chr> <chr> <chr>       <chr> <chr>                 
#> 1        1 dewatering Cent… "Pol… 2018… Septien, S… http… "Faecal sludge from a…
#> 2        2 dewatering Cent… "Pol… 2018… Septien, S… http… "Faecal sludge from u…
#> 3        3 dewatering Cent… "Pol… 2018… Septien, S… http… "Faecal sludge from d…
#> 4        4 dewatering Cent… "Pol… 2018… Septien, S… http… "Faecal sludge from w…
#> 5        5 dewatering Cent… "Pol… 2018… Septien, S… http… "Fresh faeces"        
#> 6        6 dewatering Cent… "o S… 2018  Ward, B. J… http… "Faecal sludge from s…
#> # ℹ abbreviated name: ¹​`Type of faecal material`
#> # ℹ 8 more variables: `Location of collection` <chr>,
#> #   `Age before collection` <chr>, `Moisture content` <chr>,
#> #   `Total solids content` <chr>, `Volatile solids content` <chr>,
#> #   `Ash content` <chr>, `Presence of trash?` <chr>, `Pre-treatment` <chr>
```
