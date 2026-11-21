#' Add PAWMAP station information into a data frame.
#'
#' @param locations  A data frame with location metadata
#' @param ... a select expression like dplyr::select; which location attributes
#'   to keep
#' @param label an expression to create a location label; by default uses the
#'   catchment and numeric portion of the location_code
#' @param filterNA should stations w/o info be filtered? (A warning listing the
#'   unmatched stations is provided.)
#' @return The original data frame merged with station info fields.  The merge
#'   returns all rows of df even if there is no match, to indicate that there
#'   are stations in df not present in the station table.
#' @examples
#' library(tibble)
#' locations <- read_package_csv("locations.csv")
#' data <- tibble(location_code = "P0016", result = rnorm(1))
#' data |> add_location_info(locations)
#' @import archive
#' @export

add_location_info <- function(x, locations, ..., label, filterNA = TRUE) {
  if (missing(label)) {
    label <- rlang::expr(sprintf(
      "%s (%s)",
      catchment,
      substr(location_code, 2, 5)
    ))
    locations <- locations |>
      dplyr::mutate(location_label = !!label)
  } else {
    locations <- locations |>
      dplyr::mutate(location_label = {{ label }})
  }
  #fields = c('watershed', 'catchment', 'panel', 'flow_duration')
  locations <- locations |>
    # Metadata fields to include
    dplyr::select(location_code, location_label, ...)

  # remove stations w/o metadata if filterNA=T
  if (filterNA) {
    unmatched <- setdiff(x$location_code, locations$location_code)
    if (length(unmatched) > 0) {
      cli::cli_warn(
        c(
          "You have set {.code filterNA = TRUE}",
          "i" = "There are stations which do not have metadata.",
          "x" = "The following stations will be removed: {unmatched}"
        )
      )
    }
    dplyr::inner_join(x, locations, by = "location_code")
  } else {
    dplyr::left_join(x, locations, by = "location_code")
  }
}
