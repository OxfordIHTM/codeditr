# Tests for cod_structure_input ------------------------------------------------

df <- data.frame(
  id = 1:3,
  sex = c(1, 1, 2),
  dob = c("1977-11-05", "1971-04-04", "2012-08-13"),
  dod = c("2024-06-28", "2023-10-11", "2023-09-25"),
  code = c("P219", "O230", "Q913")
)


testthat::test_that(
  "cod_structure_input outputs appropriate results", {
    expect_s3_class(
      cod_structure_input(
        df, sex = "sex", dob = "dob", dod = "dod", code = "code"
      ),
      "tbl"
    )

    expect_s3_class(
      cod_structure_input(
        df = df, sex = "sex", dob = "dob", dod = "dod", code = "code", id = "id"
      ),
      "tbl"
    )
})
