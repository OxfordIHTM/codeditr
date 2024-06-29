
cod_data_raw_example <- read.csv("data-raw/example_raw_cod.csv") |>
  dplyr::rename_with(
    .fn = function(x) c("id", "sex", "age", "code", "dod", "dob")
  ) |>
  tibble::tibble()

usethis::use_data(cod_data_raw_example, overwrite = TRUE, compress = "xz")

