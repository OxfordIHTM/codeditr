# Tests for cod_check_code functions -------------------------------------------

test_that("cod_check_code outputs appropriate results", {
  expect_s3_class(
    cod_check_code(icd10_example$Code, sex = "Sex"),
    "tbl"
  )

  expect_s3_class(
    cod_check_code(icd11_example$Code, version = "icd11", sex = "Sex"), "tbl"
  )
})

