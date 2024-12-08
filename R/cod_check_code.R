#'
#' Check cause-of-death code for code entry mistakes and/or code completeness
#'
#' @param cod A character value or vector of values for cause-of-death code/s.
#' @param version A character value for ICD version used. This should be either
#'   *"icd10"* or *"icd11"*. Default is *"icd10"*.
#' @param sex A character value or vector of values for sex of individual
#'   associated with the specified `cod`.
#' @param age An integer value or vector of values for age (in years) of
#'   individual.
#'
#' @returns A tibble with 2 columns/fields. First is an integer value indicating
#'   whether there is an issue with the cause-of-death code provided in relation
#'   to a potential code entry mistake and/or and issue of code completeness.
#'
#' @examples
#' cod_check_code("U100", sex = 1, age = 10)
#' cod_check_code("2C6Z", version = "icd11", sex = 1, age = 65)
#'
#' @rdname cod_check_code
#' @export
#'

cod_check_code <- function(cod, version = c("icd10", "icd11"), sex, age) {
  ## Determine value for version ----
  version <- match.arg(version)

  cod_check_code_structure <- eval(
    parse(text = paste0("cod_check_code_structure_", version, "(cod = cod)"))
  ) |>
    dplyr::rename_with(.fn = function(x) paste0(x, "_structure"))

  cod_check_code_ill_defined <- eval(
    parse(text = paste0("cod_check_code_ill_defined_", version, "(cod = cod)"))
  ) |>
    dplyr::rename_with(.fn = function(x) paste0(x, "_ill_defined"))

  cod_check_code_unlikely <- eval(
    parse(text = paste0("cod_check_code_unlikely_", version, "(cod = cod)"))
  ) |>
    dplyr::rename_with(.fn = function(x) paste0(x, "_unlikely"))

  cod_check_code_sex <- eval(
    parse(
      text = paste0("cod_check_code_sex_", version, "(cod = cod, sex = sex)")
    )
  ) |>
    dplyr::rename_with(.fn = function(x) paste0(x, "_sex"))

  cod_check_code_age <- eval(
    parse(
      text = paste0(
        "cod_check_code_age_", version, "(cod = cod, age = age)"
      )
    )
  ) |>
    dplyr::rename_with(.fn = function(x) paste0(x, "_age"))

  tibble::tibble(
    cod_check_code_structure, cod_check_code_ill_defined,
    cod_check_code_unlikely, cod_check_code_sex, cod_check_code_age
  ) |>
    dplyr::mutate(
      cod_check_code = rowSums(
        data.frame(
          .data$cod_check_structure,
          .data$cod_check_ill_defined,
          .data$cod_check_unlikely,
          .data$cod_check_sex,
          .data$cod_check_age
        ),
        na.rm = TRUE
      ) |>
        (\(x) ifelse(x == 0, 0, 1))(),
      cod_check_code_note = ifelse(
        cod_check_code == 0,
        "No issues found in CoD code",
        "Issues found in CoD code"
      ) |>
        factor(
          levels = c("No issues found in CoD code", "Issues found in CoD code")
        )
    )
}


#'
#' @rdname cod_check_code
#' @export
#'

