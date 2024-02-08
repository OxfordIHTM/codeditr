#'
#' Example death records dataset with ICD10 cause-of-death coding
#'
#' @format A data frame with 6 columns and 3613 rows:
#'
#' | **Variable** | **Description** |
#' | :--- | :--- |
#' | *FreeId* | Record identifier |
#' | *Sex* | Sex: 1 = Male; 2 = Female; 9 = unknown |
#' | *Age Value* | Integer value for age |
#' | *Age Type* | Is the age value in days (D), months (M), or years (Y) |
#' | *Code* | ICD10 code for cause-of-death |
#' | *Death Date* | Date of death in year format |
#'
#' @examples
#' icd10_example
#'
#' @source https://www.who.int/standards/classifications/classification-of-diseases/services/codedit-tool
#'
"icd10_example"



#'
#' Example death records dataset with ICD11 cause-of-death coding
#'
#' @format A data frame with 6 columns and 244 rows:
#'
#' | **Variable** | **Description** |
#' | :--- | :--- |
#' | *FreeId* | Record identifier |
#' | *Sex* | Sex: 1 = Male; 2 = Female; 9 = unknown |
#' | *Age Value* | Integer value for age |
#' | *Age Type* | Is the age value in days (D), months (M), or years (Y) |
#' | *Code* | ICD11 code for cause-of-death |
#' | *Death Date* | Date of death in year format |
#'
#' @examples
#' icd11_example
#'
#' @source https://www.who.int/standards/classifications/classification-of-diseases/services/codedit-tool
#'
"icd11_example"

