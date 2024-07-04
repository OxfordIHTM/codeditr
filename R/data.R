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


#'
#' Unlikely causes of death for ICD 10
#'
#' @format A data frame with 2 columns and 424 rows:
#'
#' | **Variable** | **Description** |
#' | :--- | :--- |
#' | *code* | ICD 10 Cause of Death code |
#' | *title* | Cause of death title |
#'
#' @examples
#' icd10_unlikely_cod
#'
#' @source https://icd.who.int/browse10/Content/statichtml/ICD10Volume2_en_2019.pdf
#'
"icd10_unlikely_cod"


#'
#' Unlikely causes of death for ICD 11
#'
#' @format A data frame with 2 columns and 269 rows:
#'
#' | **Variable** | **Description** |
#' | :--- | :--- |
#' | *code* | ICD 11 Cause of Death code |
#' | *title* | Cause of death title |
#'
#' @examples
#' icd11_unlikely_cod
#'
#' @source https://icd.who.int/valuesets/viewer/582/en
#'
"icd11_unlikely_cod"



#'
#' Sex-specific causes of death for ICD 11
#'
#' @format A data frame with 3 columns and 547 rows:
#'
#' | **Variable** | **Description** |
#' | :--- | :--- |
#' | *code* | ICD 11 Cause of Death code |
#' | *title* | Cause of death title |
#' | *sex* | Sex - 1 for male; 2 for female |
#'
#'
#' @examples
#' icd11_cod_by_sex
#'
#' @source https://icdcdn.who.int/icd11referenceguide/en/html/index.html#list-of-categories-limited-to-or-more-likely-to-occur-in-female-persons
#'
"icd11_cod_by_sex"


#'
#' Sex-specific causes of death for ICD 10
#'
#' @format A data frame with 3 columns and 880 rows:
#'
#' | **Variable** | **Description** |
#' | :--- | :--- |
#' | *code* | ICD 10 Cause of Death code |
#' | *title* | Cause of death title |
#' | *sex* | Sex - 1 for male; 2 for female |
#'
#'
#' @examples
#' icd10_cod_by_sex
#'
#' @source https://icd.who.int/browse10/Content/statichtml/ICD10Volume2_en_2019.pdf
#'
"icd10_cod_by_sex"


#'
#' Example raw cause-of-death dataset
#'
#' @format A data frame with 6 columns and 20 rows:
#'
#' | **Variable** | **Description** |
#' | :--- | :--- |
#' | *id* | Unique identifier |
#' | *sex* | Sex of deceased |
#' | *age* | Age of diseased in years |
#' | *code* | ICD 11 cause-of-death code |
#' | *dod* | Date of death |
#' | *dob* | Date of birth |
#'
#' @examples
#' cod_data_raw_example
#'
"cod_data_raw_example"


#'
#' Neonate-specific cause-of-death for ICD 10
#'
#' @format A data frame with 2 columns and 42 rows:
#'
#' | **Variable** | **Description** |
#' | :--- | :--- |
#' | *code* | ICD 10 Cause of Death code |
#' | *title* | Cause of death title |
#'
#'
#' @examples
#' icd10_cod_neonate
#'
#' @source https://www.icd10data.com/ICD10CM/Codes/Rules/Newborn_Codes
#'
"icd10_cod_neonate"


#'
#' Neonate-specific cause-of-death for ICD 11
#'
#' @format A data frame with 2 columns and 50 rows:
#'
#' | **Variable** | **Description** |
#' | :--- | :--- |
#' | *code* | ICD 11 Cause of Death code |
#' | *title* | Cause of death title |
#'
#'
#' @examples
#' icd11_cod_neonate
#'
#'
"icd11_cod_neonate"


#'
#' Child-specific cause-of-death for ICD 10
#'
#' @format A data frame with 2 columns and 122 rows:
#'
#' | **Variable** | **Description** |
#' | :--- | :--- |
#' | *code* | ICD 10 Cause of Death code |
#' | *title* | Cause of death title |
#'
#'
#' @examples
#' icd10_cod_child
#'
#' @source https://www.icd10data.com/ICD10CM/Codes/Rules/Pediatric_Codes
#'
"icd10_cod_child"


#'
#' Child-specific cause-of-death for ICD 11
#'
#' @format A data frame with 2 columns and 149 rows:
#'
#' | **Variable** | **Description** |
#' | :--- | :--- |
#' | *code* | ICD 11 Cause of Death code |
#' | *title* | Cause of death title |
#'
#'
#' @examples
#' icd11_cod_child
#'
#'
"icd11_cod_child"
