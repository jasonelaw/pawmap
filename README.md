
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

``` r
locations <- read_package_csv("locations.csv")
locations
#> # A tibble: 147 × 17
#>    location_code location_type_bes_name location_name                   x      y
#>    <chr>         <chr>                  <chr>                       <dbl>  <dbl>
#>  1 P0124         Surface Water          Johnson Creek off SE Barb… 7.69e6 6.66e5
#>  2 P0188         Surface Water          Johnson Creek downstream … 7.68e6 6.66e5
#>  3 P0016         Surface Water          Kelley Creek near SE Fost… 7.69e6 6.62e5
#>  4 P0144         Surface Water          Nettle Creek East from An… 7.64e6 6.50e5
#>  5 P0017         Surface Water          Elrod Slough downstream o… 7.65e6 7.08e5
#>  6 P0208         Surface Water          Tryon Creek off North Cre… 7.64e6 6.56e5
#>  7 P0129         Surface Water          Upper Columbia Slough Bet… 7.69e6 6.96e5
#>  8 P0080         Surface Water          Upper Columbia Slough dow… 7.70e6 6.93e5
#>  9 P0060         Surface Water          Veteran's Creek at SE 101… 7.67e6 6.62e5
#> 10 P0058         Surface Water          Woods Creek downstream of… 7.63e6 6.62e5
#> # ℹ 137 more rows
#> # ℹ 12 more variables: manhole_hansen_id <chr>,
#> #   distance_from_manhole_inches <dbl>, pipe_hansen_compkey <dbl>,
#> #   location_description <chr>, panel <dbl>, flow_duration <chr>,
#> #   watershed <chr>, subwatershed <chr>, in_forest_park <lgl>, area <dbl>,
#> #   catchment <chr>, geometry <chr>

catchment <- read_package_gpkg("catchment")
catchment
#> Simple feature collection with 51 features and 4 fields
#> Geometry type: MULTIPOLYGON
#> Dimension:     XY
#> Bounding box:  xmin: 7603000 ymin: 646441.5 xmax: 7744346 ymax: 731218.2
#> Projected CRS: NAD83(HARN) / Oregon North (ft)
#> # A tibble: 51 × 5
#>    watershed       subwatershed       catchment   area                      geom
#>    <chr>           <chr>              <chr>      <dbl>     <MULTIPOLYGON [foot]>
#>  1 Columbia River  Columbia River     Columbia…  1.47  (((7659862 711931, 76598…
#>  2 Columbia Slough Lower Slough       Lower Sl… 25.7   (((7644298 697756.5, 764…
#>  3 Columbia Slough Lower Slough       Pen 1      3.47  (((7643128 714995.5, 764…
#>  4 Columbia Slough Lower Slough       Pen 2      6.02  (((7643447 714777.1, 764…
#>  5 Columbia Slough Lower and Middle … Lower an… 34.0   (((7672933 691703.5, 767…
#>  6 Columbia Slough Middle Slough      Middle S… 27.5   (((7672498 681386.5, 767…
#>  7 Columbia Slough Middle Slough      Whitaker   5.74  (((7674785 692696.5, 767…
#>  8 Columbia Slough Upper Slough       Upper Sl… 35.3   (((7686553 694079.5, 768…
#>  9 Columbia Slough Upper Slough       Wilkes     0.486 (((7687168 693907.5, 768…
#> 10 Fanno Creek     Fanno Creek        Fanno Cr…  9.36  (((7636904 667285.5, 763…
#> # ℹ 41 more rows
```

Much more functionality remains to be added. Stay tuned.
