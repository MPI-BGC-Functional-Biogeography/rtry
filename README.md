# The TRY R Project (`rtry`): An R Package to Preprocess Plant Trait Data in the TRY Database

# <a name="introduction">Introduction

The TRY database (https://www.try-db.org) is a Plant Trait Database operated since 2007 with the incentive to improve the availability and accessibility of plant trait data for ecology and earth system sciences. Since then, the TRY database has grown continuously and is now providing unprecedented data coverage under an open access data policy for research community worldwide.

Through the TRY Data Portal, the trait data is provided as zipped text file (.txt). In version 5, there are 27 columns in the provided data, which is indicated as header in the first row of the text file.


|      | Column                | Comment                                                      |
| ---- | --------------------- | ------------------------------------------------------------ |
| 1.   | LastName              | Surname of data contributor                                  |
| 2.   | FirstName             | First name of data contributor                               |
| 3.   | DatasetID             | Unique identifier of contributed dataset                     |
| 4.   | Dataset               | Name of contributed dataset                                  |
| 5.   | SpeciesName           | Original name of species                                     |
| 6.   | AccSpeciesID          | Unique identifier of consolidated species name               |
| 7.   | AccSpeciesName        | Consolidated species name                                    |
| 8.   | ObservationID         | Unique identifier for each observation                       |
| 9.   | ObsDataID             | Unique identifier for each record                            |
| 10.  | TraitID               | Unique identifier for traits (only if the record is a trait) |
| 11.  | TraitName             | Name of trait (only if the record is a trait)                |
| 12.  | DataID                | Unique identifier for each sub-trait or context information  |
| 13.  | DataName              | Name of sub-trait or context information                     |
| 14.  | OriglName             | Original name of sub-trait or context information            |
| 15.  | OrigValueStr          | Original value as text string                                |
| 16.  | OrigUnitStr           | Original unit as text string                                 |
| 17.  | ValueKindName         | Value kind (single measurement, mean, median, etc.)          |
| 18.  | OrigUncertaintyStr    | Original uncertainty as text string                          |
| 19.  | UncertaintyName       | Kind of uncertainty (standard deviation, standard error, etc.) |
| 20.  | Replicates            | Count of replicates                                          |
| 21.  | StdValue              | Standardized value: available for standardized traits        |
| 22.  | UnitName              | Standard unit: available for standardized traits             |
| 23.  | RelUncertaintyPercent | Relative uncertainty in %                                    |
| 24.  | OrigObsDataID         | Unique identifier for duplicate entries                      |
| 25.  | ErrorRisk             | Indication for outliers: distance to mean in standard deviations |
| 26.  | Reference             | Reference to be cited if trait record is used in analysis    |
| 27.  | Comment               | Explanation for the OriglName in the contributed dataset     |

Note: sometimes R may show a column 28, which should be empty. This column is an artefact due to the different software (MySQL >> R).

<br>

# <a name="installation">Installation guide

### R environment

R 4.0.3 was used to develop and build the `rtry` package, and this is the minimum version required to use the package. It is also recommended to use the latest version of RStudio when using the package.

The latest version of R can be downloaded from CRAN, a network of ftp and web servers around the world that store the code and documentation of R: https://cran.r-project.org/

The released version of RStudio, an integrated development environment (IDE) designed for productive R programming, can be found at https://rstudio.com/products/rstudio/download/, it is sufficient to use the free and open source version of RStudio Desktop.

<br>

### Download the `rtry` package

The source package and documentation of the `rtry` package can be downloaded from the Nextcloud operated by MPI-BGC.

- Link: https://nextcloud.bgc-jena.mpg.de/s/RMd5kqg7tRWXpae
- Password: `mpi-bgc-rtry`

Once the download is completed, extract the folder to a desired location.

<br>

#### Overview of the file structure

```markdown
.
├── build				# Source files for the rtry package
│   ├── rtry_x.x.x.xxxx	# Source package
├── docs				# Documentation files
├── examples				# Scripts of example workflow
│   ├── input				# Input files needed for testing
└── README.md
```

Note: If user wishes to try out the package with the provided example scripts, it is advised to download the entire directory and maintain the file structure.

<br>

#### Install `rtry` package

The installation of the `rtry` package can be performed through the RStudio console.

First, install all the dependencies with the command.

```R
install.packages(c("data.table", "dplyr", "tidyr", "jsonlite", "curl"))
```

Once installation is completed, the message `The downloaded source packages are in <path>` should be seen.




Next, install the `rtry` package with the command:

```R
install.packages("<path_to_rtry.tar.gz>", repos = NULL, type = "source")
```

You may ignore the warning message `Rtools is required to build R packages but is not currently installed` if appears.



Once installation is completed, the `rtry` package can be loaded with the command `library(rtry)`.


To try out the example scripts, open the `.Rmd` (e.g. `TRYdata_7571_2020_01_20_rtry.Rmd`) inside the `examples` directory. Then, set the work directory to the location where the directory is located:

```R
setwd("<path_to_rtry_examples_dir>")
```

Place the cursor in the code block you wish to execute, then press `Ctrl+Shift+Enter` to execute the codes in that particular block.

Note: the expected results could be viewed in the corresponding `.html` file.

<br>

#### Update `rtry` package

To update the `rtry` package to a newer version, simply restart RStudio and use the same installation command:

```R
# Remember to restart RStudio first
install.packages("<path_to_rtry.tar.gz>", repos = NULL, type = "source")
```

You may ignore the warning message `Rtools is required to build R packages but is not currently installed` if appears.

<br>

# <a name="functions">Functions

Function naming convention where each function begins with the prefix ```rtry_``` followed by the description of what the specific function does.

- `rtry_import`
- `rtry_explore`
- `rtry_bind_col`
- `rtry_bind_row`
- `rtry_merge_col`
- `rtry_merge_row`
- `rtry_select_col`
- `rtry_select_row`
- `rtry_select_aux`
- `rtry_filter`
- `rtry_filter_keyword`
- `rtry_rm_col`
- `rtry_rm_dup`
- `rtry_trans_wider`
- `rtry_export`
- `rtry_geocoding`
- `rtry_revgeocoding`
