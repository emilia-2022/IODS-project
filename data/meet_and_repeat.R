# author: Emilia Carson 
# date: December 12 2022 


# Script to read in, clean add new variable of interest, and pivot data to long format 

"The first data set is related to brief psychiatric rating scale (BPRS) and 40 
male subjects who were randomly assigned to recieved one of two treatments for 
eight weeks. The subjects were meausured on the BPRS prior to treatment and then 
at weekly intervals thereafter. 

The second data set is related to nutrition study conducted in rats. Three groups 
were part of the study and each group was put on a different diet. Weight was 
recorded (approximately) weekly over a nine week period." 

"Available at: 1) https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/BPRS.txt
               2) https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/rats.txt"
# Data Wrangling 

#Relevant packages and libraries 
library(tidyverse)
library(dplyr)

# TASK 1------------------------------------------------------------------------

# read in data 
bprs  <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/BPRS.txt",
                    header = TRUE, sep =" ")
rats <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/rats.txt", 
                    header = TRUE, sep = '\t')

# explore data 
names(bprs)
str(bprs)
dim(bprs)
summary(bprs)

names(rats)
str(rats)
dim(rats)
summary(rats)

# TASK 2------------------------------------------------------------------------

# convert categorical to factor
bprs$treatment <- factor(bprs$treatment)
bprs$subject   <- factor(bprs$subject)

# convert categorical to factor
rats$ID    <- factor(rats$ID)
rats$group <- factor(rats$Group)

# TASK 3------------------------------------------------------------------------

# convert to long form and add week variable 
bprs_long <-  pivot_longer(bprs, 
                           cols = -c(treatment, subject),
                           names_to = "weeks", 
                           values_to = "bprs") %>%
              mutate(week = as.integer(substr(weeks,5,5))) %>%
              arrange(weeks) 

# convert to long form and add time variable 
rats_long <- pivot_longer(rats, 
                          cols = -c(ID, group), 
                      names_to = "WD",
                      values_to = "Weight") %>% 
             mutate(Time = as.integer(substr(WD, 3,4))) %>%
             arrange(Time)
# TASK 4------------------------------------------------------------------------

# check variable names, content, structure and summary 
names(bprs_long)
glimpse(bprs_long)
str(bprs_long)
summary(bprs_long)

names(rats_long)
glimpse(rats_long)
str(rats_long)
summary(rats_long)

# write created dataset to csv 
write.csv(bprs_long, "bprs.csv", row.names = FALSE) 
write.csv(rats_long, "rats.csv", row.names = FALSE)