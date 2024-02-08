
<!-- README.md is generated from README.Rmd. Please edit that file -->

# codeditr: Implementing Basic Checks on Cause-of-Death Data Based on World Health Organization’s CoDEdit Tool

<!-- badges: start -->

[![Project Status: WIP – Initial development is in progress, but there
has not yet been a stable, usable release suitable for the
public.](https://www.repostatus.org/badges/latest/wip.svg)](https://www.repostatus.org/#wip)
[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://lifecycle.r-lib.org/articles/stages.html#experimental)
[![R-CMD-check](https://github.com/OxfordIHTM/codeditr/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/OxfordIHTM/codeditr/actions/workflows/R-CMD-check.yaml)
[![Codecov test
coverage](https://codecov.io/gh/OxfordIHTM/codeditr/branch/main/graph/badge.svg)](https://app.codecov.io/gh/OxfordIHTM/codeditr?branch=main)
<!-- badges: end -->

The [World Health Organization](https://www.who.int/)’s [CoDEdit
electronic
tool](https://www.who.int/standards/classifications/classification-of-diseases/services/codedit-tool)
is intended to help producers of cause-of-death statistics in
strengthening their capacity to perform routine checks on their data.
This package ports the original tool built using Microsoft Acess into R
so as to leverage the utility and function of the original tool into a
usable application program interface that can be used for building more
universal tools or for creating programmatic scientific workflows aimed
at routine, automated, and large-scale monitoring of cause-of-death
data.

## What does `codeditr` do?

The `codeditr` package provides functions for implementing data quality
checks on cause-of-death records. It is built upon the same heuristics
and algorithms that the WHO CodEdit v2.0 electronic tool uses to
evaluate quality of cause-of-death data produced and used by country
level statisticians in charge of mortality reporting.

Through this package, end users will have the ability to
programmatically create scientific workflows for research on
cause-of-death data and their quality or build more open tools or
applications for routine monitoring of cause-of-death data.

## Installation

`coeditr` is not yet on CRAN.

You can install the development version of `codeditr` from
[GitHub](https://github.com/OxfordIHTM/codeditr) with:

``` r
if(!require(remotes)) install.packages("remotes")
remotes::install_github("OxfordIHTM/codeditr")
```

then load `codeditr`

``` r
# load package
library(codeditr)
```

## Usage

## Citation

If you find the `codeitr` package useful please cite using the suggested
citation provided by a call to the `citation()` function as follows:

``` r
citation("codeditr")
#> To cite zscorer in publications use:
#> 
#>   Anita Makori and Ernest Guevarra (2024). codeditr: Implementing Basic
#>   Checks on Cause-of-Death Data Based on World Health Organization's
#>   CoDEdit Tool. R package version 0.0.9000. URL
#>   https://oxford-ihtm.io/codeditr/
#> 
#> A BibTeX entry for LaTeX users is
#> 
#>   @Manual{,
#>     title = {codeditr: Implementing Basic Checks on Cause-of-Death Data Based on World Health Organization's CoDEdit Tool},
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
