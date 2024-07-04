#'
#' Check date of death value in cause-of-death data based on CoDEdit rules
#'
#' @param dod Date of death value expressed in terms of the year death
#'   occurred.
#'
#' @returns A tibble with number of rows equal to length of `dod` and
#'   two columns for dod_check and dod_check_note.
#'
#' @examples
#' cod_check_dod("2024")
#'
#' @rdname cod_check_dod
#' @export
#'

cod_check_dod <- function(dod) {
  ## Check if dod is not a year value ----
  dod_check <- ifelse(
    nchar(dod) > 4 | stringr::str_detect(dod, pattern = "[a-zA-Z]"),
    1L, 0L
  )

  ## Check if dod is missing ----
  dod_check <- ifelse(is.na(dod), 2L, dod_check)

  ## Create dod_check note vector ----
  dod_check_note <- vector(mode = "character", length = length(dod))

  dod_check_note[dod_check == 0] <- "No issues with date of death value"
  dod_check_note[dod_check == 1] <- "Date of death value is not in year format"
  dod_check_note[dod_check == 2] <- "Missing date of death value"

  ## Return output ----
  tibble::tibble(dod_check, dod_check_note) |>
    dplyr::mutate(
      dod_check_note = factor(
        x = dod_check_note,
        levels = c(
          "No issues with date of death value",
          "Date of death value is not in year format",
          "Missing date of death value"
        )
      )
    )
}

