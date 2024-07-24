test_that("Results are correct", {
  votes <- allocate_seats_dhondt(
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
  expect_equal(votes, c(
    "Party A" = 15,
    "Party B" = 15,
    "Party C" = 2,
    "Party D" = 2,
    "Party E" = 1
  ))
  votes_no_threshold <- allocate_seats_dhondt(
    parties_votes = c(
      "Party A" = 3550321L,
      "Party B" = 3444446L,
      "Party C" = 669865L,
      "Party D" = 609158L,
      "Party E" = 389295L,
      "Party F" = 263515L
    ),
    total_electors_or_votes = 12888231L,
    seats_to_allocate = 35
  )
  expect_equal(votes_no_threshold, c(
    "Party A" = 15,
    "Party B" = 14,
    "Party C" = 2,
    "Party D" = 2,
    "Party E" = 1,
    "Party F" = 1
  ))
})

test_that("Errors work", {
  expect_error(allocate_seats_dhondt(
    parties_votes = c(
      "Party A" = 3550321L,
      "Party B" = 3444446L,
      "Party C" = 669865L,
      "Party D" = 609158L,
      "Party E" = 389295L,
      "Party F" = 263515L
    ),
    total_electors_or_votes = 1288823L,
    seats_to_allocate = 35
  ))
  expect_error(allocate_seats_dhondt(
    parties_votes = c(
      "Party A" = 3550321L,
      "Party B" = 3444446L,
      "Party C" = 669865L,
      "Party D" = 609158L,
      "Party E" = 389295L,
      "Party F" = 263515L
    ),
    total_electors_or_votes = 12888231L,
    seats_to_allocate = 0
  ))
  expect_error(allocate_seats_dhondt(
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
    votes_threshold = -0.01
  ))
  expect_error(allocate_seats_dhondt(
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
    votes_threshold = 1.01
  ))
  expect_error(allocate_seats_dhondt(
    parties_votes = c(
      "Party A" = 3550321.12,
      "Party B" = 3444446.03,
      "Party C" = 669865.65,
      "Party D" = 609158.21,
      "Party E" = 389295.1,
      "Party F" = 263515.014
    ),
    total_electors_or_votes = 12888231L,
    seats_to_allocate = 35,
    votes_threshold = 0
  ))
  expect_error(allocate_seats_dhondt(
    parties_votes = c(
      3550321L,
      3444446L,
      669865L,
      609158L,
      389295L,
      263515L
    ),
    total_electors_or_votes = 12888231L,
    seats_to_allocate = 35,
    votes_threshold = 0
  ))
})
