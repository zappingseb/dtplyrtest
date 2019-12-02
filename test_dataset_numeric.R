test_dataset_numeric <- function(ds, iterations = 100){
  
  ds_lazy <- lazy_dt(ds)
  
  calc_check <- function(df) {
    df %>%
      filter(!is.na(missing)) %>% 
      group_by(letter) %>% 
      summarise(n = n(), delay = mean(numeric_int))
  }
  
  calc_check_dt <- function(DT_int) {
    DT_int[!is.na(missing),
           .(n = .N, delay = mean(numeric_int)),
           letter]
  }
  
  DT <- data.table::as.data.table(ds)
  
  return(bench::mark(
    ds %>% calc_check(),
    ds_lazy %>% calc_check() %>% as_tibble(),
    calc_check_dt(DT),
    check = FALSE,
    iterations = iterations
  ))
  
}