cod_check_code_structure_icd10 <- function(cod) {
  ## Create concatenating vector for check scores ----
  cod_check <- vector(mode = "integer", length = length(cod))

  ## Assess cod/s ----

  ### code puts . in the 4th position ----
  cod_check <- ifelse(
    stringr::str_detect(string = cod, pattern = "\\.", negate = TRUE),
    cod_check,
    ifelse(
      stringr::str_detect(string = cod, pattern = "^.{3}\\.", negate = TRUE),
      cod_check + 1L,
      cod_check
    )
  )

  ### Remove . so that next checks will work as appropriate ----
  cod <- stringr::str_remove_all(string = cod, pattern = "\\.")

  ### Standardise cod by making all character values to uppercase ----
  cod <- toupper(cod)

  ### code length of 2 or less ----
  cod_check <- ifelse(stringr::str_count(cod) <= 2, cod_check + 2L, cod_check)

  ### code length of 3 (warning) ----
  #cod_check <- ifelse(stringr::str_count(cod) == 3, cod_check + 4, cod_check)

  ### code does not start with a character value ----
  cod_check <- ifelse(
    stringr::str_detect(string = cod, pattern = "^[A-Za-z]", negate = TRUE),
    cod_check + 4L, cod_check
  )

  ### code starts with a U or contains U ----
  cod_check <- ifelse(
    stringr::str_detect(string = cod, pattern = "U"),
    cod_check + 8L, cod_check
  )

  ### code uses asterisk code style ----
  cod_check <- ifelse(
    substr(x = cod, start = nchar(cod), stop = nchar(cod)) == "*",
    cod_check + 16L, cod_check
  )

  ### code is missing ----
  cod_check <- ifelse(is.na(cod), 32L, cod_check)

  ## Get combination of scores, total scores, and labels ----
  check_values <- get_score_combo(
    scores = c(1, 2, 4, 8, 16),
    labels = c(
      "CoD code has a period (`.`) character in the wrong place",
      "CoD code is 2 or less characters long",
      "CoD code does not start with a character value",
      "CoD code contains the character value `U`",
      "CoD code uses asterisk"
    )
  )

  cod_check_note <- cut(
    x = cod_check,
    breaks = c(0, check_values$cod_check, 32, Inf),
    labels = c(
      "No issues found in CoD code",
      check_values$cod_check_note,
      "CoD code is missing"
    ),
    include.lowest = TRUE, right = FALSE
  )

  tibble::tibble(cod_check, cod_check_note)
}


#'
#' @rdname cod_check_code
#' @export
#'

cod_check_code_structure_icd11 <- function(cod) {
  ## Create concatenating vector for check scores ----
  cod_check <- vector(mode = "integer", length = length(cod))

  ## Assess cod/s ----

  ### code puts . in the 5th position ----
  cod_check <- ifelse(
    stringr::str_detect(string = cod, pattern = "\\.", negate = TRUE),
    cod_check,
    ifelse(
      stringr::str_detect(string = cod, pattern = "^.{4}\\.", negate = TRUE),
      cod_check + 1L,
      cod_check
    )
  )

  ### Remove . so that next checks will work as appropriate ----
  cod <- stringr::str_remove_all(string = cod, pattern = "\\.")

  ### Standardise cod by making all character values to uppercase ----
  cod <- toupper(cod)

  ### First character is not O or I ----
  cod_check <- ifelse(
    stringr::str_detect(string = cod, pattern = "^O|^I"),
    cod_check + 2L, cod_check
  )

  ### Second character is alphabet ----
  cod_check <- ifelse(
    stringr::str_detect(string = cod, pattern = "^.{1}[A-Z]", negate = TRUE),
    cod_check + 4L, cod_check
  )

  ### Second character is not O or I ----
  cod_check <- ifelse(
    stringr::str_detect(string = cod, pattern = "^.{1}O|I"),
    cod_check + 8L, cod_check
  )

  ### Third character is a number ----
  cod_check <- ifelse(
    stringr::str_detect(string = cod, pattern = "^.{2}[0-9]{1}", negate = TRUE),
    cod_check + 16L, cod_check
  )

  ### Fourth character is not O or I ----
  cod_check <- ifelse(
    stringr::str_detect(string = cod, pattern = "^O|^I"),
    cod_check + 32L, cod_check
  )

  ### code is missing ----
  cod_check <- ifelse(is.na(cod), 64L, cod_check)

  ## Get combination of scores, total scores, and labels ----
  check_values <- get_score_combo(
    scores = c(1, 2, 4, 8, 16, 32),
    labels = c(
      "CoD code has a period (`.`) character in the wrong place",
      "CoD code starts with `O` or `I`",
      "CoD code has a number as its second value",
      "CoD code has `O` or `I` as its second value",
      "CoD code has a letter as its third value",
      "CoD code has `O` or `I` as its fourth value"
    )
  )

  cod_check_note <- cut(
    x = cod_check,
    breaks = c(0, check_values$cod_check, 64, Inf),
    labels = c(
      "No issues found in CoD code",
      check_values$cod_check_note,
      "CoD code is missing"
    ),
    include.lowest = TRUE, right = FALSE
  )

  tibble::tibble(cod_check, cod_check_note)
}

