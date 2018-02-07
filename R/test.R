# Just a little demonstration script.

library(tidyverse)

# Set up some test data and have a look at it. tribble()  is just a nice way to write a dataframe.
test_data <- tribble(
  ~destination,
  "restaurant",
  "burger king",
  "Burger King",
  "macdonalds",
  "movies",
  "Museum",
  "museum",
  "museum",
  "museum",
  "museum",
  "hockey",
  "hockey",
  "soccer"
)
test_data

# OK, let's set up some known categories and group them by their associated domain.
social_restaurant <- c("restaurant", "burger king")
social_movies <- c("movies")
recreation_sports <- c()

# OK, classify the data
clean_data <- test_data %>% 
  mutate(lower_case_destinations = str_to_lower(destination)) %>% # Converts everything to lower case
  mutate(classified_destination = case_when(
    lower_case_destinations %in% social_restaurant ~ "Social: Food",
    lower_case_destinations %in% social_movies ~ "Social: Movies",
    TRUE ~ NA_character_
  ))
clean_data

# How many are still unclassified? 
missing <- filter(clean_data, is.na(classified_destination)) %>% 
  nrow

message(str_interp("Unclassified: ${missing}"))

# What did we miss? and how are the big guys?
filter(clean_data, is.na(classified_destination)) %>% 
  group_by(lower_case_destinations) %>% 
  summarise(count = n()) %>% 
  arrange(desc(count))

# OK! Go back to the top, add in the categories you can see and re-run the script! And repeat, and repeat, and repeat! Good luck!
  
  
