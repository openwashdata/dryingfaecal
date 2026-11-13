# dryingfaecal 0.0.0.9000

- The package now says what it holds: DESCRIPTION carries a title and a description of the two datasets, discovery keywords, the countries of the experiments and the years the data cover (2012 to 2020). The countries and the years are read from the data and wait for confirmation.
- Both datasets can be downloaded as CSV and XLSX files from `inst/extdata`, and the README links them in a table.
- The processing script in `data-raw/` runs again from start to end and rebuilds `addendum` and `centrifugation` as they are in the package. The data are unchanged.
- The package check now runs on GitHub for the main and the development branch, and the citation files and the Zenodo metadata are written from DESCRIPTION.
- The 11 variables of `centrifugation` have descriptions in the data dictionary and on the help page (#3).
