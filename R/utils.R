#'
#' Get various age values for all three age types
#'
#' @param age_value An integer value for the age
#' @param age_type The age type of the specified age value. Can be either
#'   *"D"* for day, *"M"* for month, or *"Y"* for year.
#'
#' @returns A named list of age values in days, months, and years.
#'
#' @examples
#' get_age_values(1, "Y")
#'
#' @rdname get_age
#' @export
#'

get_age_values <- function(age_value, age_type = c("D", "M", "Y")) {
  if (age_value > 100 & age_type == "Y")
    warning(
      "Age value of greater than 100 for age type `year` has been provided. Please double check that these are correct inputs."
    )

  if (age_value >= 28 & age_type == "D")
    warning(
      "Age value of 28 or greater for age type `day` has been provided. Please double check that these are correct inputs."
    )

  if (age_value >= 12 & age_type == "M")
    warning(
      "Age value of 12 or greater for age type `month` has been provided. Please double check that these are correct inputs."
    )

  if (age_type == "D")
    list(
      days = age_value,
      months = age_value / (365.25 / 12),
      years = age_value / 365.25
    )

  if (age_type == "M")
    list(
      days = age_value * (365.25 / 12),
      months = age_value,
      years = age_value / 12
    )

  if (age_type == "Y")
    list(
      days = age_value * 365.25,
      months = age_value * 12,
      years = age_value
    )
}
