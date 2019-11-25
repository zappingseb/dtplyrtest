install.packages(c("bench", "dtplyr", "dplyr", "ggplot2"))
library(dtplyr)
library(dplyr)
library(data.table)
library(bench)
library(ggplot2)

source("data_set_creation.R")
source("test_dataset_numeric.R")
source("test_dataset_char.R")
source("plot_test_numeric.R")

plot_data_num <- data.frame(
  call = c(),
  time = c(),
  n = c()
)

dataset_sizes <- c(100, 1000, 10E3, 10E4, 10E5, 10E6)
dataset_sizes <- c(100, 1000)
for (n in dataset_sizes){
  print(n)
  plot_data_num <- rbind(plot_data_num,
                         plot_data_fun(n, 1000, test_dataset_numeric)
                         )
}

data_gg <- plot_data_num %>% group_by(call, n) %>%
  summarise(mean = median(time), ymax = quantile(time, probs = c(0.75)), ymin = quantile(time, probs=(0.25)))

ggplot2::ggplot(data_gg, ggplot2::aes(x=n, y=mean, colour=call)) + 
  ggplot2::geom_errorbar(ggplot2::aes(ymin=ymin, ymax=ymax), width=.1) +
  ggplot2::geom_line() +
  ggplot2::geom_point() +
  ggplot2::xlab("Dataset size") +
  ggplot2::scale_y_continuous(trans = "log10") +
  ggplot2::scale_x_continuous(trans = "log10")

plot_data_char <- data.frame(
  call = c(),
  time = c(),
  n = c()
)
for (n in dataset_sizes){
  print(n)
  plot_data_char <- rbind(plot_data_char,
                         plot_data_fun(n, 1000, test_dataset_char)
                         )
}
data_gg <- plot_data_char %>% group_by(call, n) %>%
  summarise(mean = median(time), ymax = quantile(time, probs = c(0.75)), ymin = quantile(time, probs=(0.25)))
data_gg$call <- factor(as.character(data_gg$call), c("mutate_char_dt(DT)",
                                               "data.table::as.data.table(ds) %>% mutate_char_dt()",
                                               "ds %>% mutate_char()",
                                               "ds_lazy %>% mutate_char() %>% as_tibble()"))
ggplot2::ggplot(data_gg, ggplot2::aes(x=n, y=mean, colour=call)) + 
  ggplot2::geom_errorbar(ggplot2::aes(ymin=ymin, ymax=ymax), width=.1) +
  ggplot2::geom_line() +
  ggplot2::geom_point() +
  ggplot2::xlab("Dataset size") +
  ggplot2::scale_y_continuous(trans = "log10") +
  ggplot2::scale_x_continuous(trans = "log10") +
  ggplot2::theme_bw()
