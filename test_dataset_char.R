test_dataset_char <- function(ds, iterations = 100){
  
  ds_lazy <- lazy_dt(ds)
  
  mutate_char <- function(df) {
    df %>%
      filter(letter == "A") %>% 
      mutate(word_new = paste0(word, numeric_int)) %>% 
      select(word_new)
  }
  
  mutate_char_dt <- function(DT_int) {
    DT[letter == "B", ][, word_new:=do.call(paste0, .SD), .SDcols=c("word", "numeric_int")][, "word_new"]
  }
  
  DT <- data.table::as.data.table(ds)
  
  return(bench::mark(
    ds %>% mutate_char(),
    ds_lazy %>% mutate_char() %>% as_tibble(),
    data.table::as.data.table(ds) %>% mutate_char_dt(),
    mutate_char_dt(DT),
    check = FALSE,
    iterations = iterations
  ))
  
}