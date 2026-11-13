
<!-- README.md is generated from README.Rmd. Please edit that file -->

# dryingfaecal <a href="https://openwashdata.org"><img src="man/figures/logo.png" align="right" width="120" alt="openwashdata" /></a>

<!-- badges: start -->

[![R-CMD-check](https://github.com/openwashdata/dryingfaecal/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/openwashdata/dryingfaecal/actions/workflows/R-CMD-check.yaml)
<!-- badges: end -->

## Introduction

The data is related to the drying process of faecal sludge and was
collected from different institutions with relevant information about
the feedstock and experimental conditions. Experimental data is
categorized into 8 groups: thermodynamics, kinetics, physiochemical
properties, morphology, mechanical properties, dewaterability,
disinfection, and gas emission.

Different types of faecal samples were involved on the generation of the
data: - fresh faeces and faecal sludge from various types of onsite
sanitation facilities, among which ventilated improved pit (VIP)
latrines - urine diversion dry toilets (UDDT) - anaerobic baffled
reactor (ABR) from a decentralized wastewater treatment plant (DEWAT)
TODO: INSERT PICTURES? \## Installation

You can install the development version of dryingfaecal from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("openwashdata/dryingfaecal")
```

Alternatively, you can download the individual datasets as a CSV or XLSX
file from the table below.

1.  Click Download CSV. A window opens that displays the CSV in your
    browser.
2.  Right-click anywhere inside the window and select “Save Page As…”.
3.  Save the file in a folder of your choice.

| dataset | CSV | XLSX |
|:---|:---|:---|
| addendum | [Download CSV](https://github.com/openwashdata/dryingfaecal/raw/main/inst/extdata/addendum.csv) | [Download XLSX](https://github.com/openwashdata/dryingfaecal/raw/main/inst/extdata/addendum.xlsx) |
| centrifugation | [Download CSV](https://github.com/openwashdata/dryingfaecal/raw/main/inst/extdata/centrifugation.csv) | [Download XLSX](https://github.com/openwashdata/dryingfaecal/raw/main/inst/extdata/centrifugation.xlsx) |

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

| directory | file_name | variable_name | variable_type | description |
|:---|:---|:---|:---|:---|
| data/ | addendum.rda | table_id | integer | ID number of the meta-data table |
| data/ | addendum.rda | chapter | character | Name of the chapter of the experimentation |
| data/ | addendum.rda | type | character | Type of experimentation data, e.g., centrifugation |
| data/ | addendum.rda | place | character | Place of the experimentation |
| data/ | addendum.rda | date | character | Date of the experimentation |
| data/ | addendum.rda | publication | character | Publication citation associated with the experiment |
| data/ | addendum.rda | link | character | Data source web links where the experiment raw data is stored |
| data/ | addendum.rda | faecal_type | character | Type of faecal material |
| data/ | addendum.rda | collect_loc | character | Location of collection |
| data/ | addendum.rda | age | character | Age before collection |
| data/ | addendum.rda | moisture | character | Moisture content |
| data/ | addendum.rda | tot_solids | character | Total solids content |
| data/ | addendum.rda | volatile_solids | character | Volatile solids content |
| data/ | addendum.rda | ash | character | Ash content |
| data/ | addendum.rda | trash_presence | character | Whether trash is present or not |
| data/ | addendum.rda | pretreatment | character | Pre-treatment |
| data/ | centrifugation.rda | sample_name | character | Name of the faecal material: ABR (sludge from an anaerobic baffled reactor), UDDT (sludge from urine diversion dry toilets), DRY VIP (sludge from dry ventilated improved pit latrines) or Fresh Faeces |
| data/ | centrifugation.rda | avg_moisture | numeric | Average moisture content of the material before centrifugation, in percent by weight (one value per material) |
| data/ | centrifugation.rda | tube | character | Letter of the centrifuge tube (a, b or c), three tubes per material |
| data/ | centrifugation.rda | speed | numeric | Speed of the centrifuge in revolutions per minute (RPM) |
| data/ | centrifugation.rda | time | numeric | Duration of the centrifugation in minutes |
| data/ | centrifugation.rda | tube_mass | numeric | Mass of the centrifuge tube in grams |
| data/ | centrifugation.rda | tot_mass_before | character | Mass of the tube with the sample before centrifugation in grams, stored as text because the first value is written ‘63, 7524’ in the source file |
| data/ | centrifugation.rda | tot_mass_after | numeric | Mass of the tube with the solid residue after centrifugation in grams |
| data/ | centrifugation.rda | water_activity_after | numeric | Water activity of the solid residue after centrifugation (no unit, scale 0 to 1) |
| data/ | centrifugation.rda | moisture_after | numeric | Moisture content of the solid residue after centrifugation, in percent by weight |
| data/ | centrifugation.rda | water_activity_before | numeric | Water activity of the material before centrifugation (no unit, scale 0 to 1), one value per material |

## Categories

### Dewatering

Experiment: Centrifugation done in a centrifuge HERMLE Z323, during 120
minutes at a rate of 5000 RPM, for 40 g of sample per centrifuge tube

Published by openwashdata, <https://openwashdata.org>.
