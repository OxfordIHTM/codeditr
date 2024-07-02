# Process dataset for codes specific to neonates -------------------------------


## ICD 10 ----
icd10_cod_neonate <- read.csv("data-raw/cod_neonate_icd10.csv") |>
  dplyr::mutate(
    title = stringr::str_remove_all(title, pattern = "\\([^()]+\\)") |>
      stringr::str_trim()
  ) |>
  tibble::tibble()

usethis::use_data(icd10_cod_neonate, overwrite = TRUE, compress = "xz")


## ICD 11 ----
icd11_cod_neonate <- codigo::icd_search(q = "newborn") |>
  dplyr::select(theCode, title) |>
  dplyr::distinct() |>
  dplyr::rename(code = theCode)

usethis::use_data(icd11_cod_neonate, overwrite = TRUE, compress = "xz")
