# author: Emilia Carson 
# date: December 5th 2022 

# Script to read in, clean and create new variables of interest and join into new data set

"The two data sets are related to the Human Development Index (HDI) 
and the Gender Inequality Index (GII). The data combines several indicators 
from most countries in the world."

# More information at: https://hdr.undp.org/data-center/human-development-index


# Data Wrangling 

#Relevant packages and libraries 
library(tidyverse)
library(stringr)
library(tibble)

# TASK 1------------------------------------------------------------------------

# read in data 
hd  <- read_csv("https://raw.githubusercontent.com/KimmoVehkalahti/Helsinki-Open-Data-Science/master/datasets/human_development.csv")
gii <- read_csv("https://raw.githubusercontent.com/KimmoVehkalahti/Helsinki-Open-Data-Science/master/datasets/gender_inequality.csv", 
                na = "..")

# explore structure and dimensions of the data
str(hd)
dim(hd)

str(gii)
dim(gii)

# summary of variables
summary(hd,gi)

# TASK 2------------------------------------------------------------------------

# rename variables for HDI data set 

hd <- rename(hd, HDI_Rank = "HDI Rank")
hd <- rename(hd, HDI      = "Human Development Index (HDI)")
hd <- rename(hd, Life.Exp = "Life Expectancy at Birth")
hd <- rename(hd, Edu.Exp  = "Expected Years of Education")
hd <- rename(hd, Edu.Mean = "Mean Years of Education")
hd <- rename(hd, GNI      = "Gross National Income (GNI) per Capita")
hd <- rename(hd, GNI_adj  = "GNI per Capita Rank Minus HDI Rank")

# rename variables for GII data set 

gii <- rename(gii, GII_Rank  = "GII Rank")
gii <- rename(gii, Country   = "Country")
gii <- rename(gii, GII       = "Gender Inequality Index (GII)")
gii <- rename(gii, Mat.Mor   = "Maternal Mortality Ratio")
gii <- rename(gii, Ado.Birth = "Adolescent Birth Rate")
gii <- rename(gii, Parli.F   = "Percent Representation in Parliament")
gii <- rename(gii, Edu2.F    = "Population with Secondary Education (Female)")
gii <- rename(gii, Edu2.M    = "Population with Secondary Education (Male)")
gii <- rename(gii, Labo.F    = "Labour Force Participation Rate (Female)")
gii <- rename(gii, Labo.M    = "Labour Force Participation Rate (Male)")

# TASK 3------------------------------------------------------------------------

# variable of ratio of Female and Male populations with secondary education in each country
gii$Edu2.FM = gii$Edu2.F/gii$Edu2.M
# variable of ratio of Male and Female populations with secondary education in each country
gii$Edu2.MF = gii$Edu2.M/gii$Edu2.F

# variable for ratio if female and male population in the labour force 
gii$Labo.FM = gii$Labo.F/gii$Labo.M 

# TASK 4------------------------------------------------------------------------

# join together the two data sets 
human <- inner_join(hd, gii, by = "Country")

# TASK 5------------------------------------------------------------------------

# remove the commas from GNI and print out a numeric version of it
str_replace(human$GNI, pattern=",", replace ="") %>% as.numeric()

# TASK 6------------------------------------------------------------------------

# remove uneeded variables 
human_small <- human[ , ! names(human) %in% c("HDI_Rank","HDI", "Edu.Mean",
                                              "GNI.Minus.Rank","GII_Rank","GII",
                                              "Edu2.F","Edu2.M","Edu2.MF",
                                              "Labo.M", "GNI_adj", "Labo.F")]

# TASK 7------------------------------------------------------------------------

# remove all rows with missing values 
human_small <- filter(human_small, complete.cases(human_small))

# TASK 8------------------------------------------------------------------------

# remove observations related to regions 
last <- nrow(human_small) - 7

# TASK 9------------------------------------------------------------------------

# choose everything until the last 7 observations
human_clean <- human_small[1:last,]

# add countries as rownames
human_clean <- column_to_rownames(human_clean, var = 'Country')

# save data (RDS format to keep row names)
saveRDS(human_clean, "human.rds")
