#'
#' Check sex values in cause of death data based on CoDEdit rules
#'
#' @param sex_value An integer value or vector of values for age based on the
#'   CoDEdit rules.
#' @param sex_code A character or integer vector of 2 values that indicate
#'   which values are to be considered pertaining to males (first value in the
#'   vector) or to females (second value in the vector).
#'
#' @returns A tibble with number of rows equal to length of `sex_value` and
#'   two columns for sex_check and sex_check_note.
#'
#' @examples
#' cod_check_sex("m", c("m", "f"))
#' cod_check_sex("male", c("male", "female"))
#' cod_check_sex(1, 1:2)
#'
#' @rdname cod_check_sex
#' @export
#'

cod_check_sex <- function(sex_value, sex_code) {
  ## Recode sex ----
  sex_value <- cod_recode_sex(sex_value = sex_value, sex_code = sex_code)

  ## Create sex_check vector ----
  sex_check <- vector(mode = "integer", length = length(sex_value))

  ## Check that sex_value is of the correct class ----
  sex_check <- ifelse(!is.integer(sex_value), 1L, sex_check)

  ## Check that sex_value is either 1L for males, 2L for females, and 9L for
  ## unknown
  sex_check <- ifelse(all(!sex_value %in% c(1L, 2L, 9L)), 2L, sex_check)

  ## Check if sex_value is missing ----
  sex_check <- ifelse(sex_value == 9L, 3L, sex_check)

  ## Create sex_check note vector ----
  sex_check_note <- vector(mode = "character", length = length(sex_value))

  sex_check_note[sex_check == 0] <- "No issues with sex value"
  sex_check_note[sex_check == 1] <- "Sex value is not an integer"
  sex_check_note[sex_check == 2] <- "Sex value is not any of the expected values"
  sex_check_note[sex_check == 3] <- "Missing sex value"


  ## Return check ----
  tibble::tibble(sex_check, sex_check_note)
}
