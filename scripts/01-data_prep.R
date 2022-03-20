#### Preamble ####
# Purpose: Organise and prepare the 2021 & 2018 US GSS data. 
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
raw_data_2021 <- haven::read_dta("inputs/data/2021_stata/gss2021.dta")

# Select variables of interest. Variable information from GSS Codebook 2021
selected_data_2021 <- raw_data_2021 %>% select(age, finalter, finrela, goodlife, satfin)

# Reduce individual ages into grouped categories
selected_data_2021 <- selected_data_2021 %>% mutate(age = case_when(
  age >= 18 & age <= 29 ~ "18-29",
  age >= 30 & age <= 39 ~ "30-39",
  age >= 40 & age <= 49 ~ "40-49",
  age >= 50 & age <= 64 ~ "50-64",
  age >= 64 & age <= 89 ~ "64-89"
))

# Replace response values with corresponding label for each variable

selected_data_2021 <- selected_data_2021 %>% mutate(finalter = case_when(
  finalter == 1 ~ "Getting better",
  finalter == 2 ~ "Getting worse",
  finalter == 3 ~ "Stayed the same"
))

# FINRELA 5 was labelled as "far about average"- assumed typo as it is named
# "far above average" in past years
selected_data_2021 <- selected_data_2021 %>% mutate(finrela = case_when(
  finrela == 1 ~ "Far below average",
  finrela == 2 ~ "Below average",
  finrela == 3 ~ "Average",
  finrela == 4 ~ "Above average",
  finrela == 5 ~ "Far above average"
))

selected_data_2021 <- selected_data_2021 %>% mutate(goodlife = case_when(
  goodlife == 1 ~ "Strongly agree",
  goodlife == 2 ~ "Agree",
  goodlife == 3 ~ "Neither agree nor disagree",
  goodlife == 4 ~ "Disagree",
  goodlife == 5 ~ "Strongly disagree"
))

selected_data_2021 <- selected_data_2021 %>% mutate(satfin = case_when(
  satfin == 1 ~ "Pretty well satisfied",
  satfin == 2 ~ "More or less satisfied",
  satfin == 3 ~ "Not satisfied"
))

selected_data_2021['year'] = 2021

# Read in the data from 2018 GSS. Formatted as .dta, so use haven 
raw_data_2018 <- haven::read_dta("inputs/data/GSS2018.dta")

# Select variables of interest same as 2021
selected_data_2018 <- raw_data_2018 %>% select(age, finalter, finrela, goodlife, satfin)

# Reduce individual ages into grouped categories
selected_data_2018 <- selected_data_2018 %>% mutate(age = case_when(
  age >= 18 & age <= 29 ~ "18-29",
  age >= 30 & age <= 39 ~ "30-39",
  age >= 40 & age <= 49 ~ "40-49",
  age >= 50 & age <= 64 ~ "50-64",
  age >= 64 & age <= 89 ~ "64-89"
))

# Replace response values with corresponding label for each variable
selected_data_2018 <- selected_data_2018 %>% mutate(finalter = case_when(
  finalter == 1 ~ "Getting better",
  finalter == 2 ~ "Getting worse",
  finalter == 3 ~ "Stayed the same"
))

selected_data_2018 <- selected_data_2018 %>% mutate(finrela = case_when(
  finrela == 1 ~ "Far below average",
  finrela == 2 ~ "Below average",
  finrela == 3 ~ "Average",
  finrela == 4 ~ "Above average",
  finrela == 5 ~ "Far above average"
))

selected_data_2018 <- selected_data_2018 %>% mutate(goodlife = case_when(
  goodlife == 1 ~ "Strongly agree",
  goodlife == 2 ~ "Agree",
  goodlife == 3 ~ "Neither agree nor disagree",
  goodlife == 4 ~ "Disagree",
  goodlife == 5 ~ "Strongly disagree"
))

selected_data_2018 <- selected_data_2018 %>% mutate(satfin = case_when(
  satfin == 1 ~ "Pretty well satisfied",
  satfin == 2 ~ "More or less satisfied",
  satfin == 3 ~ "Not satisfied"
))

selected_data_2018['year'] = 2018

selected_data <- rbind(selected_data_2021, selected_data_2018)

write_csv(selected_data, "inputs/data/gss_data.csv")


         