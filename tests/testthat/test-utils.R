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
