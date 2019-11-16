library(dtplyr)
library(dplyr)

source("data_set_creation.R")
source("test_dataset_numeric.R")
source("plot_test_numeric.R")

plot_test_numeric(n = 100, iterations = 1000)

plot_test_numeric(n = 100000, iterations = 1000)

plot_test_numeric(n = 10 ^ 8, iterations = 1000)
