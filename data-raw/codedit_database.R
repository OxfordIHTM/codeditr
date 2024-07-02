# Process CoDEdit databse and tool in MS Access --------------------------------

## Load libraries ----
library(openxlsx2)

## Read example death records datasets ----

### ICD10 example ----
icd10_example <- openxlsx2::read_xlsx(
  file = "data-raw/data_example_icd10.xlsx"
) |>
  tibble::tibble()

usethis::use_data(icd10_example, overwrite = TRUE, compress = "xz")

### ICD11 example ----
icd11_example <- openxlsx2::read_xlsx(
  file = "data-raw/data_example_icd11.xlsx"
) |>
  tibble::tibble() |>
  dplyr::rename(Sex = sex)

usethis::use_data(icd11_example, overwrite = TRUE, compress = "xz")
