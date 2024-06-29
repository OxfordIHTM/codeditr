
<!-- README.md is generated from README.Rmd. Please edit that file -->

# codeditr: Implementing Cause-of-Death Data Checks Based on the WHO CoDEdit Tool <img src='man/figures/logo.png' width='200px' align='right' />

<!-- badges: start -->

[![Project Status: Active – The project has reached a stable, usable
state and is being actively
developed.](https://www.repostatus.org/badges/latest/active.svg)](https://www.repostatus.org/#active)
[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://lifecycle.r-lib.org/articles/stages.html#experimental)
[![R-CMD-check](https://github.com/OxfordIHTM/codeditr/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/OxfordIHTM/codeditr/actions/workflows/R-CMD-check.yaml)
[![test-coverage](https://github.com/OxfordIHTM/codeditr/actions/workflows/test-coverage.yaml/badge.svg)](https://github.com/OxfordIHTM/codeditr/actions/workflows/test-coverage.yaml)
[![Codecov test
coverage](https://codecov.io/gh/OxfordIHTM/codeditr/branch/main/graph/badge.svg)](https://app.codecov.io/gh/OxfordIHTM/codeditr?branch=main)
[![CodeFactor](https://www.codefactor.io/repository/github/OxfordIHTM/codeditr/badge)](https://www.codefactor.io/repository/github/OxfordIHTM/codeditr)
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

`coeditr` is not yet on CRAN but can be installed through the [Oxford
IHTM R-universe](https://oxfordihtm.r-universe.dev) with:

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
#>    sex_check sex_check_note  age_check age_check_note code_check code_check_note
#>        <int> <chr>               <int> <fct>               <int> <chr>          
#>  1         0 No issues with…         0 No issues wit…          0 Cause of death…
#>  2         0 No issues with…         0 No issues wit…          0 Cause of death…
#>  3         0 No issues with…         0 No issues wit…          0 Cause of death…
#>  4         0 No issues with…         0 No issues wit…          0 Cause of death…
#>  5         0 No issues with…         0 No issues wit…          0 Cause of death…
#>  6         0 No issues with…         0 No issues wit…          0 Cause of death…
#>  7         0 No issues with…         0 No issues wit…          0 Cause of death…
#>  8         0 No issues with…         0 No issues wit…          0 Cause of death…
#>  9         0 No issues with…         0 No issues wit…          0 Cause of death…
#> 10         0 No issues with…         0 No issues wit…          0 Cause of death…
#> # ℹ 3,603 more rows
#> # ℹ 2 more variables: dod_check <int>, dod_check_note <chr>
```

### CoDEdit tool replacement workflow

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
