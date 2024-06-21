#'
#' Create vector of ill-defined ICD 11 codes
#'
#' Based on https://icdcdn.who.int/icd11referenceguide/en/html/index.html#list-of-illdefined-conditions
#'

list_ill_defined_icd11 <- function() {
  ## Create vector of ill-defined heart failure BD10-BD1Z ----
  set1 <- codigo::icd11_linearization_mms |>
    dplyr::filter(
      ChapterNo == 11 & stringr::str_detect(Code, pattern = "BD")
    ) |>
    dplyr::slice(1:11) |>
    dplyr::pull(Code)

  ## Create vector of ill-defined others ----
  set2 <- c("BA2Z", "BE2Y", "BE2Z", "CB41.0", "CB41.2", "KB2D", "KB2E")

  ## Get codes for Chapter 21 except 	MA15, MG43, MG44.1, MH11, MH15 ----
  set3 <- codigo::icd11_linearization_mms |>
    dplyr::filter(ChapterNo == 21) |>
    dplyr::filter(!Code %in% c("MA15", "MG43", "MG44.1", "MH11", "MH15")) |>
    dplyr::pull(Code)

  c(set1, set2, set3)
}
