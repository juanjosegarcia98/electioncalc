# electioncalc

<!-- badges: start -->

<!-- badges: end -->

The goal of electioncalc is to ...

## Installation

You can install the development version of electioncalc like so:

``` r
devtools::install_github("juanjosegarcia98/electioncalc")
```

## Example

This is a basic example which shows you how to solve a common problem:

``` r
library(electioncalc)

allocate_seats_dhondt(
  parties_votes = c(
    "Party A" = 3550321L,
    "Party B" = 3444446L,
    "Party C" = 669865L,
    "Party D" = 609158L,
    "Party E" = 389295L,
    "Party F" = 263515L
  ),
  total_electors_or_votes = 12888231L,
  seats_to_allocate = 35,
  votes_threshold = 0.03
)
```
