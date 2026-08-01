pkgname <- "xsdm"
source(file.path(R.home("share"), "R", "examples-header.R"))
options(warn = 1)
library('xsdm')

base::assign(".oldSearch", base::search(), pos = 'CheckExEnv')
base::assign(".old_wd", base::getwd(), pos = 'CheckExEnv')
cleanEx()
nameEx("bio_to_math")
### * bio_to_math

flush(stderr()); flush(stdout())

### Name: bio_to_math
### Title: Converts parameters from the biological scale to the math
###   (unconstrained) scale
### Aliases: bio_to_math

### ** Examples

## --- p = 1 (no o_par entries) ---
mu1 <- 10
sigltil1 <- 1.2
sigrtil1 <- 0.8
bio_parameters <- list(
  mu      = c(mu1),
  sigltil = c(sigltil1),
  sigrtil = c(sigrtil1),
  ctil    = 0.3,
  pd      = 0.85,
  o_mat   = matrix(1, 1, 1) # 1x1 orthogonal
)
math1 <- bio_to_math(bio_parameters)
# Canonical names
names(math1)
# Back to biological scale
math_parameters <- math_to_bio(math1)
all.equal(math_parameters$mu, bio_parameters$mu)
all.equal(math_parameters$sigltil, bio_parameters$sigltil)
all.equal(math_parameters$sigrtil, bio_parameters$sigrtil)
all.equal(math_parameters$ctil, bio_parameters$ctil)
all.equal(math_parameters$pd, bio_parameters$pd)

## --- p = 2 (includes one o_par) ---
mu2 <- c(11, 5)
sigltil2 <- c(1.1, 1.5)
sigrtil2 <- c(1.4, 1.3)
ctil2 <- -0.2
pd2 <- 0.9
o_par2 <- 0.25
O2 <- build_orthogonal_matrix(o_par2)
bio_parameters_2d <- list(
  mu      = mu2,
  sigltil = sigltil2,
  sigrtil = sigrtil2,
  ctil    = ctil2,
  pd      = pd2,
  o_mat   = O2
)
math_parameters_2d <- bio_to_math(bio_parameters_2d)
# check canonical name order produced by make_mask_names(2)
identical(names(math_parameters_2d), names(make_mask_names(2)))



cleanEx()
nameEx("build_orthogonal_matrix")
### * build_orthogonal_matrix

flush(stderr()); flush(stdout())

### Name: build_orthogonal_matrix
### Title: Build an orthogonal matrix from a real-parameter vector
### Aliases: build_orthogonal_matrix

### ** Examples

# 1x1 identity (NULL input)
build_orthogonal_matrix(NULL)

# 2x2 orthogonal matrix from one parameter
O2 <- build_orthogonal_matrix(0.0)
all.equal(t(O2) %*% O2, diag(2)) # should be TRUE

# 3x3 example: length(entries) = 3 (= 3*2/2), so k = 3
O3 <- build_orthogonal_matrix(c(0.1, -0.2, 0.3))
all.equal(t(O3) %*% O3, diag(3), tolerance = 1e-10)




cleanEx()
nameEx("convert_equivalence_class")
### * convert_equivalence_class

flush(stderr()); flush(stdout())

### Name: convert_equivalence_class
### Title: Converts a set of parameters to other representatives of the
###   same equivalence class
### Aliases: convert_equivalence_class

### ** Examples

convert_equivalence_class(
  p = example_1$optim_par_list,
  flip = c(1, 0),
  perm = c(1, 2)
)



cleanEx()
nameEx("create_mask")
### * create_mask

flush(stderr()); flush(stdout())

### Name: create_mask
### Title: Create a parameter mask aligned with 'make_mask_names()'
### Aliases: create_mask

### ** Examples

# Empty mask for p = 2 (all NA values)
create_mask(p = 2)

# Partially filled mask; unspecified entries remain NA
create_mask(mask = c(mu1 = 11, sigltil1 = Inf, pd = 1, ctil = -2), p = 2)

# p = 1 has no o_par entries
create_mask(mask = c(mu1 = 7, pd = 0.5), p = 1)




cleanEx()
nameEx("create_param_vector_masked")
### * create_param_vector_masked

flush(stderr()); flush(stdout())

### Name: create_param_vector_masked
### Title: Create a complete parameter vector with canonical names (no NAs
###   allowed)
### Aliases: create_param_vector_masked

### ** Examples

## --- p = 1 ---
p1 <- 1
# Canonical names typically: mu1, sigltil1, sigrtil1, ctil, pd
pv1 <- c(sigltil1 = 1.0, sigrtil1 = 2.0, ctil = 0.2) # fills remaining slots
mask1 <- c(mu1 = -1, pd = 0.5)
out1 <- create_param_vector_masked(param_vector = pv1, mask = mask1, p = p1)

