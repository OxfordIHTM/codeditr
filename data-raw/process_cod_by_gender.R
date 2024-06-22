
cod_by_sex <- read.csv("data-raw/cod_by_sex.csv") |>
  tibble::tibble()

multiple_cod_codes <- cod_by_sex |>
  dplyr::filter(stringr::str_detect(string = code, pattern = "-")) |>
  dplyr::select(code, gender) |>
  dplyr::mutate(
    category = stringr::str_extract(string = code, pattern = "^.{3}")
  )

expanded_multiples <- lapply(
  X = multiple_cod_codes$category,
  FUN = function(x) codigo::icd11_linearization_mms |>
    dplyr::filter(
      stringr::str_detect(string = Code, pattern = x)
    ) |>
    dplyr::select(Code, Title)
) |>
  (\(x) { names(x) <- multiple_cod_codes$gender; x })() |>
  dplyr::bind_rows(.id = "gender") |>
  dplyr::mutate(
    Title = stringr::str_remove_all(string = Title, pattern = "- "),
    gender = ifelse(gender == "male", 1, 2)
  ) |>
  dplyr::rename(code = Code, title = Title, sex = gender) |>
  dplyr::select(code, title, sex)

icd11_cod_by_sex <- cod_by_sex |>
  dplyr::filter(!code %in% multiple_cod_codes$code ) |>
  dplyr::rename(sex = gender) |>
  rbind(expanded_multiples) |>
  dplyr::arrange(sex, code)



usethis::use_data(icd11_cod_by_sex, overwrite = TRUE, compress = "xz")


