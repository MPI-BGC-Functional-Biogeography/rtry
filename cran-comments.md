## Reasons for updated release
* Fixed the Nominatim URL format for OpenStreetMap (OSM) search function used in the rtry_geocoding function (follow-up action suggested by the email from Prof Brian Ripley)
* Enhanced functionality of the package


## Test environments
* Local Windows 10, R 4.0.5
* GitHub Actions: macOS-latest, windows-latest, ubuntu-20.04
* win-builder: devel and release
* mac_release: macOS Ventura 13.3.1, aarch64-apple-darwin20 (64-bit, Apple clang-1400.0.29.202, GCC 12.2.0)
* r-hub: Windows Server 2022 (R-devel, 64 bit), Ubuntu Linux 20.04.1 LTS (R-release, GCC), Fedora Linux (R-devel, clang, gfortran)


## R CMD check results
There were no ERRORs or WARNINGs or NOTEs.

* The possibly mis-spelled words were confirmed to be correct.


## revdepcheck results

We checked 0 reverse dependencies, comparing R CMD check results across CRAN and dev versions of this package.

 * We saw 0 new problems
 * We failed to check 0 packages
