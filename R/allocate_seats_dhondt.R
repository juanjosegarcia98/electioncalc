#' Calculates the allocation of seats to political parties in legislative
#' elections using the D'Hondt method.
#'
#' @param parties_votes numeric vector with the votes of each political party.
#' Must be named with the names of the political parties.
#' @param total_electors_or_votes integer value of the total amount of
#' registered electors or total amount of votes used to set the minimum
#' threshold.
#' @param seats_to_allocate integer value of the total amount of seats to be
#' allocated in the election.
#' @param votes_threshold double value, between 0 and 1, to represent the
#' minimum percentage of the total electors or votes needed to enter in the
#' allocation.
#'
#' @return An integer vector.
#' @export
#'
#' @examples
#' allocate_seats_dhondt(
#'   parties_votes = c(
#'     "Party A" = 3550321L,
#'     "Party B" = 3444446L,
#'     "Party C" = 669865L,
#'     "Party D" = 609158L,
#'     "Party E" = 389295L,
#'     "Party F" = 263515L
#'   ),
#'   total_electors_or_votes = 12888231L,
#'   seats_to_allocate = 35,
#'   votes_threshold = 0.03
#' )
allocate_seats_dhondt <-
  function(parties_votes,
           total_electors_or_votes,
           seats_to_allocate,
           votes_threshold = 0) {
    parties_votes_has_no_names <- is.null(names(parties_votes))

    parties_votes_are_not_integers <-
      FALSE == all.equal(
        unname(parties_votes),
        trunc(parties_votes)
      )

    total_electors_votes_invalid <-
      total_electors_or_votes < sum(parties_votes) ||
      !is.numeric(total_electors_or_votes) ||
      total_electors_or_votes != as.integer(total_electors_or_votes)

    seats_to_allocate_invalid <- seats_to_allocate <= 0 ||
      !is.numeric(seats_to_allocate) ||
      seats_to_allocate != as.integer(seats_to_allocate)

    votes_threshold_invalid <- votes_threshold < 0 ||
      votes_threshold > 1 ||
      !is.numeric(seats_to_allocate)

    if (parties_votes_has_no_names) {
      stop(
        "parties_votes must be named in every value with each party name."
      )
    }

    if (parties_votes_are_not_integers) {
      stop(
        "parties_votes must be a vector of integer or whole number values."
      )
    }

    if (total_electors_votes_invalid) {
      stop(
        "total_electors_or_votes must be a whole number greater or equal to the
        sum of parties_votes."
      )
    }

    if (seats_to_allocate_invalid) {
      stop("seats_to_allocate must be a whole number greater than 0.")
    }

    if (votes_threshold_invalid) {
      stop(
        "The voting percentage threshold must be entered as a number between 0
  and 1. E.g: 0.1 means 10%, 0.03 means 3%, etc."
      )
    }

    minimum_votes_required <- total_electors_or_votes * votes_threshold

    parties_votes <- parties_votes[parties_votes > minimum_votes_required]

    total_votes_above_threshold <- as.integer(sum(parties_votes))

    votes_per_seat <-
      total_votes_above_threshold / seats_to_allocate

    proyected_seats <- parties_votes / votes_per_seat

    sum_remainders_approx_seats <-
      sum(proyected_seats - trunc(proyected_seats))

    proyected_seats <- ceiling(proyected_seats) +
      ceiling(sum_remainders_approx_seats)

    quotients <- unlist(
      mapply(function(votes, n_seats) votes / seq.int(n_seats),
        parties_votes,
        proyected_seats,
        SIMPLIFY = FALSE
      )
    )

    names(quotients) <- rep(names(parties_votes), times = proyected_seats)

    quotients <- sort(x = quotients, decreasing = TRUE)

    quotients <- quotients[1:seats_to_allocate]

    frequency_table <- sort(table(names(quotients)), decreasing = TRUE)

    seat_results <- as.vector(frequency_table)

    names(seat_results) <- names(frequency_table)

    seat_results
  }
