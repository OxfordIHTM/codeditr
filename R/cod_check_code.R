#'
#' Check cause of death code for code entry mistakes and/or code completeness
#'
#' @param cod A character value or vector of values for cause of death code/s.
#' @param version A character value for ICD version used. This should be either
#'   *"icd10"* or *"icd11"*. Default is *"icd10"*.
#'
#' @returns A tibble with 2 columns/fields. First is an integer value indicating
#'   whether there is an issue with the cause of death code provided in relation
#'   to a potential code entry mistake and/or and issue of code completeness.
#'
#' @examples
#' cod_check_code("U100")
#' cod_check_code("2C6Z", version = "icd11")
#'
#' @rdname cod_check_code
#' @export
#'

cod_check_code <- function(cod, version = c("icd10", "icd11")) {
  ## Determine value for version ----
  version <- match.arg(version)

  cod_code_structure <- eval(
    parse(
      text = paste0("cod_check_code_structure_", version, "(cod = cod)")
    )
  )

  cod_check_code_ill_defined <- eval(
    parse(
      text = paste0("cod_check_code_ill_defined_", version, "(cod = cod)")
    )
  )
}


#'
#' @rdname cod_check_code
#' @export
#'

cod_check_code_structure_icd10 <- function(cod) {
  ## Create concatenating vector for check scores ----
  cod_check <- vector(mode = "integer", length = length(cod))

  ## Assess cod/s ----

  ### code puts . in the 4th position ----
  cod_check <- ifelse(
    stringr::str_detect(string = cod, pattern = "\\.", negate = TRUE),
    cod_check,
    ifelse(
      stringr::str_detect(string = cod, pattern = "^.{3}\\.", negate = TRUE),
      cod_check + 1L,
      cod_check
    )
  )

  ### Remove . so that next checks will work as appropriate ----
  cod <- stringr::str_remove_all(string = cod, pattern = "\\.")

  ### Standardise cod by making all character values to uppercase ----
  cod <- toupper(cod)

  ### code length of 2 or less ----
  cod_check <- ifelse(stringr::str_count(cod) <= 2, cod_check + 2L, cod_check)

  ### code length of 3 (warning) ----
  #cod_check <- ifelse(stringr::str_count(cod) == 3, cod_check + 4, cod_check)

  ### code does not start with a character value ----
  cod_check <- ifelse(
    stringr::str_detect(string = cod, pattern = "^[A-Za-z]", negate = TRUE),
    cod_check + 4L, cod_check
  )

  ### code starts with a U or contains U ----
  cod_check <- ifelse(
    stringr::str_detect(string = cod, pattern = "U"),
    cod_check + 8L, cod_check
  )

  ### code is missing ----
  cod_check <- ifelse(is.na(cod), 16L, cod_check)

  ## Get combination of scores, total scores, and labels ----
  check_values <- get_score_combo(
    scores = c(1, 2, 4, 8),
    labels = c(
      "CoD code has a period (`.`) character in the wrong place",
      "CoD code is 2 or less characters long",
      "CoD code does not start with a character value",
      "CoD code contains the character value `U`"
    )
  )

  cod_check_note <- cut(
    x = cod_check,
    breaks = c(0, check_values$cod_check, 16, Inf),
    labels = c(
      "No issues found in CoD code",
      check_values$cod_check_note,
      "CoD code is missing"
    ),
    include.lowest = TRUE, right = FALSE
  )

  tibble::tibble(cod_check, cod_check_note)
}


#'
#' @rdname cod_check_code
#' @export
#'

cod_check_code_structure_icd11 <- function(cod) {
  ## Create concatenating vector for check scores ----
  cod_check <- vector(mode = "integer", length = length(cod))

  ## Assess cod/s ----

  ### code puts . in the 5th position ----
  cod_check <- ifelse(
    stringr::str_detect(string = cod, pattern = "\\.", negate = TRUE),
    cod_check,
    ifelse(
      stringr::str_detect(string = cod, pattern = "^.{4}\\.", negate = TRUE),
      cod_check + 1L,
      cod_check
    )
  )

  ### Remove . so that next checks will work as appropriate ----
  cod <- stringr::str_remove_all(string = cod, pattern = "\\.")

  ### Standardise cod by making all character values to uppercase ----
  cod <- toupper(cod)

  ### First character is not O or I ----
  cod_check <- ifelse(
    stringr::str_detect(string = cod, pattern = "^O|^I"),
    cod_check + 2L, cod_check
  )

  ### Second character is alphabet ----
  cod_check <- ifelse(
    stringr::str_detect(string = cod, pattern = "^.{1}[A-Z]", negate = TRUE),
    cod_check + 4L, cod_check
  )

  ### Second character is not O or I ----
  cod_check <- ifelse(
    stringr::str_detect(string = cod, pattern = "^.{1}O|I"),
    cod_check + 8L, cod_check
  )

  ### Third character is a number ----
  cod_check <- ifelse(
    stringr::str_detect(string = cod, pattern = "^.{2}[0-9]{1}", negate = TRUE),
    cod_check + 16L, cod_check
  )

  ### Fourth character is not O or I ----
  cod_check <- ifelse(
    stringr::str_detect(string = cod, pattern = "^O|^I"),
    cod_check + 32L, cod_check
  )

  ### code is missing ----
  cod_check <- ifelse(is.na(cod), 64L, cod_check)

  ## Get combination of scores, total scores, and labels ----
  check_values <- get_score_combo(
    scores = c(1, 2, 4, 8, 16, 32),
    labels = c(
      "CoD code has a period (`.`) character in the wrong place",
      "CoD code starts with `O` or `I`",
      "CoD code has a number as its second value",
      "CoD code has `O` or `I` as its second value",
      "CoD code has a letter as its third value",
      "CoD code has `O` or `I` as its fourth value"
    )
  )

  cod_check_note <- cut(
    x = cod_check,
    breaks = c(0, check_values$cod_check, 64, Inf),
    labels = c(
      "No issues found in CoD code",
      check_values$cod_check_note,
      "CoD code is missing"
    ),
    include.lowest = TRUE, right = FALSE
  )

  tibble::tibble(cod_check, cod_check_note)
}

#'
#' @rdname cod_check_code
#' @export
#'
cod_check_code_ill_defined_icd10 <- function(cod) {
  NA
}


#'
#' @rdname cod_check_code
#' @export
#'

cod_check_code_ill_defined_icd11 <- function(cod) {
  cod_check <- ifelse(
    cod %in% list_ill_defined_icd11(), 1L, 0L
  )

  cod_check_note <- "CoD code is an ill-defined code"

  tibble::tibble(cod_check, cod_check_note)
}
