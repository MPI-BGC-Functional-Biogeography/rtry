# `rtry`: Preprocessing Plant Trait Data

# Overview

`rtry` is an R package to support the application of plant trait data providing easily applicable functions for the basic steps of data preprocessing, e.g. data import, data exploration, selection of columns and rows, excluding trait data according to different attributes, long- to wide-table transformation, data export, and geocoding. The `rtry` package is designed to support the preprocessing of data released from the TRY Plant Trait Database (https://www.try-db.org), but is also applicable for other trait data.

<br>

## Sources of `rtry`

There are two sources where users can download the `rtry` package and the relevant documentation.

**CRAN**

The `rtry` package is available on the CRAN repository. This is the recommended option to obtain the latest version of the package.

**GitHub Repository**

The TRY R project is an open-source project that can be found on the MPI-BGC-Functional-Biogeography GitHub repository: https://github.com/MPI-BGC-Functional-Biogeography/rtry.

- Code: the source code for the released package, as well as the developing functions
- Wiki: the documentation of the package and the example workflows, as well as some additional information related to the TRY R project
- Issues: users can use this platform to report bugs or provide feature suggestions

Developers are also welcome to contribute to the package.

<br>

# Installation guide

## R environment

R 4.0.5 was used to develop and build the `rtry` package, and this is the minimum version required to use the package.

The latest version of R can be downloaded from CRAN, a network of ftp and web servers around the world that store the code and documentation of R: https://cran.r-project.org/

In case RStudio is used, we also recommend to use the latest version of RStudio when using the package, which can be found at https://posit.co/download/rstudio-desktop/, it is sufficient to use the free and open source version of RStudio Desktop.

<br>

## Install the `rtry` package

The installation of the `rtry` package can be performed through the RStudio console.

First, install all the dependencies with the command:

```R
install.packages(c("data.table", "dplyr", "tidyr", "jsonlite", "curl"))
```

Once the installation is completed, the message "`The downloaded source packages are in <path>`" should be seen.

Next, install the `rtry` package with the command:

From CRAN:

```R
install.packages("rtry")
```

Else, if user downloaded the source package (`.tar.gz`) from the GitHub repository:

```R
install.packages("<path_to_rtry.tar.gz>", repos = NULL, type = "source")
```

You may ignore the warning message "`Rtools is required to build R packages but is not currently installed`" if appears.

Once the installation is completed, the `rtry` package needs to be loaded with the command `library(rtry)`.

<br>

# Functions

Inside the `rtry` package, we use a function naming convention where each function begins with the prefix `rtry_` followed by the description of what the specific function does. The `rtry` package consists of the following functions:

- `rtry_import`: Import data
- `rtry_explore`: Explore data
- `rtry_bind_col`: Bind data by columns
- `rtry_bind_row`: Bind data by rows
- `rtry_join_left`: Left join for two data frames
- `rtry_join_outer`: Outer join for two data frames
- `rtry_select_col`: Select columns
- `rtry_select_row`: Select rows
- `rtry_select_anc`: Select ancillary data in wide-table format
- `rtry_exclude`: Exclude data
- `rtry_remove_col`: Remove columns
- `rtry_remove_dup`: Remove duplicates in data
- `rtry_trans_wider`: Transform data from long- to wide-table
- `rtry_export`: Export preprocessed data
- `rtry_geocoding`: Perform geocoding
- `rtry_revgeocoding`: Perform reverse geocoding

Once  `rtry` is installed and loaded, for documentation type `?` and the function name, e.g.:

```R
?rtry_import
```

To view the R code underlying the function:

```R
View(rtry_import)
```

<br>

# Usage

Here we provide a brief example of how to use the `rtry` package to import a dataset released from TRY, explore the data and exclude trait records based on specific criteria.

The `rtry_import` function displays the number of columns and rows of the imported datset and the column headers. Thus it provides the first step to explore the dataset. TRY released data in a long-table format: one trait record or ancillary data per row.

In the second step, we explore the dataset for plant species, traits and ancillary data.

Finally, we use the ancillary data on plant maturity (`DataID` 413) to exclude traits measured on juvenile plants or unknown. For this, we use the feature of the TRY data structure to combine different trait records and ancillary data measured on the same entity (plant) via the `ObservationID`. Then, we double-check that the data filtered for further analyses contain only the observations of adult and mature plants.

For a comprehensive introduction and detailed example, see the vignettes `rtry-introduction` and `rtry-workflow-general`.

```R
# Load the rtry package
library(rtry)

# Import the sample dataset from TRY provided within rtry package
TRYdata1 <- rtry_import(system.file("testdata", "data_TRY_15160.txt", package = "rtry"))

# View the imported data
View(TRYdata1)

# Explore the imported data
# Group the input data based on AccSpeciesID, AccSpeciesName, DataID, DataName, TraitID and TraitName, and sort by TraitID
# Note: For TraitID == "NA", meaning that entry is an ancillary data
TRYdata1_explore_anc <- rtry_explore(TRYdata1,
                          AccSpeciesID, AccSpeciesName, DataID, DataName,
                          TraitID, TraitName,
                          sortBy = TraitID)
View(TRYdata1_explore_anc)

# Select the rows where DataID is 413, i.e. the data containing the plant development status
# Explore the unique values of the OrigValueStr within the selected data
tmp_unfiltered <- rtry_select_row(TRYdata1, DataID %in% 413)
tmp_unfiltered <- rtry_explore(tmp_unfiltered,
                    DataID, DataName, OriglName, OrigValueStr, OrigUnitStr,
                    StdValue, Comment,
                    sortBy = OrigValueStr)
View(tmp_unfiltered)

# Exclude (remove) observations of juvenile plants or unknown development state
# Criteria
# 1. DataID equals to 413
# 2. OrigValueStr equals to "juvenile" or "unknown"
TRYdata1_filtered <- rtry_exclude(TRYdata1,
                      (DataID %in% 413) & (OrigValueStr %in% c("juvenile", "unknown")),
                      baseOn = ObservationID)
View(TRYdata1_filtered)

# Double-check the filtered data to ensure the excluding worked as expected
# Select the rows where DataID is 413
# Explore the unique values of the OrigValueStr within the selected data
tmp_filtered <- rtry_select_row(TRYdata1_filtered, DataID %in% 413)
tmp_filtered <- rtry_explore(tmp_filtered,
                  DataID, DataName, OriglName, OrigValueStr, OrigUnitStr,
                  StdValue, Comment,
                  sortBy = OrigValueStr)
View(tmp_filtered)
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

# Copyright license

The `rtry` package is distributed under the [CC BY 4.0](https://github.com/MPI-BGC-Functional-Biogeography/rtry/blob/main/LICENSE.md) license, with a remark that the (reverse) geocoding functions provided within the package used the Nominatim developed with OpenStreetMap. Although the API and the data provided are free to use for any purpose, including commercial use, note that they are governed by the [Open Database License (ODbL)](https://wiki.osmfoundation.org/wiki/Licence).

<br>
