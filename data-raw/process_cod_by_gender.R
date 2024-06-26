# Process CoD by sex/gender ----------------------------------------------------

## ICD 11 ----
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


## ICD 10 ----

### Female codes (goes from p1 to p35)
link <- "https://www.icd10data.com/ICD10CM/Codes/Rules/Female_Diagnosis_Codes/"


#### Male codes (goes from p1 to p6)
#https://www.icd10data.com/ICD10CM/Codes/Rules/Male_Diagnosis_Codes/1

list_cod_by_sex_icd10_ <- function(link, page, sex = c(1, 2)) {
  link_url <- paste0(link, page)

  session <- rvest::session("data-raw/2024 Female ICD-10-CM Codes.html")

  rvest::read_html("data-raw/2024 Female ICD-10-CM Codes.html") |>
    rvest::html_elements(css = ".body-content ul li") |>
    rvest::html_text()
}

### NOTE: data scraping doesn't work as site doesn't allow headless access

### Get list of ICD 10 codes specific to sex ----

icd_10_guide <- pdftools::pdf_text("data-raw/ICD10Volume2_en_2019.pdf")
