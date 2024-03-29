plot_test_numeric <- function(n = 100, iterations = 100, fun = test_dataset_numeric) {
  
  plot_data <- plot_data_fun(n, iternations, fun)
  plot_data <- plot_data %>% filter(time <= 2 * mean(time))
  ggplot2::ggplot(data.frame(plot_data), ggplot2::aes(x = call, y = time)) +
    ggplot2::geom_boxplot() +
    ggplot2::coord_flip() +
    ggplot2::ggtitle(paste("Dataset has", n, "rows", "| OS:", Sys.info()["sysname"]))
  
}

plot_data_fun <- function(n = 100, iterations = 100, fun = test_dataset_numeric) {
  my_data <- data_set_creation(n)
  
  x <- fun(my_data, iterations = iterations)
  
  plot_data <- data.frame(
    call = matrix(vapply(x$expression %>% as.character(), function(x) rep(x, iterations), character(iterations)), ncol = 1),
    time = as.numeric(do.call("c", x$time)),
    n = n
  )
  
  return(plot_data)
}