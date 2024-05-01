#'
#' Implementing Cause-of-Death Data Checks Based on the WHO CoDEdit Tool
#'
#' The World Health Organization's CoDEdit electronic tool is intended to help
#' producers of cause-of-death statistics in strengthening their capacity to
#' perform routine checks on their data. This package ports the original tool
#' built using Microsoft Access into R so as to leverage the utility and
#' function of the original tool into a usable application program interface
#' that can be used for building more universal tools or for creating
#' programmatic scientific workflows aimed at routine, automated, and
#' large-scale monitoring of cause-of-death data quality.
#'
#' @docType package
#' @keywords internal
#' @name codeditr
#' @importFrom methods is
#' @importFrom tibble tibble
#' @importFrom dplyr mutate select case_when bind_rows
#' @importFrom rlang .data
#'
"_PACKAGE"
