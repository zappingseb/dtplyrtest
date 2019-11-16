data_set_creation <- function(n) {
  words = vapply(1:15, FUN = function(x) paste(sample(LETTERS, 15, TRUE), collapse = ""), FUN.VALUE = character(1))
  data.frame(
    word = sample(words, n, TRUE),
    letter = sample(LETTERS, n, TRUE),
    id = 1:n,
    numeric_int = sample(1:100, n, TRUE),
    numeric_double = sample(seq(from = 0, to = 2, by = 1/(10^6)), n, TRUE),
    missing = sample(c(NA, 1:100), n, TRUE)
  )
  
}

