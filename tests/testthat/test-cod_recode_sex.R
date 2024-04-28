# Tests for recode sex ---------------------------------------------------------

sex_value  <- c(rep(1L, 2), rep(2L, 3), NA_integer_)

sex_value1 <- c(rep("m", 2), rep("f", 3), NA_character_)
sex_code1  <- c("m", "f")

expected <- c(1L, 1L, 2L, 2L, 2L, NA_integer_)
expected_codedit <- c(1L, 1L, 2L, 2L, 2L, 9L)

testthat::test_that(
  "output of recode sex is as expected", {
    expect_vector(
      cod_recode_sex(sex_value = sex_value), ptype = integer(), size = 6
    )

    expect_equal(cod_recode_sex(sex_value = sex_value), expected_codedit)

    expect_vector(
      cod_recode_sex(
        sex_value = sex_value1, sex_code = sex_code1, codedit = FALSE
      ),
      ptype = integer(),
      size = 6
    )

    expect_equal(
      cod_recode_sex(
        sex_value = sex_value1, sex_code = sex_code1, codedit = FALSE
      ),
      expected
    )

    expect_vector(
      cod_recode_sex(sex_value = sex_value1, sex_code = sex_code1),
      ptype = integer(),
      size = 6
    )

    expect_equal(
      cod_recode_sex(
        sex_value = sex_value1, sex_code = sex_code1, codedit = TRUE
      ),
      expected_codedit
    )
  }
)
