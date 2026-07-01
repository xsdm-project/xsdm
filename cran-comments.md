## R CMD check results

0 errors | 0 warnings | 0 notes

## Test environments

* local Windows 11, R 4.5.3
* GitHub Actions: windows-latest (R release)
* GitHub Actions: macos-latest (R release)
* GitHub Actions: ubuntu-latest (R devel, release, oldrel-1, oldrel-2)

## Notes

* This is a new submission.
* The package uses compiled C++ code (Rcpp/RcppParallel) with vendored
  xtensor headers. The vendored source is documented in
  `src/vendor/VENDORED_XTENSOR.md`.
* SystemRequirements: GNU make, C++17.
* On some Debian/Ubuntu builds of R, `R CMD check` reports a NOTE about the
  non-portable compilation flag `-mno-omit-leaf-frame-pointer`. This flag is
  injected by the system R's default `CFLAGS`/`CXXFLAGS` (Makeconf), not by the
  package, and does not appear under CRAN's build configuration.
