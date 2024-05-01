# Tests for check sex function -------------------------------------------------

sex_value1 <- c(1L, 1L, 1L, 2L, 2L, 1L, 9L)
sex_code1 <- c(1, 2)

sex_value2 <- c("m", "m", "m", "f", "f", "m", NA_character_)
sex_code2 <- c("m", "f")

sex_value3 <- c("M", "M", "M", "F", "F", "M", NA_character_)
sex_code3 <- c("M", "F")

sex_check <- c(rep(0L, 6), 3L)
sex_check_note <- c(rep("No issues with sex value", 6), "Missing sex value")


testthat::test_that(
  "output is as expected", {
    expect_s3_class(
      cod_check_sex(sex_value = sex_value1, sex_code = sex_code1), "tbl"
    )

    expect_s3_class(
      cod_check_sex(sex_value = sex_value2, sex_code = sex_code2), "tbl"
    )

    expect_s3_class(
      cod_check_sex(sex_value = sex_value3, sex_code = sex_code3), "tbl"
    )

    expect_equal(
      cod_check_sex(sex_value = sex_value1, sex_code = sex_code1),
      tibble::tibble(sex_check, sex_check_note)
    )

    expect_equal(
      cod_check_sex(sex_value = sex_value2, sex_code = sex_code2),
      tibble::tibble(sex_check, sex_check_note)
    )

    expect_equal(
      cod_check_sex(sex_value = sex_value3, sex_code = sex_code3),
      tibble::tibble(sex_check, sex_check_note)
    )

    expect_named(
      cod_check_sex(sex_value = sex_value1, sex_code = sex_code1),
      c("sex_check", "sex_check_note")
    )
  }
)
