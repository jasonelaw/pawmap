package_path <- function() {
  package_dir <- fs::path_package("pawmap", "extdata")
  fs::dir_ls(package_dir, regexp = "pawmap_package_v.+.zip")
}

package_file <- function(file, package) {
  if (missing(package)) {
    package <- package_path()
  }
  is_dir <- fs::is_dir(package)
  is_zip <- fs::is_file(package) && identical(fs::path_ext(package), "zip")
  is_gpkg <- file == "layers.gpkg"
  if (is_dir) {
    fs::path(package, file)
  } else if (is_zip) {
    if (is_gpkg) {
      fs::path("/vsizip", package, file)
    } else {
      archive::archive_read(package, file = file)
    }
  }
}

#' @export
package_layers <- function(package) {
  if (missing(package)) {
    package <- package_path()
  }
  sf::st_layers(package_file("layers.gpkg", package))
}

#' @export
package_files <- function(package) {
  if (missing(package)) {
    package <- package_path()
  }
  archive(package)
}

#' @export
read_package_csv <- function(file, package) {
  stopifnot(identical(fs::path_ext(file), "csv"))
  file <- package_file(file, package)
  readr::read_csv(file)
}

#' @export
read_package_gpkg <- function(layer, package) {
  file <- package_file("layers.gpkg", package)
  sf::read_sf(file, layer)
}
