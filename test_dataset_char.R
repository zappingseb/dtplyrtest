test_dataset_char <- function(ds, iterations = 100){
  
  ds_lazy <- lazy_dt(ds)
  
  mutate_char <- function(df) {
    df %>%
      filter(letter == "A") %>% 
      mutate(word_new = paste0(word, numeric_int)) %>% 
      select(word_new)
  }
  
  mutate_char_dt <- function(DT_int) {
    DT[letter == "A", word_new:=paste0(word, numeric_int)][letter == "A", "word_new"]
  }
  
  DT <- data.table::as.data.table(ds)
  
  return(bench::mark(
    ds %>% mutate_char(),
    ds_lazy %>% mutate_char() %>% as_tibble(),
    mutate_char_dt(DT),
    check = FALSE,
    iterations = iterations
  ))
  
}
