#'
#' Check sex values in cause of death data based on CoDEdit rules
#'
#' @param sex_value An integer value or vector of values for age based on the
#'   CoDEdit rules.
#'

cod_check_sex <- function(sex_value) {
  ## Create sex_check vector ----
  sex_check <- vector(mode = "integer", length = length(sex_value))

  ## Check that sex_value is of the correct class ----
  sex_check <- ifelse(!is.integer(sex_value), 1L, sex_check)

  ## Check that sex_value is either 1L for males, 2L for females, and 9L for
  ## unknown
  sex_check <- ifelse(
    any(!sex_value %in% c(1L, 2L, 9L)), sex_check + 2L, sex_check
  )


  ## Check if sex_value is missing ----
  sex_check <- ifelse(is.na(sex_value), sex_check + 4L, sex_check)

  ## Create sex_check note vector ----
  sex_check_note <- vector(mode = "character", length = length(sex_value))

  sex_check_note[sex_check == 0] <- "No issues with sex values"
  sex_check_note[sex_check == 1] <- "Sex value is not an integer"
  sex_check_note[sex_check == 2] <- "Sex value is not any of the expected values"
  sex_check_note[sex_check == 3] <- "Sex value is not an integer; Sex value is not any of the expected values"
  sex_check_note[sex_check == 4] <- "Missing sex value"
  sex_check_note[sex_check == 5] <- ""

}
