# Process dataset for codes specific to children -------------------------------


## ICD 10 ----
icd10_cod_child <- read.csv("data-raw/cod_child_icd10.csv") |>
  dplyr::mutate(
    title = stringr::str_remove_all(title, pattern = "\\([^()]+\\)") |>
      stringr::str_trim()
  ) |>
  tibble::tibble()

usethis::use_data(icd10_cod_child, overwrite = TRUE, compress = "xz")


## ICD 11 ----
icd11_cod_child <- lapply(
    X = c("juvenile", "child", "children", "infant", "adolescents"),
    FUN = icd_search
  ) |>
  dplyr::bind_rows() |>
  dplyr::select(theCode, title) |>
  dplyr::distinct() |>
  dplyr::rename(code = theCode)

usethis::use_data(icd11_cod_child, overwrite = TRUE, compress = "xz")
