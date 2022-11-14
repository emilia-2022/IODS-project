# author: Emilia Carson 
# date: November 14 2022 

# File to read in, clean and selected variables of interest to put into new data set
# Data file related to student learning and attitudes 
# Available at: http://www.helsinki.fi/~kvehkala/JYTmooc/JYTOPKYS3-data.txt"

# Data Wrangling 

#Relevant packages and libraries 
library(tidyverse)
library(dplyr)

# TASK 1------------------------------------------------------------------------ 

# read in data 
lrn14 <- read.table("http://www.helsinki.fi/~kvehkala/JYTmooc/JYTOPKYS3-data.txt", 
                    sep="\t", 
                    header=TRUE)

str(lrn14) # explore structure of data 
# majority of variables int, exception gender which is char

dim(lrn14) # explore dimensions of data 
# dataset has 183 rows and 60 columns

# TASK 2------------------------------------------------------------------------ 

# create columns for attitude, deep, surface, and strategic learning 

# attitude column 
lrn14$attitude <- lrn14$Attitude / 10 

# deep learning column
deep_questions <- c("D03", "D11", "D19", "D27",       # related questions
                    "D07", "D14", "D22", "D30",
                    "D06",  "D15", "D23", "D31")
lrn14$deep <- rowMeans(lrn14[, deep_questions])       # create column deep by averaging 


# surface learning column
surface_questions <- c("SU02","SU10","SU18","SU26",   # related questions 
                       "SU05","SU13","SU21","SU29",
                       "SU08","SU16","SU24","SU32")
lrn14$surf <- rowMeans(lrn14[, surface_questions])    # create column surf by averaging 

# strategic learning column
strategic_questions <- c("ST01","ST09","ST17","ST25", # related questions 
                         "ST04","ST12","ST20","ST28")
lrn14$strat<- rowMeans(lrn14[, strategic_questions])  # create column strat by averaging

# choose columns to keep
keep_columns <- c("gender",
                  "Age",
                  "attitude", 
                  "deep", 
                  "strat", 
                  "surf", 
                  "Points")

# create new dataset using 'keep_columns' 
learning2014 <- select(lrn14, one_of(keep_columns))

# convert all column names to lowercase 
names(learning2014) <- tolower(names(learning2014))

# exclude observations where exam points are zero 
learning2014 <- filter(learning2014, points > 0)

# TASK 3------------------------------------------------------------------------

getwd() # view current working directory 
setwd("C:\\Users\\Emilia\\Documents\\Uni Helsinki\\Year One\\Teaching Period 2\\Open Data Science\\IODS-project_2022\\data")

# write created dataset to csv 
write.csv(learning2014, "learning_2014.csv")

# read created dataset 
learning2014 <- read.csv("learning_2014.csv")
# check data structure and ensure correct 
str (learning2014)
head(learning2014)
