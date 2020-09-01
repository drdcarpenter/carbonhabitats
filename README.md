
<!-- README.md is generated from README.Rmd. Please edit that file -->

# carbonhabitats

<!-- badges: start -->

[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://www.tidyverse.org/lifecycle/#experimental)
<!-- badges: end -->

The goal of carbonhabitats is to calculate the carbon storage and
sequestration of UK priority habitats. This is a simple one-function
package to calculate the amount of carbon stored (in above ground
biomass and in soil) and sequestered by priority habitats in the UK.
This is based on [Field et al. (2020) The value of habitats of
conservation importance to climate change mitigation in the UK.
Biological Conservation,
vol. 248](https://doi.org/10.1016/j.biocon.2020.108619). Carbon storage
and sequestration values are taken from [Taylor et al. (2019) High
carbon burial rates by small ponds in the landscape. Frontiers in
Ecology and the Environment. vol. 17](https://doi.org/10.1002/fee.1988).
The package also uses soil carbon data from the [FAO Global Soil Organic
Carbon
Map](http://www.fao.org/global-soil-partnership/pillars-action/4-information-and-data-new/global-soil-organic-carbon-gsoc-map/en/).

## Installation

You can install the latest version of carbonhabitats from
[Github](https://github.com/drdcarpenter/carbonhabitats) with:

``` r
# install.packages("devtools")
devtools::install_github("drdcarpenter/carbonhabitats")
```

## Example

This is a basic example which shows you how to calculate stored and
sequestered carbon using priority habitats data:

``` r
library(carbonhabitats)

# NOT RUN
# carbonise(x, habitats = "S41Habitat")
```
