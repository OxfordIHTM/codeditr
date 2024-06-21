

icd11_unlikely_cod <- rvest::read_html(x = "data-raw/value_sets.html") |>
  rvest::html_elements("li") |>
  rvest::html_text() |>
  stringr::str_split(pattern = " ", n = 2) |>
  lapply(FUN = function(x) { names(x) <- c("code", "title"); x }) |>
  dplyr::bind_rows() |>
  dplyr::mutate(
    code = ifelse(
      stringr::str_detect(code, pattern = "^.{2}[0-9]{1}"),
      code, NA_character_
    ),
    title = ifelse(
      stringr::str_detect(code, pattern = "^.{2}[0-9]{1}"),
      title, paste(code, title)
    )
  )

usethis::use_data(icd11_unlikely_cod, compress = "xz")

