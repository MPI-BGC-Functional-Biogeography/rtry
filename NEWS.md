# rtry 1.0.0

This is the first public released of the package `rtry`.

## Major changes

- Resized and moved images to the source directory of the vignettes (`vignettes\`)
- Fixed image paths for the vignettes

## Minor changes

- Updated url for `tidyr::pivot_wider()`



# rtry 0.0.0.9500 

## Major changes

-   Added new functions `rtry_select_aux()`, `rtry_merge_col()` and `rtry_merge_row()`
- Removed data `TRYdata_14833` and corresponding documentation
- Updated testing scripts
- Updated the printing of column names from `ls` to `colnames`



# rtry 0.0.0.9420 

## Major changes

- Updated `rtry-vignette`
- Completed `rtry-workflow-general`



# rtry 0.0.0.9412

## Major changes

- Updated vignettes - `rtry-vignette` and `rtry-workflow-general`
- Updated function descriptions for `rtry_select_row`, `rtry_filter` and `rtry_filter_keyword`
- Added feedback message for `rtry_select_col` and `rtry_rm_col`



# rtry 0.0.0.9411

## Major changes

- Started working on vignettes - `rtry-workflow-general`  



# rtry 0.0.0.9410

## Major changes

- Added new data `TRYdata_15160` and `TRYdata_15161`
- Updated function description for `rtry_import()`, `rtry_bind_col()` and `rtry_bind_row()`
- Updated vignettes - `rtry-vignette` and `rtry-workflow-geocoding`



# rtry 0.0.0.9401

## Major changes

- Separated functions into individual files
- Added package testing
- Added sample data and data description
- Changed default encoding for `rtry_import` into `Latin-1`
- Modified `showOverview` option within `rtry_bind_col()` and `rtry_bind_row()`
- Modified`rtry_import()`message for empty argument
- Updated `DESCRIPTION` to include `utils`, updated author list
- Fixed no binding variables



# rtry 0.0.0.9300  

## Major changes

- Updated development environment to R 4.0.3  



# rtry 0.0.0.9210

## Major changes

- Added vignette `rtry-workflow-geocoding`



# rtry 0.0.0.9200

## Major changes

- Added dependencies
- Enabled email validation in `rtry_geocoding()` and `rtry_revgeocoding()`
- Added messages for missing values in each function



# rtry 0.0.0.9100

## Major changes

- Combined `rtry_exclude()` within `rtry_filter()`



# rtry 0.0.0.9000

First version of `rtry` for internal testing, this package includes functions designed to facilitate the pre-process the data exported from the TRY database. Function naming convention where each function begins with the prefix ```rtry_``` followed by the description of what the specific function does.

- `rtry_import`
- `rtry_explore`
- `rtry_bind_col`
- `rtry_bind_row`
- `rtry_select_col`
- `rtry_select_row`
- `rtry_filter`
- `rtry_filter_keyword`
- `rtry_exclude`
- `rtry_rm_col`
- `rtry_rm_dup`
- `rtry_trans_wider`
- `rtry_export`
- `rtry_geocoding`
- `rtry_revgeocoding`