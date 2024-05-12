# Tests for calculating age function -------------------------------------------

dob <- c("1977-11-05", "1971-04-04", "2012-08-13")
dod <- c(Sys.Date(), "2023-10-11", "2023-09-25")


testthat::test_that(
  "output is as expected", {
    expect_s3_class(cod_calculate_ages(dob = dob, dod = dod), "tbl")

    expect_named(
      cod_calculate_ages(dob = dob, dod = dod),
      expected = c("age_value", "age_type")
    )

    expect_s3_class(
      cod_calculate_ages(dob = dob, dod = dod, codedit = FALSE),
      "tbl"
    )

    expect_named(
      cod_calculate_ages(dob = dob, dod = dod, codedit = FALSE),
      expected = c("age_days", "age_months", "age_years")
    )
  }
)
