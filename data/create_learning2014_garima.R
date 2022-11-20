---
  title: "Open Data Sciences"
subtitle: "Data Rangling Assignment 2"
Author: "Garima Singh"
output: html_document
date: "2022-11-11"
---
  
Data1 <- read.table("http://www.helsinki.fi/~kvehkala/JYTmooc/JYTOPKYS3-data.txt", sep="\t", header=TRUE)

# Look at the dimensions of the data
dim(Data1)

# Look at the structure of the data

str(Data1)

## 2.2 Scaling variables
*gender, age, attitude, deep, stra, surf and points *
  
# divide each number in a vector
c(1,2,3,4,5) / 2

# print the "Attitude" column vector of the lrn14 data
Data1$Attitude

# divide each number in the column vector
Data1$Attitude / 10

# create column 'attitude' by scaling the column "Attitude"
Data1$Attitude <- "attitude"

## Combining variables

# Access the dplyr library
library(dplyr)

# questions related to deep, surface and strategic learning
deep_questions <- c("D03", "D11", "D19", "D27", "D07", "D14", "D22", "D30","D06",  "D15", "D23", "D31")
surface_questions <- c("SU02","SU10","SU18","SU26", "SU05","SU13","SU21","SU29","SU08","SU16","SU24","SU32")
strategic_questions <- c("ST01","ST09","ST17","ST25","ST04","ST12","ST20","ST28")

# select the columns related to deep learning 
deep_columns <- select(Data1, one_of(deep_questions))
# and create column 'deep' by averaging
Data1$deep <- rowMeans(deep_columns)

# select the columns related to surface learning 
surface_columns <- select(Data1, one_of(surface_questions))
# and create column 'surf' by averaging
Data1$surf <- rowMeans(surface_columns)

# select the columns related to strategic learning 
strategic_columns <- select(Data1, one_of(strategic_questions))
# and create column 'stra' by averaging
Data1$stra <- rowMeans(strategic_columns)

Data1 <- read.table("http://www.helsinki.fi/~kvehkala/JYTmooc/JYTOPKYS3-data.txt", sep="\t", header=TRUE)
Data1$attitude <- Data1$Attitude / 10
deep_questions <- c("D03", "D11", "D19", "D27", "D07", "D14", "D22", "D30","D06",  "D15", "D23", "D31")
Data1$deep <- rowMeans(Data1[, deep_questions])
surface_questions <- c("SU02","SU10","SU18","SU26", "SU05","SU13","SU21","SU29","SU08","SU16","SU24","SU32")
Data1$surf <- rowMeans(Data1[, surface_questions])
strategic_questions <- c("ST01","ST09","ST17","ST25","ST04","ST12","ST20","ST28")
Data1$stra <- rowMeans(Data1[, strategic_questions])

# access the dplyr library
library(dplyr)

# choose a handful of columns to keep
keep_columns <- c("gender","Age","attitude", "deep", "stra", "surf", "Points")

# select the 'keep_columns' to create a new dataset
learning2014 <- select(Data1, one_of(keep_columns))

# see the structure of the new dataset
str(learning2014)

# print out the column names of the data
colnames(learning2014)

# change the name of the second column
colnames(learning2014)[2] <- "age"

# change the name of "Points" to "points"
colnames(learning2014)[7] <- "points"

# print out the new column names of the data
colnames(learning2014)

## Excluding observations

library(dplyr)

# select male students
male_students <- filter(learning2014, gender == "M")

# select rows where points is greater than zero
learning2014 <- filter(learning2014, points > "0")

setwd("C:/Users/Aadhar/Desktop/Uni/Open Data Science/data")

install.packages("tidyverse")

write.csv(learning2014,"C:/Users/Aadhar/Desktop/Uni/Open Data Science/data/learning2014.csv", row.names = FALSE)