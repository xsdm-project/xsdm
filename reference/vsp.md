# Generate a virtual species probability map

Creates a virtual species probability-of-detection map based on
environmental time-series data and a set of species-specific parameters.

## Usage

``` r
vsp(env_data, param_list, return_raster = FALSE)
```

## Arguments

- env_data:

  A named list of time-series raster objects (e.g., bioclimatic
  variables). Each element should be a \`SpatRaster\` or similar object
  from the \`terra\` package.

- param_list:

  A named list of parameters required by \`log_prob_detect()\`. Must
  include \`mu\`, \`sigltil\`, \`sigrtil\`, \`ctil\`, \`pd\`, and
  \`o_mat\`. This parameters are in biological scale. So for parameters
  like \`sigltil\`, \`sigrtil\` The values could be \`Inf\`

- return_raster:

  Logical.If \`FALSE\`, returns a tibble with columns \`x\`, \`y\`, and
  \`probs\`. (Default) If \`TRUE\`, returns a \`SpatRaster\` object with
  probabilities.

## Value

Either: \* A tibble with coordinates and probability values by default
(if \`return_raster = FALSE\`) or \* A \`SpatRaster\` object (if
\`return_raster = TRUE\`) Both with values corresponding to the
probability of detection for the virtual species. Values range from 0 to
1

## Details

Internally, the function:

1.  Converts the list of rasters into an array using
    \`env_data_array()\`.

2.  Applies \`log_prob_detect()\` with the provided parameters.

3.  Exponentiates the log-probabilities to obtain detection
    probabilities.

## See also

\[env_data_array()\], \[log_prob_detect()\], \[terra::rast()\]

## Examples

``` r
# \donttest{
# Load the consolidated example data (provided by the package)
data("example_1", package = "xsdm")

# Unpack the raster time series (they are stored as packed SpatRasters)
bio1_ts  <- terra::unwrap(example_1$bio01)
bio12_ts <- terra::unwrap(example_1$bio12)

# Scale to match typical units (CHELSA data are often in 0.1 units)
bio1_ts  <- bio1_ts / 100
bio12_ts <- bio12_ts / 100

# Build the list of environmental rasters
env_data <- list(bio1 = bio1_ts, bio12 = bio12_ts)

# Return a tibble (the default)
prob_tbl <- vsp(env_data, example_1$par_list)
#> Error in vsp(env_data, example_1$par_list): Assertion on 'env_data' failed: May only contain the following types: {SpatRaster}, but element 1 has type 'numeric'.
head(prob_tbl)
#> Error: object 'prob_tbl' not found

# Return a SpatRaster
prob_rast <- vsp(env_data, example_1$par_list, return_raster = TRUE)
#> Error in vsp(env_data, example_1$par_list, return_raster = TRUE): unused argument (return_raster = TRUE)
# Quick plot (commented to avoid plotting in examples)
# plot(prob_rast)
# }
```
