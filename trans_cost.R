trans_cost <- function(ds){
  bench::mark(
  translate = ds %>% 
    filter(numeric_double < 1.5) %>% 
    mutate(new_var = 235.21 / numeric_double) %>% # liters / 100 km
    group_by(letter) %>% 
    summarise(new_var = mean(new_var)),
  iterations = iterations
)
}