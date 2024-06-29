# Tets for cod_check_dod -------------------------------------------------------

testthat::test_that(
  "cod_check_dod outputs appropriate results", {
    expect_s3_class(cod_check_dod("2024"), "tbl")

    expect_identical(
      cod_check_dod("2024"),
      tibble::tibble(
        dod_check = 0L,
        dod_check_note = "No issues with date of death value"
      )
    )

    expect_identical(
      cod_check_dod("2024-06-01"),
      tibble::tibble(
        dod_check = 1L,
        dod_check_note = "Date of death value is not in year format"
      )
    )
})
