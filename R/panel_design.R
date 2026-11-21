#' Create table of PAWMAP's panel design in time
#'
#' Creates a table of PAWMAP sampling calendar, panel labels, and cycles. The
#' table is current through the current date and time. The final entry will be
#' the current year or quarter. The `by` argument controls whether the table
#' contains annual or quarterly entries.
#'
#' @param by whether the table should return the annual panel design or whether
#'  the table should contain entries for each quarter.
#' @return A table of PAWMAP sampling years, panels and cycles
#' @export

panel_design <- function(by = c("year", "quarter")) {
  by <- match.arg(by)
  today <- clock::date_now(zone = Sys.timezone())
  today <- clock::as_year_quarter_day(today, start = 7)
  today <- clock::calendar_narrow(today, precision = "quarter")
  start <- clock::year_quarter_day(2011, 1, start = 7)
  calendar <- seq(start, today, by = 1L)
  panel_years <- tibble::tibble(
    calendar = calendar
  )
  panel_years <- panel_years |>
    dplyr::mutate(
      start_day = clock::calendar_widen(calendar, "day"),
      start = clock::calendar_start(start_day, "quarter"),
      start = clock::as_year_month_day(start),
      end = clock::calendar_end(start_day, precision = "quarter"),
      end = clock::as_year_month_day(end),
      panel = rep(1:4, each = 4, length.out = dplyr::n()),
      cycle = rep(
        1:ceiling(dplyr::n() / 4),
        each = 16,
        length.out = dplyr::n()
      ),
      fiscal_year = get_year(calendar),
      fiscal_year = paste0(fiscal_year - 1, "-", fiscal_year)
    ) |>
    dplyr::select(-start_day)
  if (by == "year") {
    panel_years <- panel_years |>
      dplyr::mutate(
        calendar = clock::calendar_group(calendar, "year")
      ) |>
      dplyr::mutate(
        start = min(start),
        end = max(end),
        .by = calendar
      ) |>
      dplyr::distinct(calendar, start, end, panel, cycle, fiscal_year)
  }
  panel_years
}