#'
#' @rdname cod_check_code
#' @export
#'
cod_check_code_ill_defined_icd10 <- function(cod) {
  set1 <- ifelse(
    cod %in% c("I46.1", "I46.9", "I95.9", "I99", "J96.0", "P28.5"), 1L, 0L
  )

  set2 <- ifelse(stringr::str_detect(string = cod, pattern = "^I50"), 1L, 0L)

  set3 <- ifelse(
    stringr::str_detect(
      string = cod,
      pattern = "^R0|R1|R2|R3|R4|R50|R51|R52|R53|R54|R55|R56|R57|R61|R62|R63|R64|R65.2|R65.3|R68|R69|R7|R8|R91|R92|R93|R94|R96|R97|R98|R99"
    ),
    1L, 0L
  )

  cod_check <- rowSums(data.frame(set1, set2, set3), na.rm = TRUE)
  cod_check_note <- ifelse(
    cod_check == 0L,
    "No issues found in CoD code",
    "CoD code is an ill-defined code"
  )

  tibble(cod_check, cod_check_note) |>
    dplyr::mutate(
      cod_check_note = factor(
        x = cod_check_note,
        levels = c(
          "No issues found in CoD code",
          "CoD code is an ill-defined code"
        )
      )
    )
}


#'
#' @rdname cod_check_code
#' @export
#'

cod_check_code_ill_defined_icd11 <- function(cod) {
  cod_check <- ifelse(
    cod %in% list_ill_defined_icd11(), 1L, 0L
  )

  cod_check_note <- ifelse(
    cod_check == 0L,
    "No issues found in CoD code",
    "CoD code is an ill-defined code"
  )

  tibble(cod_check, cod_check_note) |>
    dplyr::mutate(
      cod_check_note = factor(
        x = cod_check_note,
        levels = c(
          "No issues found in CoD code",
          "CoD code is an ill-defined code"
        )
      )
    )
}


#'
#' @rdname cod_check_code
#' @export
#'
cod_check_code_unlikely_icd10 <- function(cod) {
  unlikely_cod <- expand_icd10_code_range(codeditr::icd10_unlikely_cod$code)

  cod_check <- ifelse(cod %in% unlikely_cod, 1L, 0L)
  cod_check_note <- ifelse(
    cod_check == 0L,
    "No issues found in CoD code",
    "CoD code is an unlikely cause-of-death"
  )

  tibble(cod_check, cod_check_note) |>
    dplyr::mutate(
      cod_check_note = factor(
        x = cod_check_note,
        levels = c(
          "No issues found in CoD code",
          "CoD code is an unlikely cause-of-death"
        )
      )
    )
}

#'
#' @rdname cod_check_code
#' @export
#'

cod_check_code_unlikely_icd11 <- function(cod) {
  cod_check <- ifelse(
    cod %in% codeditr::icd11_unlikely_cod, 1L, 0L
  )

  cod_check_note <- ifelse(
    cod_check == 0L,
    "No issues found in CoD code",
    "CoD code is an unlikely cause-of-death"
  )

  tibble(cod_check, cod_check_note) |>
    dplyr::mutate(
      cod_check_note = factor(
        x = cod_check_note,
        levels = c(
          "No issues found in CoD code",
          "CoD code is an unlikely cause-of-death"
        )
      )
    )
}

#'
#' @rdname cod_check_code
#' @export
#'

cod_check_code_sex_icd10_ <- function(cod, sex) {
  if (cod %in% codeditr::icd10_cod_by_sex$code) {
    cod_sex <- codeditr::icd10_cod_by_sex |>
      dplyr::filter(.data$code == cod) |>
      dplyr::pull(.data$sex)

    cod_check <- ifelse(sex == cod_sex, 0L, 1L)
  } else {
    cod_check <- 0L
  }

  cod_check_note <- ifelse(
    cod_check == 0L,
    "No issues found in CoD code",
    "CoD code is not appropriate for person's sex"
  )

  tibble::tibble(cod_check, cod_check_note) |>
    dplyr::mutate(
      cod_check_note = factor(
        x = cod_check_note,
        levels = c(
          "No issues found in CoD code",
          "CoD code is not appropriate for person's sex"
        )
      )
    )
}


