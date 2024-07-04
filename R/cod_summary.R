#'
#' Summarise cause-of-death check results
#'
#' @param cod_check A data.frame output of the various `cod_check_code_*`
#'   functions
#' @param simplify Logical. Should output be converted into a data.frame?
#'   Default is FALSE.
#'
#' @returns If `simplify` is FALSE (default), a list of summary check outputs.
#'   Otherwise, a tabulated summary of check outputs.
#'
#' @examples
#' cod_check_code(
#'   cod_data_raw_example$code, version = "icd11",
#'   sex = cod_data_raw_example$sex, age = cod_data_raw_example$age
#' ) |>
#'   cod_check_code_summary()
#'
#' @rdname cod_check_code_summary
#' @export
#'

cod_check_code_summary <- function(cod_check, simplify = FALSE) {
  cod_check_list <- list(
    cod_check |> dplyr::select(dplyr::contains("note_structure")),
    cod_check |> dplyr::select(dplyr::contains("note_ill")),
    cod_check |> dplyr::select(dplyr::contains("note_unlikely")),
    cod_check |> dplyr::select(dplyr::contains("note_sex")),
    cod_check |> dplyr::select(dplyr::contains("note_age")),
    cod_check |> dplyr::select(dplyr::all_of("cod_check_code_note"))
  ) |>
    (\(x)
      {
        names(x) <- c(
          "Code structure", "Ill-defined code",
          "Unlikely cause-of-death code", "Code not appropriate for sex",
          "Code not appropriate for age",
          "Overall"
        )
        x
      }
    )()

  cod_check_summary <- lapply(
    X = cod_check_list,
    FUN = function(x) dplyr::count(
      x,
      dplyr::across(dplyr::everything()),
      .drop = FALSE
    ) |>
      dplyr::rename_with(.fn = function(x) c("cod_check_note", "n"))
  )

  if (simplify) {
    cod_check_summary <- cod_check_summary |>
      dplyr::bind_rows(.id = "cod_check_type")
  }

  cod_check_summary
}

