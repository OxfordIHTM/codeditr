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


get_score_combo <- function(scores, labels) {
  ## Check that length(scores) == length(labels) ----
  if (length(scores) != length(labels))
    stop("Scores should have the same lenght as labels.")

  ## Initialize a list to store all combinations ----
  all_combinations_scores <- list()
  all_combinations_labels <- list()

  ## Loop over the length of combinations ----
  for (len in seq_len(length(scores))) {
    ### Get all combinations of length 'len' ----
    combs_scores <- utils::combn(x = scores, m = len)
    combs_labels <- utils::combn(x = labels, m = len)

    ### Convert matrix to list of vectors ----
    combs_scores_list <- lapply(
      X = seq_len(ncol(combs_scores)),
      FUN = function(i) combs_scores[ , i]
    )

    combs_labels_list <- lapply(
      X = seq_len(ncol(combs_labels)),
      FUN = function(i) combs_labels[ , i]
    )

    ### Append to the list of all combinations ----
    all_combinations_scores <- c(all_combinations_scores, combs_scores_list)
    all_combinations_labels <- c(all_combinations_labels, combs_labels_list)
  }

  df <- tibble::tibble(
    score_combos = lapply(all_combinations_scores, paste0, collapse = ",") |>
        unlist(),
    cod_check = lapply(all_combinations_scores, sum) |>
      unlist() |> as.integer(),
    cod_check_note = lapply(all_combinations_labels, paste0, collapse = "; ") |>
        unlist()
  ) |>
    dplyr::arrange(.data$cod_check)

  df
}


#'
#' List ill-defined ICD 11 codes
#'
#' @returns An character vector of ICD 11 codes classified as ill-defined for
#'   cause-of-death
#'
#' @examples
#' list_ill_defined_icd11()
#'
#' @export
#'

list_ill_defined_icd11 <- function() {
  ## Create vector of ill-defined heart failure BD10-BD1Z ----
  set1 <- codigo::icd11_linearization_mms |>
    dplyr::filter(
      .data$ChapterNo == 11 &
        stringr::str_detect(string = .data$Code, pattern = "BD")
    ) |>
    dplyr::slice(1:11) |>
    dplyr::pull(.data$Code)

  ## Create vector of ill-defined others ----
  set2 <- c("BA2Z", "BE2Y", "BE2Z", "CB41.0", "CB41.2", "KB2D", "KB2E")

  ## Get codes for Chapter 21 except 	MA15, MG43, MG44.1, MH11, MH15 ----
  set3 <- codigo::icd11_linearization_mms |>
    dplyr::filter(.data$ChapterNo == 21 & !is.na(.data$Code)) |>
    dplyr::filter(
      !.data$Code %in% c("MA15", "MG43", "MG44.1", "MH11", "MH15")
    ) |>
    dplyr::pull(.data$Code)

  ## Concatenate ill-defined code vectors ----
  c(set1, set2, set3)
}


#'
#' Enumerate ICD 10 codes given a code range
#'
#' @param code_range A character value or a vector of character values
#'   indicating a range of ICD 10 codes. See Details for syntax of code range/s.
#'
#' @returns A vector of ICD 10 codes that are within the range of codes
#'   specified by `code_range`.
#'
#' @examples
#' expand_icd10_code_range("A71.0-A71.9")
#' expand_icd10_code_range("F50.1,F50.3-F50.9")
#'
#' @rdname expand_icd10
#' @export
#'

expand_icd10_code_range <- function(code_range) {
  code_values <- stringr::str_split(
    string = code_range, pattern = ",", simplify = TRUE
  ) |>
    c()

  lapply(
    X = code_values,
    FUN = function(x) if (substr(x, 4, 4) == ".") {
      ifelse(
        stringr::str_detect(string = x, pattern = "-"),
        paste0(
          stringr::str_extract(string = x, pattern = "^.{4}"),
          seq(
            from = stringr::str_extract_all(
              string = x, pattern = "(?<=\\.)\\d+", simplify = TRUE
            ) |> c() |> as.numeric() |> (\(x) x[1])(),
            to = stringr::str_extract_all(
              x, pattern = "(?<=\\.)\\d+", simplify = TRUE
            ) |> c() |> as.numeric() |> (\(x) x[2])()
          )
        ) |>
          paste(collapse = ","),
        x
      )
    } else {
      ifelse(
        stringr::str_detect(string = x, pattern = "-"),
        paste0(
          stringr::str_extract(string = x, pattern = "^.{2}"),
          seq(
            from = substr(x, 3, 3) |> c() |> as.numeric(),
            to = substr(x, nchar(x), nchar(x)) |> c() |> as.numeric()
          )
        ) |>
          paste(collapse = ","),
        x
      )
    }
  ) |>
    stringr::str_split(pattern = ",") |>
    unlist()
}