#'
#' @rdname cod_check_code
#' @export
#'

cod_check_code_sex_icd10 <- function(cod, sex) {
  Map(
    f = cod_check_code_sex_icd10_,
    cod = cod,
    sex = sex
  ) |>
    dplyr::bind_rows()
}


#'
#' @rdname cod_check_code
#' @export
#'

cod_check_code_sex_icd11_ <- function(cod, sex) {
  if (cod %in% codeditr::icd11_cod_by_sex$code) {
    cod_sex <- codeditr::icd11_cod_by_sex |>
      dplyr::filter(.data$code == cod) |>
      dplyr::pull(.data$sex)

    cod_check <- ifelse(sex == cod_sex, 0L, 1L)
  } else {
    cod_check <- 0L
  }

  cod_check_note <- ifelse(
    cod_check == 0L,
    "No issues found in CoD code",
    "CoD code is not appropriate for person's sex"
  )

  tibble::tibble(cod_check, cod_check_note) |>
    dplyr::mutate(
      cod_check_note = factor(
        x = cod_check_note,
        levels = c(
          "No issues found in CoD code",
          "CoD code is not appropriate for person's sex"
        )
      )
    )
}


#'
#' @rdname cod_check_code
#' @export
#'

cod_check_code_sex_icd11 <- function(cod, sex) {
  Map(
    f = cod_check_code_sex_icd11_,
    cod = cod,
    sex = sex
  ) |>
    dplyr::bind_rows()
}


#'
#' @rdname cod_check_code
#' @export
#'

cod_check_code_age_icd10_ <- function(cod, age) {
  if (cod %in% codeditr::icd10_cod_neonate$code) {
    cod_check <- ifelse(age < 1, 0L, 1L)
  } else {
    if (cod %in% codeditr::icd10_cod_child$code) {
      cod_check <- ifelse(age < 18, 0L, 1L)
    } else {
      cod_check <- 0L
    }
  }

  cod_check_note <- ifelse(
    cod_check == 0L,
    "No issues found in CoD code",
    "CoD code is not appropriate for person's age"
  )

  tibble::tibble(cod_check, cod_check_note) |>
    dplyr::mutate(
      cod_check_note = factor(
        x = cod_check_note,
        levels = c(
          "No issues found in CoD code",
          "CoD code is not appropriate for person's age"
        )
      )
    )
}


#'
#' @rdname cod_check_code
#' @export
#'

cod_check_code_age_icd10 <- function(cod, age) {
  Map(
    f = cod_check_code_age_icd10_,
    cod = cod,
    age = age
  ) |>
    dplyr::bind_rows()
}

#'
#' @rdname cod_check_code
#' @export
#'

cod_check_code_age_icd11_ <- function(cod, age) {
  if (cod %in% codeditr::icd11_cod_neonate$code) {
    cod_check <- ifelse(age < 1, 0L, 1L)
  } else {
    if (cod %in% codeditr::icd11_cod_child$code) {
      cod_check <- ifelse(age < 18, 0L, 1L)
    } else {
      cod_check <- 0L
    }
  }

  cod_check_note <- ifelse(
    cod_check == 0L,
    "No issues found in CoD code",
    "CoD code is not appropriate for person's age"
  )

  tibble::tibble(cod_check, cod_check_note) |>
    dplyr::mutate(
      cod_check_note = factor(
        x = cod_check_note,
        levels = c(
          "No issues found in CoD code",
          "CoD code is not appropriate for person's age"
        )
      )
    )
}


#'
#' @rdname cod_check_code
#' @export
#'

cod_check_code_age_icd11 <- function(cod, age) {
  Map(
    f = cod_check_code_age_icd11_,
    cod = cod,
    age = age
  ) |>
    dplyr::bind_rows()
}
