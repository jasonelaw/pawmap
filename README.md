
<!-- README.md is generated from README.Rmd. Please edit that file -->

# pawmap

<!-- badges: start -->

<!-- badges: end -->

The pawmap package contains utilities for interacting with data from the
City of Portland’s [Portland Area Watershed Monitoring and Assessment
Program](https://www.portland.gov/bes/protecting-rivers-streams/watershed-monitoring/portland-area-watershed-monitoring-and).
Data packages in the form of a zip file containing PAWMAP data will be
available from the
[pawmap-data](https://github.com/jasonelaw/pawmap-data) repository. An
example data package is included with the pawmap package.

## Installation

You can install the development version of pawmap from
[GitHub](https://github.com/) with:

``` r
# install.packages("pak")
pak::pak("jasonelaw/pawmap")
```

## Examples

You can list files in a data package:

``` r
library(pawmap)
package_files()
#> # A tibble: 9 × 3
#>   path                           size date               
#>   <chr>                         <int> <dttm>             
#> 1 avian_bii.csv                 35253 2026-11-10 17:22:10
#> 2 avian_distance.csv          3293044 2026-11-10 17:22:10
#> 3 avian_fixed.csv              521545 2026-11-10 17:22:08
#> 4 avian_traits.csv              77218 2026-11-10 17:22:10
#> 5 layers.gpkg                11333632 2026-11-10 17:22:05
#> 6 locations.csv                 44707 2026-11-10 17:22:06
#> 7 population_totals.csv          4896 2026-11-10 17:22:05
#> 8 water_quality.csv          12063682 2026-11-10 17:22:07
#> 9 water_quality_criteria.csv   815605 2026-11-10 17:22:08
```

Each data package contains an OGC GeoPackage file `layers.gpkg`. The
included layers can be listed:

``` r
package_layers()
#> Driver: GPKG 
#> Available layers:
#>      layer_name geometry_type features fields                        crs_name
#> 1     catchment Multi Polygon       51      4 NAD83(HARN) / Oregon North (ft)
#> 2    forestpark       Polygon        2      2 NAD83(HARN) / Oregon North (ft)
#> 3        strata Multi Polygon       23      4 NAD83(HARN) / Oregon North (ft)
#> 4     watershed Multi Polygon       20      3 NAD83(HARN) / Oregon North (ft)
#> 5        stream                   6576      4 NAD83(HARN) / Oregon North (ft)
#> 6 master_sample         Point     4687      9 NAD83(HARN) / Oregon North (ft)
```

Files can be read from the data package:

    #> Rows: 147 Columns: 17
    #> ── Column specification ────────────────────────────────────────────────────────
    #> Delimiter: ","
    #> chr (10): location_code, location_type_bes_name, location_name, manhole_hans...
    #> dbl  (6): x, y, distance_from_manhole_inches, pipe_hansen_compkey, panel, area
    #> lgl  (1): in_forest_park
    #> 
    #> ℹ Use `spec()` to retrieve the full column specification for this data.
    #> ℹ Specify the column types or set `show_col_types = FALSE` to quiet this message.

Much more functionality remains to be added. Stay tuned.
