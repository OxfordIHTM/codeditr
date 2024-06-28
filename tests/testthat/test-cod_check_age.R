# Tests for check age functions ------------------------------------------------

age_value <- c(25, 35, 5, NA, 104, 999)
age_type <- c("D", "D", "M", "Y", NA_character_, "Y")

expected_score <- c(0L, 2L, 0L, 7L, 8L, 6L)
expected_note <- c(
  "No issues with age value and age type",
  "Should probably be converted to age value of age type months (M) not days (D)",
  "No issues with age value and age type",
  "Missing age value",
  "Missing age type",
  "Age value is more than 125 years which is highly unlikely"
) |>
  factor(
    levels = c(
      "No issues with age value and age type",
      "Should probably be age value of 1 and age type of months (M)",
      "Should probably be converted to age value of age type months (M) not days (D)",
      "Should probably be converted to age value of age type days (D)",
      "Should probably be converted to age value of age type years (Y)",
      "Should probably be converted to age value of age type months (M) not years (Y)",
      "Age value is more than 125 years which is highly unlikely",
      "Missing age value",
      "Missing age type",
      "Missing age value and age type"
    )
  )


test_that(
  "output is as expected", {
    expect_s3_class(
      cod_check_age(age_value = age_value, age_type = age_type), "tbl"
    )

    expect_equal(
      cod_check_age(age_value = age_value, age_type = age_type),
      tibble::tibble(
        age_check = expected_score,
        age_check_note = expected_note
      )
    )

    expect_type(
      cod_check_age(age_value = age_value, age_type = age_type)$age_check,
      "integer"
    )

    expect_s3_class(
      cod_check_age(age_value = age_value, age_type = age_type)$age_check_note,
      "factor"
    )

    expect_error(cod_check_age(age_value = "1", age_type = "D"))
  }
)
