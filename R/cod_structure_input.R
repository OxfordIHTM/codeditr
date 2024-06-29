#'
#' Structure cause-of-death data into CoDEdit tool input data
#'
#' @param df A data.frame of raw cause-of-death data with the following
#'   required variables that contains values for sex, date of birth,
#'   date of death, and cause-of-death code.
#' @param sex A character value for the variable name in `df` containing
#'   the values for sex.
#' @param sex_code A character or integer vector of 2 values that indicate
#'   which values are to be considered pertaining to males (first value in the
#'   vector) or to females (second value in the vector).
#' @param dob A character value for the variable name in `df` containing
#'   the values for date of birth.
#' @param dod A character value for the variable name in `df` containing
#'   the values for date of death.
#' @param code A character value for the variable name in `df` containing
#'   the values for cause-of-death code.
#' @param id A character value for the variable name in `df` containing unique
#'   record identifiers. Default to NULL. If NULL, unique record identifiers
#'   will be generated.
#'
#' @returns A tibble with 6 columns and number of rows equal to `df` with
#'   names `"FreeId"`, `"Sex"`, `"Age Value"`, `"Age Type"`, `"Code"`, and
#'   `"Death Date"`.
#'
#' @examples
#' df <- data.frame(
#'   id = 1:3,
#'   sex = c(1, 1, 2),
#'   dob = c("1977-11-05", "1971-04-04", "2012-08-13"),
#'   dod = c("2024-06-28", "2023-10-11", "2023-09-25"),
#'   code = c("P219", "O230", "Q913")
#' )
#'
#' cod_structure_input(df, sex = "sex", dob = "dob", dod = "dod", code = "code")
#'
#' @rdname cod_structure
#' @export
#'

cod_structure_input <- function(df, sex, sex_code = c(1, 2),
                                dob, dod, code, id = NULL) {
  if (is.null(id)) {
    FreeId <- seq(from = 1, to = nrow(df))
  } else {
    FreeId <- id
  }

  Sex <- cod_recode_sex(sex_value = df[[sex]], sex_code = sex_code)

  age_df <- cod_calculate_age(dob = df[[dob]], dod = df[[dod]]) |>
    (\(x) { names(x) <- c("Age Value", "Age Type"); x })()

  Code <- df[[code]]

  `Death Date` <- format(as.Date(df[[dod]]), "%Y")

  tibble::tibble(FreeId, Sex, age_df, Code, `Death Date`)
}
