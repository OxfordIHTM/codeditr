# Tests for recode age type ----------------------------------------------------

age_type       <- c(rep("D", 3), rep("M", 2), rep("Y", 3))

age_type1      <- c(rep("d", 3), rep("m", 2), rep("y", 3))
age_type_code1 <- c("d", "m", "y")

age_type2      <- c(rep("days", 3), rep("months", 2), rep("years", 3))
age_type_code2 <- c("days", "months", "years")

age_type3      <- c(rep(1L, 3), rep(2L, 2), rep(3L, 3))
age_type_code3 <- c(1L, 2L, 3L)

age_type4      <- c(rep("d", 3), "m", NA_character_, rep("y", 3))
age_type_code4 <- c("d", "m", "y")

age_type5      <- c(rep(1L, 3), 2L, NA_integer_, rep(3L, 3))
age_type_code5 <- c(1L, 2L, 3L)

expected    <- c(rep("D", 3), rep("M", 2), rep("Y", 3))
expected_na <- c(rep("D", 3), "M", NA_character_, rep("Y", 3))


testthat::test_that(
  "output of recode age type is as expected", {
    expect_vector(
      cod_recode_age_type(age_type = age_type),
      ptype = character(),
      size = 8
    )

    expect_equal(
      cod_recode_age_type(age_type = age_type),
      expected
    )

    ## input is different characters ----
    expect_vector(
      cod_recode_age_type(age_type = age_type1, age_type_code = age_type_code1),
      ptype = character(),
      size = 8
    )

    expect_equal(
      cod_recode_age_type(age_type = age_type1, age_type_code = age_type_code1),
      expected
    )

    ## input is different characters ----
    expect_vector(
      cod_recode_age_type(age_type = age_type2, age_type_code = age_type_code2),
      ptype = character(),
      size = 8
    )

    expect_equal(
      cod_recode_age_type(age_type = age_type2, age_type_code = age_type_code2),
      expected
    )

    ## input is integer ----
    expect_vector(
      cod_recode_age_type(age_type = age_type3, age_type_code = age_type_code3),
      ptype = character(),
      size = 8
    )

    expect_equal(
      cod_recode_age_type(age_type = age_type3, age_type_code = age_type_code3),
      expected
    )

    ## input has NA ----
    expect_vector(
      cod_recode_age_type(age_type = age_type4, age_type_code = age_type_code4),
      ptype = character(),
      size = 8
    )

    expect_equal(
      cod_recode_age_type(age_type = age_type4, age_type_code = age_type_code4),
      expected_na
    )

    ## input has NA ----
    expect_vector(
      cod_recode_age_type(age_type = age_type5, age_type_code = age_type_code5),
      ptype = character(),
      size = 8
    )

    expect_equal(
      cod_recode_age_type(age_type = age_type5, age_type_code = age_type_code5),
      expected_na
    )
  }
)
