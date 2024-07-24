# electioncalc

<!-- badges: start -->

<!-- badges: end -->

The goal of electioncalc is to facilitate the calculation of seat allocation for each political party in a legislative election. Currently, it only includes the D'Hondt method, but it will soon incorporate other well-known methods such as Sainte-Laguë, Imperiali, and others.

> [!IMPORTANT]
> **This is a practice repository (the first one I upload that is personal). I made it with the main goal of reinforcing and showing my R programming skills. It is clearly incomplete and I would like to upgrade it and complete it when I have time. Feedback and Pull Requests are appreciated 😄.**

> [!NOTE]
> In the function `allocate_seats_dhondt()` I followed the logic and algorithm described in Argentina's National Electoral Code for the election of National Deputies. It does not yet deal with the case of two or more equal quotients when assigning a seat, or same number of votes in two or more lists (this last case is solved by a lottery in the mentioned code).

## Installation

You can install the development version of electioncalc like so:

``` r
# install devtools package if it's not already
if (!requireNamespace("devtools", quietly = TRUE)) {
  install.packages("devtools")
}

# load devtools package in your environment
library(devtools)

# use the install_github() function from devtools to download and install electioncalc from this repo
install_github("juanjosegarcia98/electioncalc")

# load electioncalc in your environment
library(electioncalc)
```

## Example

This is a basic example which shows you how to use the `allocate_seats_dhondt()` function:

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
# RETURNS:
# Party A Party B Party C Party D Party E 
#      15      15       2       2       1 
```
