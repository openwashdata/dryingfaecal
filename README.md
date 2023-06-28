
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
  head() 
#>   table_id    chapter           type
#> 1        1 dewatering Centrifugation
#> 2        2 dewatering Centrifugation
#> 3        3 dewatering Centrifugation
#> 4        4 dewatering Centrifugation
#> 5        5 dewatering Centrifugation
#> 6        6 dewatering Centrifugation
#>                                                                                                                                                                                                place
#> 1                                                                                                                               Pollution Research Group, University of KwaZulu-Natal (South Africa)
#> 2                                                                                                                               Pollution Research Group, University of KwaZulu-Natal (South Africa)
#> 3                                                                                                                               Pollution Research Group, University of KwaZulu-Natal (South Africa)
#> 4                                                                                                                               Pollution Research Group, University of KwaZulu-Natal (South Africa)
#> 5                                                                                                                               Pollution Research Group, University of KwaZulu-Natal (South Africa)
#> 6 o Sandec: Department Sanitation, Water and Solid Waste for Development, Eawag: Federal Institute of Aquatic Science and Technology (Switzerland) o Delvic Sanitation Initiatives, Dakar (Senegal) 
#>          date
#> 1 2018 - 2019
#> 2 2018 - 2019
#> 3 2018 - 2019
#> 4 2018 - 2019
#> 5 2018 - 2019
#> 6        2018
#>                                                                                                                                                                                                                                                                                                                                                 publication
#> 1 Septien, S., Getahun, S., Mirara, S., Makununika, B.S.N., Mugauri, T.R., Singh, A., Pocock, J., Inambao, F., Velkushanova, K., Buckley, C.A. (2019). Investigations of faecal sludge drying from on- site sanitation facilities. Proceedings of the 10th Asia Pacific Drying Conference, Vadodara, India, 14-17 December. 310 Dewatering Addendum of data
#> 2  Septien, S., Getahun, S., Mirara, S., Makununika, B.S.N., Mugauri, T.R., Singh, A., Pocock, J., Inambao, F., Velkushanova, K., Buckley, C.A. (2019). Investigations of faecal sludge drying from on-site sanitation facilities. Proceedings of the 10th Asia Pacific Drying Conference, Vadodara, India, 14-17 December. 312 Dewatering Addendum of data
#> 3  Septien, S., Getahun, S., Mirara, S., Makununika, B.S.N., Mugauri, T.R., Singh, A., Pocock, J., Inambao, F., Velkushanova, K., Buckley, C.A. (2019). Investigations of faecal sludge drying from on-site sanitation facilities. Proceedings of the 10th Asia Pacific Drying Conference, Vadodara, India, 14-17 December. 314 Dewatering Addendum of data
#> 4  Septien, S., Getahun, S., Mirara, S., Makununika, B.S.N., Mugauri, T.R., Singh, A., Pocock, J., Inambao, F., Velkushanova, K., Buckley, C.A. (2019). Investigations of faecal sludge drying from on-site sanitation facilities. Proceedings of the 10th Asia Pacific Drying Conference, Vadodara, India, 14-17 December. 316 Dewatering Addendum of data
#> 5 Septien, S., Getahun, S., Mirara, S., Makununika, B.S.N., Mugauri, T.R., Singh, A., Pocock, J., Inambao, F., Velkushanova, K., Buckley, C.A. (2019). Investigations of faecal sludge drying from on- site sanitation facilities. Proceedings of the 10th Asia Pacific Drying Conference, Vadodara, India, 14-17 December. 318 Dewatering Addendum of data
#> 6                                                                                                                           Ward, B. J., Traber, J., Gueye, A., Diop, B., Morgenroth, E., & Strande, L. (2019). Evaluation of conceptual model and predictors of faecal sludge dewatering performance in Senegal and Tanzania. Water Research, 167, 115101.
#>                                                                                                                                   link
#> 1 https://www.dropbox.com/s/76dejwq7ug1zwqy/Pre- %20and%20Post%20Centrifugation%20data%20for%20FS%20and%20fresh%20faeces%20.xlsx?dl =0
#> 2                                                         https://www.dropbox.com/s/gszw62ozno10ob2/Centrifugation%20of%20FS.xlsx?dl=0
#> 3  https://www.dropbox.com/s/76dejwq7ug1zwqy/Pre- %20and%20Post%20Centrifugation%20data%20for%20FS%20and%20fresh%20faeces%20.xlsx?dl=0
#> 4                                                         https://www.dropbox.com/s/gszw62ozno10ob2/Centrifugation%20of%20FS.xlsx?dl=0
#> 5 https://www.dropbox.com/s/76dejwq7ug1zwqy/Pre- %20and%20Post%20Centrifugation%20data%20for%20FS%20and%20fresh%20faeces%20.xlsx?dl =0
#> 6                                                                                      https://data.mendeley.com/datasets/w5y55vf3cn/1
```
