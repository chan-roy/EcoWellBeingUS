#### Preamble ####
# Purpose: Organise and prepare the 2021 US GSS data. 
# Author: Roy Chan
# Data: 20 March 2022
# Contact: rk.chan@mail.utoronto.ca
# License: MIT
# Pre-requisites: 
# - Need to download the 2021 survey data from NORC and save to inputs/data
# - Download links can be found in the README


#### Workspace setup ####
library(haven)
library(tidyverse)

# Read in the data from 2021 GSS. Formatted as .dta, so use haven 
raw_data <- haven::read_dta("inputs/data/2021_stata/gss2021.dta")

# Select variables of interest. Variable information from GSS Codebook 
selected_data <- raw_data %>% select(age, finalter, finrela, goodlife, satfin)

# Reduce individual ages into grouped categories
selected_data <- selected_data %>% mutate(age = case_when(
  age >= 18 & age <= 29 ~ "18-29",
  age >= 30 & age <= 39 ~ "30-39",
  age >= 40 & age <= 49 ~ "40-49",
  age >= 50 & age <= 64 ~ "50-64",
  age >= 64 & age <= 89 ~ "64-89"
))

# Replace response values with corresponding label for each variable

selected_data <- selected_data %>% mutate(finalter = case_when(
  finalter == 1 ~ "Getting better",
  finalter == 2 ~ "Getting worse",
  finalter == 3 ~ "Stayed the same"
))

# FINRELA 5 was labelled as "far about average"- assumed typo as it is named
# "far above average" in past years
selected_data <- selected_data %>% mutate(finrela = case_when(
  finrela == 1 ~ "Far below average",
  finrela == 2 ~ "Below average",
  finrela == 3 ~ "Average",
  finrela == 4 ~ "Above average",
  finrela == 5 ~ "Far above average"
))

selected_data <- selected_data %>% mutate(goodlife = case_when(
  goodlife == 1 ~ "Strongly agree",
  goodlife == 2 ~ "Agree",
  goodlife == 3 ~ "Neither agree nor disagree",
  goodlife == 4 ~ "Disagree",
  goodlife == 5 ~ "Strongly disagree"
))

selected_data <- selected_data %>% mutate(satfin = case_when(
  satfin == 1 ~ "Pretty well satisfied",
  satfin == 2 ~ "More or less satisfied",
  satfin == 3 ~ "Not satisfied"
))

write_csv(selected_data, "inputs/data/data.csv")





         