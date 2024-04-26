#'
#' Check age values in cause of death data based on CoDEdit rules
#'
#' @param age_value An integer value or vector of values for age based on the
#'   CoDEdit rules.
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
#' @returns A tibble with number of rows equal to length of `age_value` and
#'   two columns for age_check_score and age_check_note.
#'
#' @examples
#' cod_check_age(120, "Y")
#' cod_check_age(28, "D")
#' cod_check_age(32, "D")
#'
#' @rdname cod_check_age
#' @export
#'

cod_check_age <- function(age_value,
                          age_type,
                          age_type_code = c("D", "M", "Y")) {
  ## Check that age_value is of the correct class ----
  if (is(age_value, "numeric"))
    age_value <- as.integer(age_value)

  if (!is(age_value, "integer"))
    stop(
      "`age_value` should be an integer. Please check and try again.",
      call. = FALSE
    )

  ## Recode age_type ----
  age_type[age_type == age_type_code[1]] <- "D"
  age_type[age_type == age_type_code[2]] <- "M"
  age_type[age_type == age_type_code[3]] <- "Y"
  age_type[!age_type %in% age_type_code] <- NA_character_

  ## Create age_score vector ----
  age_check <- vector(mode = "integer", length = length(age_value))

  ## Classify errors/issues ----
  if (age_type == "D") {
    age_check <- ifelse(age_value >= 28 & age_value <= 31, 1, age_check)
    age_check <- ifelse(age_value > 31, 2, age_check)
  }

  if (age_type == "M") {
    age_check <- ifelse(age_value < 1, 3, age_check)
    age_check <- ifelse(age_value >= 12, 4, age_check)
  }

  if (age_type == "Y") {
    age_check <- ifelse(age_value < 1, 5, age_check)
    age_check <- ifelse(age_value > 125, 6, age_check)
  }

  if (is.na(age_value)) age_check <- 7
  if (is.na(age_type)) age_check <- 8

  age_check_note <- cut(
    x = age_check,
    breaks = c(0, 1, 2, 3, 4, 5, 6, 7, 8, Inf),
    labels = c(
      "No issues with age value and age type",
      "Should probably be age value of 1 and age type of months (M)",
      "Should probably be converted to age value of age type months (M)",
      "Should probably be converted to age value of age type days (D)",
      "Should probably be converted to age value of age type years (Y)",
      "Should probably be converted to age value of age type months (M)",
      "Age value is more than 125 years which is highly unlikely",
      "Missing age value",
      "Missing age type"
    ),
    include.lowest = TRUE, right = FALSE
  )


  ## Return age checks ----
  tibble::tibble(age_check, age_check_note)
}
