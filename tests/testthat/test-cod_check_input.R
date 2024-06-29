# Tests for cod_check_input ----------------------------------------------------

testthat::test_that(
  "cod_check_input outputs appropriate results", {
    expect_s3_class(cod_check_codedit_input(icd10_example), "tbl")

    expect_named(
      cod_check_codedit_input(icd10_example),
      c("sex_check", "sex_check_note",
        "age_check", "age_check_note",
        "code_check", "code_check_note",
        "dod_check", "dod_check_note")
    )
})
