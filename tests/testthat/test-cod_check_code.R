# Tests for cod_check_code functions -------------------------------------------

test_that("cod_check_code outputs appropriate results", {
  expect_s3_class(
    cod_check_code(
      icd10_example$Code, sex = icd10_example$Sex,
      age = icd10_example$`Age Value`
    ),
    "tbl"
  )

  expect_s3_class(
    cod_check_code(
      icd11_example$Code, version = "icd11",
      sex = icd11_example$Sex, age = icd11_example$`Age value`),
    "tbl"
  )
})


code <- c(sample(icd10_cod_neonate$code, size = 4),
          sample(icd10_cod_child$code, size = 4))
sex <- rep(c(1, 1, 2, 1), 2)
age <- c(0, 0, 1, 5, 0, 10, 11, 9)

test_icd10_df <- data.frame(age, sex, code)

code <- c(sample(icd11_cod_neonate$code, size = 4),
          sample(icd11_cod_child$code, size = 4))
sex <- rep(c(1, 1, 2, 1), 2)
age <- c(0, 0, 1, 5, 0, 10, 11, 9)

test_icd11_df <- data.frame(age, sex, code)

test_that("cod_check_code outputs appropriate age test results", {
  expect_s3_class(
    cod_check_code(
      test_icd10_df$code, sex = test_icd10_df$sex, age = test_icd10_df$age
    ),
    "tbl"
  )

  expect_s3_class(
    cod_check_code(
      test_icd11_df$code, sex = test_icd11_df$sex, age = test_icd11_df$age
    ),
    "tbl"
  )
})
