## R CMD check results

0 errors | 0 warnings | 1 note (Debian/Windows)

## Test environments

* local Windows 11, R 4.5.3
* GitHub Actions: windows-latest (R release)
* GitHub Actions: macos-latest (R release)
* GitHub Actions: ubuntu-latest (R devel, release, oldrel-1, oldrel-2)
* win-builder: Windows (R devel)
* win-builder: Debian (R devel)

## Notes

* This is a new submission.
* The package uses compiled C++ code (Rcpp/RcppParallel) with vendored
  xtensor/xsimd/xtl headers. The vendored source is documented in
  `src/vendor/VENDORED_XTENSOR.md`.
* SystemRequirements: GNU make, C++17.

* On Windows (win-builder), `checking compiled code` produces:
  `'cc' is not on the path`

  This NOTE is a known limitation of the Windows CRAN check infrastructure:
  the compiled-code analysis tool requires a C compiler (`cc`) which is not
  available on that platform. The compiled code checks pass on Linux and macOS.
  See `Writing portable packages` in the Writing R Extensions manual.
