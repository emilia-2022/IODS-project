# title: Data Wrangling 
# author: Emilia Carson 
# date: November 17 2022 

# Script to read in, clean and select variables of interest to put into new data set

"This data approach student achievement in secondary education of two Portuguese schools.
The data attributes include student grades, demographic, social and school related features)
and it was collected by using school reports and questionnaires. Two datasets are provided
regarding the performance in two distinct subjects: Mathematics (mat) and Portuguese language (por)."

# Available at: https://archive.ics.uci.edu/ml/datasets/Student+Performance"

#Relevant packages and libraries 
library(tidyverse)
library(dplyr)

# Task 1 -----------------------------------------------------------------------

# read in data 

student_mat <- read.csv("student-mat.csv")

student_por <- read.csv("student-por.csv")

# explore structure and dimensions of the data
str(student_mat)
dim(student_mat)

str(student_por)
dim(student_por)

# Task 2 -----------------------------------------------------------------------

# columns that vary in the two data sets
free_cols <- c("failures", "paid", "absences", "G1", "G2","G3")

# common identifiers used for joining the data sets
join_cols <- setdiff(colnames(por), free_cols)

# join the two data sets by the selected identifiers
math_por <- inner_join(math, por, by = join_cols, suffix = c(".math", ".por"))

# explore structure and dimensions of the data
str(math_por)
dim(math_por)

# Task 3 -----------------------------------------------------------------------

# create a new data frame with only the joined columns
alc <- select(math_por, all_of(join_cols))

# for every column name not used for joining...
for(col_name in free_cols) {
  # select two columns from 'math_por' with the same original name
  two_cols <- select(math_por, starts_with(col_name))
  # select the first column vector of those two columns
  first_col <- select(two_cols, 1)[[1]]
  
  # then, enter the if-else structure!
  # if that first column vector is numeric...
  if(is.numeric(first_col)) {
    # take a rounded average of each row of the twous columns and
    # add the resulting vector to the alc data frame
    alc[col_name] <- round(rowMeans(two_cols))
  } else { # else (if the first column vector was not numeric)...
    # add the first column vector to the alc data frame
    alc[col_name] <- first_col
  }
}

# Task 4 -----------------------------------------------------------------------

# create new column combining weekday and weekend alcohol use
alc <- mutate(alc, alc_use = (Dalc + Walc) / 2)

# create new binary column realted to high alcohol use
alc <- mutate(alc, high_use = alc_use > 2)

# Task 5 -----------------------------------------------------------------------

# check data to ensure correct 
glimpse(alc)

# write created dataset to csv 
write.csv(alc, "student_alc_use.csv", row.names=FALSE)

