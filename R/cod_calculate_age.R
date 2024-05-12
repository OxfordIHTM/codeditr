#'
#' Calculate age at death based on date of birth and date of death
#'
#' @param dob Date of birth. This should ideally be in standard ISO extended
#'   date format of *"YYYY-MM-DD"* as specified in the default value for
#'   `date_format`.
#' @param dod Date of death. This should ideally be in standard ISO extended
#'   date format of *YYYY-MM_DD"* as specified in the default value for
#'   `date_format`.
#' @param date_format Format for date values provided. Date formatting is
#'   handled using [strptime()] hence this needs to be specified based on what
#'   [strptime()] requires for its `format` argument. By default, this is set
#'   to the standard ISO extended date format expressed as *"%Y-%m-%d"* which
#'   corresponds to *"YYYY-MM-DD"*.
#' @param codedit Logical. Should output be based on the CoDEdit version 2
#'   coding rules. Default to TRUE.
#'
#' @returns Values for age in days, months and years. IF `codedit`
#'
#' @examples
#' cod_calculate_age("1977-11-05", Sys.Date())
#' cod_calculate_age("1965-05-20", "2023-10-03")
#'
#' @rdname cod_calculate_age
#' @export
#'

cod_calculate_age <- function(dob,
                              dod,
                              date_format = "%Y-%m-%d",
                              codedit = TRUE) {
  ## Set date format ----
  if (!is(dob, "Date"))
    dob <- as.Date(dob, format = date_format)

  if (!is(dod, "Date"))
    dod <- as.Date(dod, format = date_format)

  ## Calculate different age values for different age types ----
  age_days   <- as.numeric(dod - dob)
  age_months <- as.numeric(age_days / (365.25 / 12))
  age_years  <- as.numeric(age_days / 365.25)

  ## Process output based on whether codedit ----
  if (codedit) {
    age_df <- tibble::tibble(
      age_days = ifelse(age_days >= 28, NA, age_days),
      age_months = ifelse(
        age_months >= 1 & age_months < 12, age_months,
        ifelse(
          age_days >= 28 & age_days < 32, 1, NA
        )
      ),
      age_years = ifelse(age_years >= 1, age_years, NA)
    )

    age_df <- age_df |>
      dplyr::mutate(
        age_value = sum(
          .data$age_days, .data$age_months, .data$age_years, na.rm = TRUE
        ) |>
          as.integer(),
        age_type = dplyr::case_when(
          !is.na(.data$age_days) ~ "D",
          !is.na(.data$age_months) ~ "M",
          !is.na(.data$age_years) ~ "Y"
        )
      ) |>
      dplyr::select(.data$age_value, .data$age_type)
  } else {
    age_df <- tibble::tibble(age_days, age_months, age_years)
  }

  ## Return age_df ----
  age_df
}

#'
#' @rdname cod_calculate_age
#' @export
#'

cod_calculate_ages <- function(dob,
                               dod,
                               date_format = "%Y-%m-%d",
                               codedit = TRUE) {
  Map(
    f = cod_calculate_age,
    dob = dob,
    dod = dod,
    date_format = date_format,
    codedit = codedit
  ) |>
    dplyr::bind_rows()
}