## --- p = 2 (includes o_par1) ---
p2 <- 2
pv2 <- c(
  sigltil1 = 1.0, sigltil2 = 1.1, sigrtil1 = 2.0, sigrtil2 = 2.2,
  ctil = 0.3, o_par1 = 0.0
)
mask2 <- c(mu1 = 0.1, mu2 = 0.2, pd = 0.05)
out2 <- create_param_vector_masked(param_vector = pv2, mask = mask2, p = p2)

## --- p = 3 (includes o_par1..3) ---
p3 <- 3
pv3 <- c(
  sigltil1 = 1.0, sigltil2 = 1.1, sigltil3 = 1.2,
  sigrtil1 = 2.0, sigrtil2 = 2.1, sigrtil3 = 2.2,
  ctil = 0.4, o_par1 = -0.2, o_par2 = 0.0, o_par3 = 0.15
)
mask3 <- c(mu1 = 0.1, mu2 = 0.2, mu3 = 0.3, pd = 0.01)
out3 <- create_param_vector_masked(param_vector = pv3, mask = mask3, p = p3)



cleanEx()
nameEx("dist_between_params")
### * dist_between_params

flush(stderr()); flush(stdout())

### Name: dist_between_params
### Title: Distance in parameter space between two sets of parameters
### Aliases: dist_between_params

### ** Examples

# Using lists on the biological scale
par_list <- math_to_bio(example_1$optim_par_vec)
par_list_equivalent <- math_to_bio(example_1$optim_par_vec_equivalent)
dist_between_params(
  p1 = par_list,
  p2 = par_list_equivalent
)

# Using vectors on the math scale
dist_between_params(
  p1 = example_1$optim_par_vec,
  p2 = example_1$optim_par_vec_equivalent
)



cleanEx()
nameEx("env_data_array")
### * env_data_array

flush(stderr()); flush(stdout())

### Name: env_data_array
### Title: Get an array of environmental data from presence-absence points.
### Aliases: env_data_array

### ** Examples

bio1_ts <- terra::unwrap(example_1$bio01)
bio12_ts <- terra::unwrap(example_1$bio12)
env_data <- list(bio1 = bio1_ts, bio12 = bio12_ts)
occ <- example_1$occ_df[1:5, ]
# Return array correspoding to each presence absence provided
env_data_array(env_data, occ)
# Return all the environmental in the rasters
env_data_array(env_data, occ)



cleanEx()
nameEx("example_1")
### * example_1

flush(stderr()); flush(stdout())

### Name: example_1
### Title: Consolidated example data for the xsdm package
### Aliases: example_1
### Keywords: datasets

### ** Examples

# Access the list
names(example_1)

# Unpack a raster

# Use a parameter set
math_to_bio(example_1$par_vec)




cleanEx()
nameEx("example_2")
### * example_2

flush(stderr()); flush(stdout())

### Name: example_2
### Title: Consolidated example data for the xsdm. This is environmental
###   data array and an occurrence presence absence vector of Ophisaurus
###   ventralis. A named list containing all example datasets used in the
###   package's documentation and examples.
### Aliases: example_2
### Keywords: datasets

### ** Examples

# Access the list
names(example_2)




cleanEx()
nameEx("example_3")
### * example_3

flush(stderr()); flush(stdout())

### Name: example_3
### Title: Consolidated example data for the xsdm. This is environmental
###   data array and an occurrence presence absence vector Blarina
###   carolinensis A named list containing all example datasets used in the
###   package's documentation and examples.
### Aliases: example_3
### Keywords: datasets

### ** Examples

# Access the list
names(example_3)




cleanEx()
nameEx("expit")
### * expit

flush(stderr()); flush(stdout())

### Name: expit
### Title: Functions to take the expit of numerical vectors. expit
###   exp(x)/(1 + exp(x))
### Aliases: expit

### ** Examples

expit(0)
expit(0.5)
expit(-1)



cleanEx()
nameEx("extract_orthogonal_matrix_parameters")
### * extract_orthogonal_matrix_parameters

flush(stderr()); flush(stdout())

### Name: extract_orthogonal_matrix_parameters
### Title: Extract a math-scale real-parameter vector corresponding to a
###   special orthogonal matrix
### Aliases: extract_orthogonal_matrix_parameters

### ** Examples

o_par2 <- 0.25
O2 <- build_orthogonal_matrix(o_par2)
extract_orthogonal_matrix_parameters(O2)



cleanEx()
nameEx("get_range_df_")
### * get_range_df_

flush(stderr()); flush(stdout())

