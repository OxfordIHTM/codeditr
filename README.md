
<!-- README.md is generated from README.Rmd. Please edit that file -->

# codeditr: Implementing Cause-of-Death Data Checks Based on the WHO CoDEdit Tool <img src='man/figures/logo.png' width='200px' align='right' />

<!-- badges: start -->

[![Project Status: Active – The project has reached a stable, usable
state and is being actively
developed.](https://www.repostatus.org/badges/latest/active.svg)](https://www.repostatus.org/#active)
[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://lifecycle.r-lib.org/articles/stages.html#experimental)
[![codeditr status
badge](https://oxfordihtm.r-universe.dev/badges/codeditr)](https://oxfordihtm.r-universe.dev/codeditr)
[![R-CMD-check](https://github.com/OxfordIHTM/codeditr/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/OxfordIHTM/codeditr/actions/workflows/R-CMD-check.yaml)
[![test-coverage](https://github.com/OxfordIHTM/codeditr/actions/workflows/test-coverage.yaml/badge.svg)](https://github.com/OxfordIHTM/codeditr/actions/workflows/test-coverage.yaml)
[![Codecov test
coverage](https://codecov.io/gh/OxfordIHTM/codeditr/branch/main/graph/badge.svg)](https://app.codecov.io/gh/OxfordIHTM/codeditr?branch=main)
[![CodeFactor](https://www.codefactor.io/repository/github/OxfordIHTM/codeditr/badge)](https://www.codefactor.io/repository/github/OxfordIHTM/codeditr)
[![DOI](https://zenodo.org/badge/752255505.svg)](https://zenodo.org/badge/latestdoi/752255505)
<!-- badges: end -->

The [World Health Organization](https://www.who.int/)’s [CoDEdit
electronic
tool](https://www.who.int/standards/classifications/classification-of-diseases/services/codedit-tool)
is intended to help producers of cause-of-death statistics in
strengthening their capacity to perform routine checks on their data.
This package ports the original tool built using Microsoft Access into
R. The aim is to leverage the utility and function of the original tool
into a usable application program interface (API) that can be used for
building more universal tools or for creating programmatic scientific
workflows aimed at routine, automated, and large-scale monitoring of
cause-of-death data.

## What does `codeditr` do?

The `codeditr` package provides functions for implementing data quality
checks on cause-of-death records. It is built upon the same heuristics
and algorithms that the WHO CoDEdit v2.0 electronic tool uses to
evaluate quality of cause-of-death data produced and used by country
level statisticians in charge of mortality reporting.

Through this package, end users will have the ability to
programmatically create scientific workflows for routine monitoring and
evaluation and/or research on cause-of-death data and their quality.
They can also build more open tools or applications for routine
monitoring of cause-of-death data without having to rely on the
proprietary Microsoft Access software.

Currently, the `codeditr` package supports the following use cases:

1.  Cause-of-death dataset preparation for use in the CoDEdit tool

To be able to use WHO’s CoDEdit tool built on Microsoft Access, the user
can either enter their cause-of-death data into the tool itself using a
spreadsheet style input system with very specific input fields or
through uploading of a Microsoft `.xlsx` file that is structured in a
specific way required by the tool.

The `codeditr` package has a set of functions that support in checking
that specific required variables are formatted to be compatible for the
CoDEdit tool and structures these variables into a dataset that is
consistent with what is required for uploading to the CodEdit tool.

This use case are for those what would still prefer to use WHO’s CoDEdit
tool using Microsoft Access (either for continuity purposes or for
consistency with organisational policy) but would like to have the
functionality of converting their existing cause-of-death dataset into a
CoDEdit tool-compatible format and structure.

2.  Cause-of-death dataset checking to identify data quality issues

The `codeditr` package has a set of functions that performs all the
checks that the CoDEdit tool performs in addition to other general data
quality checks. These functions allow for a similar output as the
CoDEdit tool

This use case are for those that prefer not to use Microsoft Access
(either because they don’t already own a copy of this software or that
their purpose for data quality checks is for large-scale datasets) and
would like a completely programmatic approach to performing routine and
potentially large scale cause-of-death data quality checks.

## Installation

`codeditr` is not yet on CRAN but can be installed through the [Oxford
iHealth R Universe](https://oxfordihtm.r-universe.dev) with:

``` r
install.packages(
  "codeditr",
  repos = c("https://oxfordihtm.r-universe.dev", "https://cloud.r-project.org")
)
```

then load `codeditr`

``` r
# load package
library(codeditr)
```

## Usage

### Support to usage of CoDEdit tool

1.  Perform checks on existing input data for CoDEdit tool

Using the `icd10_example` dataset which is a dataset already formatted
into a compatible structure required by the CoDEdit tool, we can perform
a check on this dataset to see possible issues in its formatting and
structure before using with the CoDEdit tool.

``` r
cod_check_codedit_input(icd10_example)
#> # A tibble: 3,613 × 8
#>    sex_check sex_check_note           age_check age_check_note      code_check
#>        <int> <fct>                        <int> <fct>                    <int>
#>  1         0 No issues with sex value         0 No issues with age…          0
#>  2         0 No issues with sex value         0 No issues with age…          0
#>  3         0 No issues with sex value         0 No issues with age…          0
#>  4         0 No issues with sex value         0 No issues with age…          0
#>  5         0 No issues with sex value         0 No issues with age…          0
#>  6         0 No issues with sex value         0 No issues with age…          0
#>  7         0 No issues with sex value         0 No issues with age…          0
#>  8         0 No issues with sex value         0 No issues with age…          0
#>  9         0 No issues with sex value         0 No issues with age…          0
#> 10         0 No issues with sex value         0 No issues with age…          0
#> # ℹ 3,603 more rows
#> # ℹ 3 more variables: code_check_note <chr>, dod_check <int>,
#> #   dod_check_note <fct>
```

2.  Structure raw cause-of-death data for input into CoDEdit tool

Using the `cod_data_raw_example` dataset, we can format it into a
compatible structure required by the CoDEdit tool.

``` r
cod_structure_input(
  df = cod_data_raw_example, 
  sex = "sex", dob = "dob", dod = "dod", code = "code", id = "id"
)
#> # A tibble: 20 × 6
#>    FreeId   Sex `Age Value` `Age Type` Code          `Death Date`
#>     <int> <int>       <int> <chr>      <chr>         <chr>       
#>  1   4136     1        1318 Y          NE84&XA6KU8   2023        
#>  2   4137     2        1318 Y          2B6D&XS9R     2023        
#>  3   4138     1        1318 Y          2C82&XS9R     2023        
#>  4   4139     1        1318 Y          CA40.Z&XK9J   2023        
#>  5   4140     2        1318 Y          6C40.3&XS25   2023        
#>  6   4141     1        1318 Y          6C40.3&XS25   2023        
#>  7   4142     1        1318 Y          DB94.1&XT8W   2023        
#>  8   4143     2        1318 Y          BD40.Z        2023        
#>  9   4144     2        1318 Y          2C76.Z&XA8QA8 2023        
#> 10   4145     1        1318 Y          6C40.3&XS25   2023        
#> 11   4146     2        1318 Y          8B11.5Z       2023        
#> 12   4147     1        1318 Y          2B90.Y&XH74S1 2023        
#> 13   4148     1        1318 Y          BD10&XT5R     2023        
#> 14   4149     1        1318 Y          1G41          2023        
#> 15   4150     1        1318 Y          BD10&XT5R     2023        
#> 16   4151     2        1318 Y          CA40.Z&XB25   2023        
#> 17   4152     2        1318 Y          BA01          2023        
#> 18   4153     1        1318 Y          1G41          2023        
#> 19   4154     2        1318 Y          BB40          2023        
#> 20   4155     1        1318 Y          1B91          2023
```

The output is a data.frame that can then be saved as an `.xlsx` file for
use as input into the CoDEdit tool.

### CoDEdit tool replacement workflow

1.  Perform all checks on cause-of-death data

The `cod_check_code()` function performs all the checks implemented by
the CoDEdit tool.

``` r
cod_check_code(
  cod_data_raw_example$code, version = "icd11", 
  sex = cod_data_raw_example$sex, age = cod_data_raw_example$age
)
#> # A tibble: 20 × 12
#>    cod_check_structure cod_check_note_structure    cod_check_ill_defined
#>                  <int> <fct>                                       <int>
#>  1                   0 No issues found in CoD code                     0
#>  2                   0 No issues found in CoD code                     0
#>  3                   0 No issues found in CoD code                     0
#>  4                   0 No issues found in CoD code                     0
#>  5                   0 No issues found in CoD code                     0
#>  6                   0 No issues found in CoD code                     0
#>  7                   0 No issues found in CoD code                     0
#>  8                   0 No issues found in CoD code                     0
#>  9                   0 No issues found in CoD code                     0
#> 10                   0 No issues found in CoD code                     0
#> 11                   0 No issues found in CoD code                     0
#> 12                   0 No issues found in CoD code                     0
#> 13                   0 No issues found in CoD code                     0
#> 14                   0 No issues found in CoD code                     0
#> 15                   0 No issues found in CoD code                     0
#> 16                   0 No issues found in CoD code                     0
#> 17                   0 No issues found in CoD code                     0
#> 18                   0 No issues found in CoD code                     0
#> 19                   0 No issues found in CoD code                     0
#> 20                   0 No issues found in CoD code                     0
#> # ℹ 9 more variables: cod_check_note_ill_defined <fct>,
#> #   cod_check_unlikely <int>, cod_check_note_unlikely <fct>,
#> #   cod_check_sex <int>, cod_check_note_sex <fct>, cod_check_age <int>,
#> #   cod_check_note_age <fct>, cod_check_code <dbl>, cod_check_code_note <fct>
```

Results of the per row cause-of-death checks can also be summarised to
give a count of issues found in the dataset.

``` r
cod_check_code(
  cod_data_raw_example$code, version = "icd11", 
  sex = cod_data_raw_example$sex, age = cod_data_raw_example$age
) |>
  cod_check_code_summary()
#> $`Code structure`
#> # A tibble: 65 × 2
#>    cod_check_note                                                            n
#>    <fct>                                                                 <int>
#>  1 No issues found in CoD code                                              20
#>  2 CoD code has a period (`.`) character in the wrong place                  0
#>  3 CoD code starts with `O` or `I`                                           0
#>  4 CoD code has a period (`.`) character in the wrong place; CoD code s…     0
#>  5 CoD code has a number as its second value                                 0
#>  6 CoD code has a period (`.`) character in the wrong place; CoD code h…     0
#>  7 CoD code starts with `O` or `I`; CoD code has a number as its second…     0
#>  8 CoD code has a period (`.`) character in the wrong place; CoD code s…     0
#>  9 CoD code has `O` or `I` as its second value                               0
#> 10 CoD code has a period (`.`) character in the wrong place; CoD code h…     0
#> # ℹ 55 more rows
#> 
#> $`Ill-defined code`
#> # A tibble: 2 × 2
#>   cod_check_note                      n
#>   <fct>                           <int>
#> 1 No issues found in CoD code        20
#> 2 CoD code is an ill-defined code     0
#> 
#> $`Unlikely cause-of-death code`
#> # A tibble: 2 × 2
#>   cod_check_note                             n
#>   <fct>                                  <int>
#> 1 No issues found in CoD code               20
#> 2 CoD code is an unlikely cause-of-death     0
#> 
#> $`Code not appropriate for sex`
#> # A tibble: 2 × 2
#>   cod_check_note                                   n
#>   <fct>                                        <int>
#> 1 No issues found in CoD code                     20
#> 2 CoD code is not appropriate for person's sex     0
#> 
#> $`Code not appropriate for age`
#> # A tibble: 2 × 2
#>   cod_check_note                                   n
#>   <fct>                                        <int>
#> 1 No issues found in CoD code                     20
#> 2 CoD code is not appropriate for person's age     0
#> 
#> $Overall
#> # A tibble: 2 × 2
#>   cod_check_note                  n
#>   <fct>                       <int>
#> 1 No issues found in CoD code    20
#> 2 Issues found in CoD code        0
```

2.  Perform specific check types on cause-of-death data

The family of `cod_check_code_*` functions can be used to perform
specific check types on the cause-of-death data.

``` r
### Perform code structure check on cause-of-death data ----
cod_check_code_structure_icd10(icd10_example$Code)
#> # A tibble: 3,613 × 2
#>    cod_check cod_check_note             
#>        <int> <fct>                      
#>  1         0 No issues found in CoD code
#>  2         0 No issues found in CoD code
#>  3         0 No issues found in CoD code
#>  4         0 No issues found in CoD code
#>  5         0 No issues found in CoD code
#>  6         0 No issues found in CoD code
#>  7         0 No issues found in CoD code
#>  8         0 No issues found in CoD code
#>  9         0 No issues found in CoD code
#> 10         0 No issues found in CoD code
#> # ℹ 3,603 more rows

### Perform check for ill-defined codes on cause-of-death data ----
cod_check_code_ill_defined_icd11(cod_data_raw_example$code)
#> # A tibble: 20 × 2
#>    cod_check cod_check_note             
#>        <int> <fct>                      
#>  1         0 No issues found in CoD code
#>  2         0 No issues found in CoD code
#>  3         0 No issues found in CoD code
#>  4         0 No issues found in CoD code
#>  5         0 No issues found in CoD code
#>  6         0 No issues found in CoD code
#>  7         0 No issues found in CoD code
#>  8         0 No issues found in CoD code
#>  9         0 No issues found in CoD code
#> 10         0 No issues found in CoD code
#> 11         0 No issues found in CoD code
#> 12         0 No issues found in CoD code
#> 13         0 No issues found in CoD code
#> 14         0 No issues found in CoD code
#> 15         0 No issues found in CoD code
#> 16         0 No issues found in CoD code
#> 17         0 No issues found in CoD code
#> 18         0 No issues found in CoD code
#> 19         0 No issues found in CoD code
#> 20         0 No issues found in CoD code

### Perform check for unlikely cause-of-death codes ----
cod_check_code_unlikely_icd11(cod_data_raw_example$code)
#> # A tibble: 20 × 2
#>    cod_check cod_check_note             
#>        <int> <fct>                      
#>  1         0 No issues found in CoD code
#>  2         0 No issues found in CoD code
#>  3         0 No issues found in CoD code
#>  4         0 No issues found in CoD code
#>  5         0 No issues found in CoD code
#>  6         0 No issues found in CoD code
#>  7         0 No issues found in CoD code
#>  8         0 No issues found in CoD code
#>  9         0 No issues found in CoD code
#> 10         0 No issues found in CoD code
#> 11         0 No issues found in CoD code
#> 12         0 No issues found in CoD code
#> 13         0 No issues found in CoD code
#> 14         0 No issues found in CoD code
#> 15         0 No issues found in CoD code
#> 16         0 No issues found in CoD code
#> 17         0 No issues found in CoD code
#> 18         0 No issues found in CoD code
#> 19         0 No issues found in CoD code
#> 20         0 No issues found in CoD code

### Perform check for cause-of-death codes inappropriate for specific sex ----
cod_check_code_sex_icd11(cod_data_raw_example$code, cod_data_raw_example$sex)
#> # A tibble: 20 × 2
#>    cod_check cod_check_note             
#>        <int> <fct>                      
#>  1         0 No issues found in CoD code
#>  2         0 No issues found in CoD code
#>  3         0 No issues found in CoD code
#>  4         0 No issues found in CoD code
#>  5         0 No issues found in CoD code
#>  6         0 No issues found in CoD code
#>  7         0 No issues found in CoD code
#>  8         0 No issues found in CoD code
#>  9         0 No issues found in CoD code
#> 10         0 No issues found in CoD code
#> 11         0 No issues found in CoD code
#> 12         0 No issues found in CoD code
#> 13         0 No issues found in CoD code
#> 14         0 No issues found in CoD code
#> 15         0 No issues found in CoD code
#> 16         0 No issues found in CoD code
#> 17         0 No issues found in CoD code
#> 18         0 No issues found in CoD code
#> 19         0 No issues found in CoD code
#> 20         0 No issues found in CoD code

### Perform check for cause-of-death codes inappropriate for specific age ----
cod_check_code_age_icd11(cod_data_raw_example$code, cod_data_raw_example$age)
#> # A tibble: 20 × 2
#>    cod_check cod_check_note             
#>        <int> <fct>                      
#>  1         0 No issues found in CoD code
#>  2         0 No issues found in CoD code
#>  3         0 No issues found in CoD code
#>  4         0 No issues found in CoD code
#>  5         0 No issues found in CoD code
#>  6         0 No issues found in CoD code
#>  7         0 No issues found in CoD code
#>  8         0 No issues found in CoD code
#>  9         0 No issues found in CoD code
#> 10         0 No issues found in CoD code
#> 11         0 No issues found in CoD code
#> 12         0 No issues found in CoD code
#> 13         0 No issues found in CoD code
#> 14         0 No issues found in CoD code
#> 15         0 No issues found in CoD code
#> 16         0 No issues found in CoD code
#> 17         0 No issues found in CoD code
#> 18         0 No issues found in CoD code
#> 19         0 No issues found in CoD code
#> 20         0 No issues found in CoD code
```

## Citation

If you find the `codeditr` package useful please cite using the
suggested citation provided by a call to the `citation()` function as
follows:

``` r
citation("codeditr")
#> To cite codeditr in publications use:
#> 
#>   Anita Makori, Ernest Guevarra (2024). _codeditr: Implementing
#>   Cause-of-Death Data Checks Based on World Health Organization's
#>   CoDEdit Tool_. R package version 0.0.9000,
#>   <https://oxford-ihtm.io/codeditr/>.
#> 
#> A BibTeX entry for LaTeX users is
#> 
#>   @Manual{,
#>     title = {codeditr: Implementing Cause-of-Death Data Checks Based on World Health Organization's CoDEdit Tool},
#>     author = {{Anita Makori} and {Ernest Guevarra}},
#>     year = {2024},
#>     note = {R package version 0.0.9000},
#>     url = {https://oxford-ihtm.io/codeditr/},
#>   }
```

## Community guidelines

Feedback, bug reports and feature requests are welcome; file issues or
seek support [here](https://github.com/OxfordIHTM/codeditr/issues). If
you would like to contribute to the package, please see our
[contributing
guidelines](https://oxford-ihtm.io/codeditr/CONTRIBUTING.html).

This project is released with a [Contributor Code of
Conduct](https://OxfordIHTM/codeditr/CODE_OF_CONDUCT.html). By
participating in this project you agree to abide by its terms.
