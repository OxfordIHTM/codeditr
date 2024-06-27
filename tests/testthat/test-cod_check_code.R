# Tests for cod_check_code functions -------------------------------------------

testthat::test_that("cod_check_code outputs appropriate results", {
  testthat::expect_s3_class(
    cod_check_code(icd10_example$Code, sex = "Sex"),
    "tbl"
  )
  testthat::expect_s3_class(
    cod_check_code(icd11_example$Code, version = "icd11", sex = "Sex"), "tbl"
  )
})

