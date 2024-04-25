% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/data.R
\docType{data}
\name{icd11_example}
\alias{icd11_example}
\title{Example death records dataset with ICD11 cause-of-death coding}
\format{
A data frame with 6 columns and 244 rows:

| **Variable** | **Description** |
| :--- | :--- |
| *FreeId* | Record identifier |
| *Sex* | Sex: 1 = Male; 2 = Female; 9 = unknown |
| *Age Value* | Integer value for age |
| *Age Type* | Is the age value in days (D), months (M), or years (Y) |
| *Code* | ICD11 code for cause-of-death |
| *Death Date* | Date of death in year format |
}
\source{
https://www.who.int/standards/classifications/classification-of-diseases/services/codedit-tool
}
\usage{
icd11_example
}
\description{
Example death records dataset with ICD11 cause-of-death coding
}
\examples{
icd11_example

}
\keyword{datasets}