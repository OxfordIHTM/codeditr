# Tets for cod_check_dod -------------------------------------------------------

testthat::test_that(
  "cod_check_dod outputs appropriate results", {
    expect_s3_class(cod_check_dod("2024"), "tbl")

    expect_identical(
      cod_check_dod("2024"),
      tibble::tibble(
        dod_check = 0L,
        dod_check_note = factor(
          x = "No issues with date of death value",
          levels = c(
            "No issues with date of death value",
            "Date of death value is not in year format",
            "Missing date of death value"
          )
        )
      )
    )

    expect_identical(
      cod_check_dod("2024-06-01"),
      tibble::tibble(
        dod_check = 1L,
        dod_check_note = factor(
          x = "Date of death value is not in year format",
          levels = c(
            "No issues with date of death value",
            "Date of death value is not in year format",
            "Missing date of death value"
          )
        )
      )
    )

    expect_identical(
      cod_check_dod(NA_character_),
      tibble::tibble(
        dod_check = 2L,
        dod_check_note = factor(
          x = "Missing date of death value",
          levels = c(
            "No issues with date of death value",
            "Date of death value is not in year format",
            "Missing date of death value"
          )
        )
      )
    )
})
