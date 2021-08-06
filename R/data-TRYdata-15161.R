#' Sample TRY data (Request 15161)
#'
#' A dataset requested from the [TRY Database](https://www.try-db.org/TryWeb/Prop0.php).
#' The request ID of this dataset is 15161, which contains \code{TraitID}: 3117
#' and \code{AccSpeciesID}: 10773, 35846, 45737.
#'
#' @format A data frame with 4627 rows and 28 variables:
#' \describe{
#'   \item{LastName}{Surname of data contributor.}
#'   \item{FirstName}{First name of data contributor.}
#'   \item{DatasetID}{Unique identifier of contributed dataset.}
#'   \item{Dataset}{Name of contributed dataset}
#'   \item{SpeciesName}{Original name of species.}
#'   \item{AccSpeciesID}{Unique identifier of consolidated species name.}
#'   \item{AccSpeciesName}{Consolidated species name.}
#'   \item{ObservationID}{Unique identifier for each observation.}
#'   \item{ObsDataID}{Unique identifier for each record.}
#'   \item{TraitID}{Unique identifier for traits (only if the record is a trait).}
#'   \item{TraitName}{Name of trait (only if the record is a trait).}
#'   \item{DataID}{Unique identifier for each sub-trait or context information.}
#'   \item{DataName}{Name of sub-trait or context information.}
#'   \item{OriglName}{Original name of sub-trait or context information.}
#'   \item{OrigValueStr}{Original value as text string.}
#'   \item{OrigUnitStr}{Original unit as text string.}
#'   \item{ValueKindName}{Value kind (single measurement, mean, median, etc.).}
#'   \item{OrigUncertaintyStr}{Original uncertainty as text string.}
#'   \item{UncertaintyName}{Kind of uncertainty (standard deviation, standard error, etc.).}
#'   \item{Replicates}{Count of replicates.}
#'   \item{StdValue}{Standardized value: available for standardized traits.}
#'   \item{UnitName}{Standard unit: available for standardized traits.}
#'   \item{RelUncertaintyPercent}{Relative uncertainty in %.}
#'   \item{OrigObsDataID}{Unique identifier for duplicate entries.}
#'   \item{ErrorRisk}{Indication for outliers: distance to mean in standard deviations.}
#'   \item{Reference}{Reference to be cited if trait record is used in analysis.}
#'   \item{Comment}{Explanation for the \code{OriglName} in the contributed dataset.}
#'   \item{V28}{Empty, an artifact due to different interpretation of column separator by MySQL and R.}
#' }
"TRYdata_15161"
