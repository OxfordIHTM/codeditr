#'
#' Check structure and values of input data to CoDEdit tool
#'
#' @param df A data.frame with 6 columns with names `"FreeId"`, `"Sex"`,
#'   `"Age Value"`, `"Age Type"`, `"Code"`, and `"Death Date"` and compatible
#'   with the input data required by the CoDEdit tool.
#'
#' @returns A data.frame containing check codes and check notes for each row
#'   and variable identified with the `FreeId` of `df`.
#'
#' @examples
#' cod_check_codedit_input(icd10_example)
#'
#' @rdname cod_check_input
#' @export
#'

cod_check_codedit_input <- function(df) {
  ## Expected field names ----
  fields <- c("FreeId", "Sex", "Age Value", "Age Type", "Code", "Death Date")

  missing_fields <- !fields %in% names(df)

  ## Check that all expected fields are present ----
  if (any(missing_fields)) {
    warning(
      paste0(
        "The data has the following missing fields: ",
        paste(fields[missing_fields], collapse = ", "), "."
      )
    )
  }

  ## Check sex ----
  sex_check <- cod_check_sex(sex_value = df$Sex)

  ## Check age ----
  age_check <- cod_check_age(
    age_value = df$`Age Value`, age_type = df$`Age Type`
  )

  ## Check if code is missing ---
  code_check <- ifelse(is.na(df$Code), 1L, 0L)
  code_check_note <- ifelse(
    code_check == 1L,
    "Cause of death code is missing.",
    "Cause of death code is not missing."
    )

  ## Check if date of death is missing ---
  dod_check <- cod_check_dod(df$`Death Date`)

  ## Return tibble of check results ----
  tibble::tibble(
    sex_check, age_check,
    code_check, code_check_note,
    dod_check
  )
}

