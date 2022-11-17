# title: Data Wrangling 
# author: Emilia Carson 
# date: November 17 2022 

# Script to read in, clean and select variables of interest to put into new data set

# This data approach student achievement in secondary education of two Portuguese schools. 
# The data attributes include student grades, demographic, social and school related features) and it was collected by using school reports and questionnaires. Two datasets are provided regarding the performance in two distinct subjects: Mathematics (mat) and Portuguese language (por).
# Available at: https://archive.ics.uci.edu/ml/datasets/Student+Performance"

#Relevant packages and libraries 
library(tidyverse)
library(dplyr)

# Task 1 -----------------------------------------------------------------------

# read in data 

student_mat <- read.csv()

student_por <- 


# Task 2 -----------------------------------------------------------------------

# Task 3 -----------------------------------------------------------------------

# Task 4 -----------------------------------------------------------------------

# Task 5 -----------------------------------------------------------------------


#Create a new R script with RStudio. Write your name, date and a one sentence file description as a comment on the top of the script (include a reference to the data source). Save the script as 'create_alc.R' in the ‘data’ folder of your project. Complete the rest of the steps in that script.
#
#Read both student-mat.csv and student-por.csv into R (from the data folder) and explore the structure and dimensions of the data. (1 point)
#
#Join the two data sets using all other variables than "failures", "paid", "absences", "G1", "G2", "G3" as (student) identifiers. Keep only the students present in both data sets. Explore the structure and dimensions of the joined data. (1 point)
#
#Get rid of the duplicate records in the joined data set. Either a) copy the solution from the exercise "3.3 The if-else structure" to combine the 'duplicated' answers in the joined data, or b) write your own solution to achieve this task. (1 point)
#
#Take the average of the answers related to weekday and weekend alcohol consumption to create a new column 'alc_use' to the joined data. Then use 'alc_use' to create a new logical column 'high_use' which is TRUE for students for which 'alc_use' is greater than 2 (and FALSE otherwise). (1 point)
#
#Glimpse at the joined and modified data to make sure everything is in order. The joined data should now have 370 observations. Save the joined and modified data set to the ‘data’ folder, using for example write_csv() function (readr package, part of tidyverse). (1 point)