### Name: get_range_df_
### Title: Helper. Reasonable ranges for initial conditions for
###   optimizations seeking to maximize the likelihood of the xsdm model
### Aliases: get_range_df_
### Keywords: internal

### ** Examples

set.seed(1)
env <- array(rnorm(10 * 5 * 2), dim = c(10, 5, 2))
xsdm:::get_range_df_(env)                 # default breadth = 1
xsdm:::get_range_df_(env, breadth = 0.3) 



cleanEx()
nameEx("habitat_suitability")
### * habitat_suitability

flush(stderr()); flush(stdout())

### Name: habitat_suitability
### Title: Tiled habitat-suitability map from environmental raster stacks
### Aliases: habitat_suitability

### ** Examples




cleanEx()
nameEx("interpret_parameters")
### * interpret_parameters

flush(stderr()); flush(stdout())

### Name: interpret_parameters
### Title: Tool to help interpret xsdm model parameters
### Aliases: interpret_parameters

### ** Examples




cleanEx()
nameEx("like_ltsg")
### * like_ltsg

flush(stderr()); flush(stdout())

### Name: like_ltsg
### Title: Compute likelihood for LTSG model
### Aliases: like_ltsg

### ** Examples

mu <- c(1, 2)
ortho_m <- matrix(1:4, nrow = 2)
env_m <- matrix(1:4, nrow = 2)
dl_mat <- diag(2)
drl_mat <- diag(2)
like_ltsg(mu, env_m, dl_mat, drl_mat, ortho_m, q = 1, r = 2)




cleanEx()
nameEx("like_neg_ltsgr")
### * like_neg_ltsgr

flush(stderr()); flush(stdout())

### Name: like_neg_ltsgr
### Title: Long-term stochastic growth rate worker function for the xsdm
###   model
### Aliases: like_neg_ltsgr

### ** Examples

# Example usage:
like_neg_ltsgr(env_dat = example_1$env_array,
               mu      = example_1$true_par_list$mu,
               sigltil = example_1$true_par_list$sigltil,
               sigrtil = example_1$true_par_list$sigrtil,
               o_mat   = example_1$true_par_list$o_mat)



cleanEx()
nameEx("log1mexp")
### * log1mexp

flush(stderr()); flush(stdout())

### Name: log1mexp
### Title: Numerically stable 'log(1 - exp(-a))'
### Aliases: log1mexp

### ** Examples

a <- 2^seq(-20, 5, length.out = 10)
cbind(a, log(1 - exp(-a)), log1mexp(a))



cleanEx()
nameEx("log1pexp")
### * log1pexp

flush(stderr()); flush(stdout())

### Name: log1pexp
### Title: Numerically stable 'log(1 + exp(x))'
### Aliases: log1pexp

### ** Examples

x <- seq(-40, 40, by = 10)
cbind(x, log1p(exp(x)), log1pexp(x))



cleanEx()
nameEx("log_prob_detect")
### * log_prob_detect

flush(stderr()); flush(stdout())

### Name: log_prob_detect
### Title: Probability of detection of the species in each location
### Aliases: log_prob_detect

### ** Examples

mu <- c(-1, 5.046939)
sigltil <- c(1.036834, 1.556083)
sigrtil <- c(1.538972, 1.458738)
ctil <- -2
pd <- 0.9
o_mat <- matrix(c(-0.4443546, 0.8958510, -0.8958510, -0.4443546), ncol = 2)



cleanEx()
nameEx("loglik_bio")
### * loglik_bio

flush(stderr()); flush(stdout())

### Name: loglik_bio
### Title: Log-likelihood function for the xsdm model, parameters on the
###   biological scale.
### Aliases: loglik_bio

### ** Examples

ll <- loglik_bio(
  env_dat = example_1$env_array,
  occ = example_1$occ_vec,
  mu = example_1$true_par_list$mu,
  sigltil = example_1$true_par_list$sigltil,
  sigrtil = example_1$true_par_list$sigrtil,
  o_mat = example_1$true_par_list$o_mat,
  ctil = example_1$true_par_list$ctil,
  pd = example_1$true_par_list$pd
)
ll



cleanEx()
nameEx("loglik_math")
### * loglik_math

flush(stderr()); flush(stdout())

### Name: loglik_math
### Title: Log-likelihood function for the xsdm model, parameters on the
###   math scale.
### Aliases: loglik_math

### ** Examples

# Testing the function with the example data
loglik_math(
  param_vector = example_1$par_vec,
  env_dat = example_1$env_array,
  occ = example_1$occ_vec
)
# Mute one parameter to use the mask
par_vec <- example_1$par_vec[-2]
mask_parameters_a <- c(mu2 = 6.5)
loglik_math(
  param_vector = par_vec,
  env_dat = example_1$env_array,
  occ = example_1$occ_vec,
  mask = mask_parameters_a
)
# Return the negative
loglik_math(
  param_vector = example_1$par_vec,
  env_dat = example_1$env_array,
  occ = example_1$occ_vec,
  negative = TRUE
)



