# Tests for utility packages ---------------------------------------------------

age <- c(1, 20, 45, 63, 125)
age_type <- c("Y", "M", "D", "M", "Y")

testthat::test_that(
  "get_age_values outputs appropriate results",
  testthat::expect_type(
    get_age_values(age[1], age_type[1]),
    "list"
  )
)


testthat::test_that(
  "list_ill_defined_icd11 outputs appropriate results",
  testthat::expect_vector(list_ill_defined_icd11())
)


code_range <- c("A71.0-A71.9", "F50.1,F50.3-F50.9")

testthat::test_that(
  "expand_icd10_code_range outputs appropriate results",
  testthat::expect_vector(expand_icd10_code_range(code_range))
)
