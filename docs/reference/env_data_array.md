# Get an array of environmental data from presence-absence points.

Get an array of environmental data from presence-absence points.

## Usage

``` r
env_data_array(env_data, occ = NULL)
```

## Arguments

- env_data:

  List of environmental variables time series stacks (each a SpatRaster
  with multiple layers).

- occ:

  Occurrence data frame. Should contain columns "name", "lon", "lat",
  "presence". If NULL, returns data for all raster cells.

## Value

A 3D array of dimensions M (points or cells) × N (time steps) × P
(environmental variables). The first dimension has no dimnames; the
second is named "time" with layer names from the first raster; the third
is named "var" with the names of \`env_data\`.

## Examples

``` r
bio1_ts <- terra::unwrap(example_1$bio01)
bio12_ts <- terra::unwrap(example_1$bio12)
env_data <- list(bio1 = bio1_ts, bio12 = bio12_ts)
occ <- example_1$occ_df[1:5, ]
# Return array correspoding to each presence absence provided
env_data_array(env_data, occ)
#> Error in env_data_array(env_data, occ): Assertion on 'names(occ)' failed: Names must include the elements {'lon','lat','presence'}, but is missing elements {'lon','lat'}.
# Return all the environmental in the rasters
env_data_array(env_data, occ)
#> Error in env_data_array(env_data, occ): Assertion on 'names(occ)' failed: Names must include the elements {'lon','lat','presence'}, but is missing elements {'lon','lat'}.
```