cleanEx()
nameEx("make_mask_names")
### * make_mask_names

flush(stderr()); flush(stdout())

### Name: make_mask_names
### Title: Function to facilitate the creation of the argument 'mask' to
###   the function 'loglik_math'
### Aliases: make_mask_names

### ** Examples

make_mask_names(2)



cleanEx()
nameEx("math_to_bio")
### * math_to_bio

flush(stderr()); flush(stdout())

### Name: math_to_bio
### Title: Convert parameters from the math scale to the biological scale
### Aliases: math_to_bio

### ** Examples

# Create your own vector of parameter for p = 1 (no o_par entries),
# We use the function make_mask_names with p = 1 to get the correct names and
# length 
p1_names <- make_mask_names(1)
math_vec <- p1_names
math_vec[] <- c(11, log(1.2), log(0.8), -6.7, -1.13)
# We get a list with parameters in biological scale
math_to_bio(math_vec)

# For p = 2 (includes o_par1) -- using the shipped example vector
math_to_bio(example_1$par_vec)



cleanEx()
nameEx("num_env_var")
### * num_env_var

flush(stderr()); flush(stdout())

### Name: num_env_var
### Title: Get the number of environmental variables given the number of
###   parameters
### Aliases: num_env_var

### ** Examples

num_env_var(5) # -> 1  (since num_par(1) = 5)
num_env_var(9) # -> 2  (since num_par(2) = 9)
num_env_var(14) # -> 3  (since num_par(3) = 14)
# round-trip check:
p <- 4
stopifnot(num_env_var(num_par(p)) == p)



graphics::par(get("par.postscript", pos = 'CheckExEnv'))
cleanEx()
nameEx("num_par")
### * num_par

flush(stderr()); flush(stdout())

### Name: num_par
### Title: Get the number of parameters of the main xsdm model given the
###   number of environmental variables to be considered
### Aliases: num_par

### ** Examples

num_par(2)



graphics::par(get("par.postscript", pos = 'CheckExEnv'))
cleanEx()
nameEx("optimize_likelihood")
### * optimize_likelihood

flush(stderr()); flush(stdout())

### Name: optimize_likelihood
### Title: Optimize the xsdm log-likelihood from multiple starts
###   (ucminfcpp)
### Aliases: optimize_likelihood

### ** Examples

optimize_likelihood(
  env_dat = example_1$env_array[1:4, , ],
  occ = example_1$occ_vec[1:4],
  num_starts = 4L
)



cleanEx()
nameEx("profile_likelihood")
### * profile_likelihood

flush(stderr()); flush(stdout())

### Name: profile_likelihood
### Title: Basic (non-adaptive) tool for profiling the likelihood
### Aliases: profile_likelihood

### ** Examples

## Minimal profiling example (fast): 1 step left + 1 step right
res <- profile_likelihood(
  profile_parameter = "mu1",
 increment_left = 0.2,
 increment_right = 0.2,
 num_steps_left = 1L, # one iteration on the left
 num_steps_right = 1L, # one iteration on the right
 alpha = 0.95,
 optim_param_vector = example_1$optim_par_vec,
 env_dat = example_1$env_array,
 occ = example_1$occ_vec,
 num_threads = 1L, # keep it fast and deterministic
 control = list(maxeval = 20),
 verbose = FALSE
)
# Check the structure of the output:
res$profile
res$threshold
res$found_better
## Full math-scale parameter vectors used at each evaluated point:
res$parameter_df



cleanEx()
nameEx("start_parms")
### * start_parms

flush(stderr()); flush(stdout())

### Name: start_parms
### Title: Starting parameters for the optimization
### Aliases: start_parms

### ** Examples

env_dat <- example_1$env_array[example_1$occ_vec == 1, , ]
start_parms(env_dat)
start_parms(env_dat, mask = c(mu2 = 5, pd = 1))



cleanEx()
nameEx("vsp")
### * vsp

flush(stderr()); flush(stdout())

### Name: vsp
### Title: Generate a virtual species probability map with presence/absence
###   sampling
### Aliases: vsp

### ** Examples




### * <FOOTER>
###
cleanEx()
options(digits = 7L)
base::cat("Time elapsed: ", proc.time() - base::get("ptime", pos = 'CheckExEnv'),"\n")
grDevices::dev.off()
###
### Local variables: ***
### mode: outline-minor ***
### outline-regexp: "\\(> \\)?### [*]+" ***
### End: ***
quit('no')
