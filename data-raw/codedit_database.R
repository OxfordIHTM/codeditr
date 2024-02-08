# Process CoDEdit databse and tool in MS Access --------------------------------

## Load libraries ----
library(openxlsx2)

## Read example death records datasets ----

### ICD10 example ----
icd10_example <- openxlsx2::read_xlsx(file = "data-raw/data_example_icd10.xlsx")
usethis::use_data(icd10_example)

### ICD11 example ----
icd11_example <- openxlsx2::read_xlsx(file = "data-raw/data_exemple_icd11.xlsx")
usethis::use_data(icd11_example)
