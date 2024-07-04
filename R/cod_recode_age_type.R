#'
#' Recode age type of cause-of-death data based on CoDEdit rules
#'
#' @param age_type A vector of values for age type based on the CoDEdit rules.
#'   This should either be "D" for age in days, "M" for age
#'   in months, or "Y" for age in years. If values are different from these,
#'   then `age_type_code` should be specified to correspond to the day, month,
#'   and year values of `age_type`.
#' @param age_type_code A character or integer vector of 3 values that indicate
#'   which values are to be considered pertaining to days (first value in the
#'   vector), to months (second value in the vector), or years (third value
#'   in the vector).
#'
#' @returns A character value or vector of values containing either "D", "M",
#'   or "Y" for *days*, *months*, or *years* respectively.
#'
#' @examples
#' cod_recode_age_type(
#'   age_type = c(rep("d", 3), rep("m", 2), rep("y", 3)),
#'   age_type_code = c("d", "m", "y")
#' )
#'
#' @rdname cod_recode_age_type
#' @export
#'

cod_recode_age_type <- function(age_type,
                                age_type_code = c("D", "M", "Y")) {
  ## Recode age_type ----
  age_type[age_type == age_type_code[1]] <- "D"
  age_type[age_type == age_type_code[2]] <- "M"
  age_type[age_type == age_type_code[3]] <- "Y"
  age_type[!age_type %in% c("D", "M", "Y")] <- NA_character_

  ## Return age_type ----
  age_type
}

