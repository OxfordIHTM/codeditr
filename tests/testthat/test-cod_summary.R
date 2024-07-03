# Tests for cod_check_code_summary ---------------------------------------------

test_summary_df <- cod_check_code(
  cod_data_raw_example$code, version = "icd11",
  sex = cod_data_raw_example$sex, age = cod_data_raw_example$age
)


testthat::test_that("cod_check_code_summary outputs appropriate results", {
  expect_type(cod_check_code_summary(test_summary_df), "list")

  expect_s3_class(
    cod_check_code_summary(test_summary_df, simplify = TRUE), "tbl"
  )
})


