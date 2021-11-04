# `rtry`: Preprocessing Plant Trait Data

# Overview

`rtry` is an R package to support the application of plant trait data providing easily applicable functions for the basic steps of data preprocessing, e.g. data import, data exploration, selection of columns and rows, excluding trait data according to different attributes, long- to wide-table transformation, data export, and geocoding. The `rtry` package is designed to support the preprocessing of data released from the TRY Plant Trait Database (https://www.try-db.org), but is also applicable for other trait data.

<br>

## Sources of `rtry`

There are three sources where users can download the `rtry` package and the relevant documentation.

**CRAN**

The `rtry` package is available on the CRAN repository. This is the recommended option to obtain the latest version of the package.

**GitHub Repository**

As mentioned before, the TRY R project is an open-source project that can be found on the MPI-BGC-Functional-Biogeography GitHub repository: https://github.com/MPI-BGC-Functional-Biogeography/rtry.

- Code: the source code for the released package, as well as the developing functions
- Wiki: the documentation of the package and the example workflows, as well as some additional information related to the TRY R project
- Issues: users can use this platform to report bugs or provide feature suggestions

Developers are also welcome to contribute to the package.

**Nextcloud**

We have setup a shared directory on the MPI-BGC Nextcloud, where users can obtain the source package and the corresponding documentation, as well as the sample data and example workflows. Pre-prepared folder structure for the two example workflows can be found.

- Link: https://nextcloud.bgc-jena.mpg.de/s/RMd5kqg7tRWXpae
- Password: `mpi-bgc-rtry`

<br>

# Installation guide

## R environment

R 4.0.3 was used to develop and build the `rtry` package, and this is the minimum version required to use the package.

The latest version of R can be downloaded from CRAN, a network of ftp and web servers around the world that store the code and documentation of R: https://cran.r-project.org/

In case RStudio is used, we also recommend to use the latest version of RStudio when using the package. The released version of RStudio, an integrated development environment (IDE) designed for productive R programming, can be found at https://www.rstudio.com/products/rstudio/download/, it is sufficient to use the free and open source version of RStudio Desktop.

<br>

## Install the `rtry` package

The installation of the `rtry` package can be performed through the RStudio console.

First, install all the dependencies with the command.

```R
install.packages(c("data.table", "dplyr", "tidyr", "jsonlite", "curl"))
```

Once installation is completed, the message `The downloaded source packages are in <path>` should be seen.

Next, install the `rtry` package with the command:

From CRAN:

```R
install.packages("rtry")
```

Else, if user downloaded the source package (`.tar.gz`) from the GitHub repository or Nextcloud:

```R
install.packages("<path_to_rtry.tar.gz>", repos = NULL, type = "source")
```

You may ignore the warning message `Rtools is required to build R packages but is not currently installed` if appears.

Once installation is completed, the `rtry` package can be loaded with the command `library(rtry)`.

<br>

# Functions

Function naming convention where each function begins with the prefix ```rtry_``` followed by the description of what the specific function does.

- `rtry_import`: Import data
- `rtry_explore`: Explore data
- `rtry_bind_col`: Bind data by columns
- `rtry_bind_row`: Bind data by rows
- `rtry_join_left`: Left join for two data frames
- `rtry_join_outer`: Outer join for two data frames
- `rtry_select_col`: Select columns
- `rtry_select_row`: Select rows
- `rtry_select_anc`: Select ancillary data in wide table format
- `rtry_exclude`: Exclude data
- `rtry_rm_col`: Remove columns
- `rtry_rm_dup`: Remove duplicates in data
- `rtry_trans_wider`: Transform data from long to wide table
- `rtry_export`: Export preprocessed data
- `rtry_geocoding`: Perform geocoding
- `rtry_revgeocoding`: Perform reverse geocoding

<br>

# Usage

A simple example showing how to use the `rtry` package to import, explore and exclude trait data based on observation.

```R
# Load the rtry package
library(rtry)

# Import the raw sample dataset provided within rtry package
TRYdata1 <- rtry_import(system.file("testdata", "TRYdata_15160.txt", package = "rtry"))

# Explore the imported data
# Group the input data based on AccSpeciesID, AccSpeciesName, DataID, DataName, TraitID and TraitName, and
# sort by TraitID
# Note: For TraitID == "NA", meaning that entry is an ancillary data
TRYdata1_explore_aux <- rtry_explore(TRYdata1,
                          AccSpeciesID, AccSpeciesName, DataID, DataName,
                          TraitID, TraitName,
                          sortBy = TraitID)
View(TRYdata1_explore_aux)

# In the sample dataset, different trait measurements on the same entity (plant) and
# the corresponding ancillary data are combined to observation via the ObservationID
# For details, see Kattge et al. 2011 GCB
# Exclude (remove) observations of juvenile plants or saplings
# Select the rows where DataID is 413, i.e. the data containing the plant development status
# Then explore the unique values of the OrigValueStr within the selected data
tmp_unexcluded <- rtry_select_row(TRYdata1, DataID %in% 413)
tmp_unexcluded <- rtry_explore(tmp_unexcluded,
                    DataID, DataName, OriglName, OrigValueStr, OrigUnitStr,
                    StdValue, Comment,
                    sortBy = OrigValueStr)
View(tmp_unexcluded)

# Criteria
# 1. DataID equals to 413
# 2. OrigValueStr equals to "juvenile" or "saplings"
TRYdata1 <- rtry_exclude(TRYdata1,
              (DataID %in% 413) & (OrigValueStr %in% c("juvenile", "saplings")),
              baseOn = ObservationID)
View(TRYdata1)

# Double check the workdata to ensure the excluding worked as expected
# Select the rows where DataID is 413, i.e. the data containing the plant development status
# Then explore the unique values of the OrigValueStr within the selected data
tmp_excluded <- rtry_select_row(TRYdata1, DataID %in% 413)
tmp_excluded <- rtry_explore(tmp_excluded,
                  DataID, DataName, OriglName, OrigValueStr, OrigUnitStr,
                  StdValue, Comment,
                  sortBy = OrigValueStr)
View(tmp_excluded)
```

Additional vignettes provide a detailed introduction to `rtry` and example workflows for trait data preprocessing and for geocoding are available at:

- Introduction to `rtry` (rtry-introduction)

-   The general workflow (rtry-workflow-general)
-   An example workflow setup to demonstrate how to use the `rtry` package to preprocess of the data exported from the TRY database
    -   Covers most of the `rtry_` functions from importing and exploring to binding multiple data, as well as selecting, excluding specific data and removing duplicates, and finally exporting the preprocess data

-   Perform (reverse) geocoding (rtry-workflow-geocoding)

    -   An example workflow setup to demonstrate how to use the `rtry` package to perform geocoding and reverse geocoding on the TRY data
    -   Covers mainly the functions `rtry_geocoding` and `rtry_revgeocoding`

```R
vignette("<name_of_vignette>")
```

<br>

# Data license

The `rtry` package is distributed under the [CC BY 4.0](https://github.com/MPI-BGC-Functional-Biogeography/rtry/blob/main/LICENSE.md) license, with a remark that the (reverse) geocoding functions provided within the package used the Nominatim developed with OpenStreetMap. Despite the API and the data provided are free to use for any purpose, including commercial use, note that they are governed by the [Open Database License (ODbL)](https://wiki.osmfoundation.org/wiki/Licence).

<br>
