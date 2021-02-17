# The TRY R Project (rtry): An R Package to Preprocess Plant Trait Data in the TRY Database

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
| 14.  | OriginalName          | Original name of sub-trait or context information            |
| 15.  | OrigValueStr          | Original value as text string                                |
| 16.  | OrigUnitStr           | Original unit as text string                                 |
| 17.  | ValueKindName         | Value kind (single measurement, mean, median, etc.)          |
| 18.  | OrigUncertaintyStr    | Original uncertainty as text string                          |
| 19.  | UncertaintyName       | Kind of uncertainty (standard deviation, standard error, etc.) |
| 20.  | Replicates            | Count of replicates                                          |
| 21.  | StdValue              | Standardized value: available for standardized traits        |
| 22.  | StdUnit               | Standard unit: available for standardized traits             |
| 23.  | RelUncertaintyPercent | Relative uncertainty in %                                    |
| 24.  | OrigObsDataID         | Unique identifier for duplicate entries                      |
| 25.  | ErrorRisk             | Indication for outliers: distance to mean in standard deviations |
| 26.  | Reference             | Reference to be cited if trait record is used in analysis    |
| 27.  | Comment               | Explanation for the OriginalName in the contributed dataset  |



Note that sometimes R may show a column 28, which should be empty. This column is an artefact due to the different software (MySQL >> R).


***

## Functions

Function naming convention where each function begins with the prefix ```rtry_``` followed by the description of what the specific function does.

- ```rtry_import```
- ```rtry_explore```
- ```rtry_bind```
- ```rtry_select_col```
- ```rtry_select_row```
- ```rtry_filter```
- ```rtry_rm_col```
- ```rtry_rm_dup```
- ```rtry_export```
- ```rtry_geocoding```
- ```rtry_revgeocoding```
