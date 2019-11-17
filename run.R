install.packages(c("bench", "dtplyr", "dplyr", "ggplot2"))
library(dtplyr)
library(dplyr)

source("data_set_creation.R")
source("test_dataset_numeric.R")
source("test_dataset_char.R")
source("plot_test_numeric.R")

plot_test_numeric(n = 100, iterations = 1000)

plot_test_numeric(n = 10 ^ 5, iterations = 1000)

plot_test_numeric(n = 10 ^ 6, iterations = 1000)

plot_test_numeric(n = 10 ^ 7, iterations = 500)

plot_test_numeric(n = 100, iterations = 1000, fun = test_dataset_char)

plot_test_numeric(n = 10 ^ 5, iterations = 1000, fun = test_dataset_char)

plot_test_numeric(n = 10 ^ 7, iterations = 1000)
