#'
#' Recode sex value of cause-of-death data based on CoDEdit rules
#'
#' @param sex_value A character or integer value or vector of values signifying
#'   the sex.
#' @param sex_code A character or integer vector of 2 values that indicate
#'   which values are to be considered pertaining to males (first value in the
#'   vector) or to females (second value in the vector).
#' @param codedit Logical. Should output be based on the CoDEdit version 2
#'   coding rules. Default to TRUE.
#'
#' @returns An integer value or vector of values containing either 1 for males
#'   or 2 for females. If `codedit = TRUE`, values not equal to the `sex_code`
#'   values are coded as 9 (integer). Otherwise, it is coded as NA_integer_.
#'
#' @examples
#' cod_recode_sex(
#'   sex_value = c(rep("m", 2), rep("f", 3)),
#'   sex_code = c("m", "f")
#' )
#'
#' @rdname cod_recode_sex
#' @export
#'

cod_recode_sex <- function(sex_value, sex_code = c(1L, 2L), codedit = TRUE) {
  if (codedit) {
    sex_value[!sex_value %in% sex_code] <- 9L
  } else {
    sex_value[!sex_value %in% sex_code] <- NA_integer_
  }

  sex_value[sex_value == sex_code[1]] <- 1L
  sex_value[sex_value == sex_code[2]] <- 2L

  as.integer(sex_value)
}
