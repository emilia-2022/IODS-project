# author: Emilia Carson 
# date: November 27 2022 

# Script to read in, clean and create new variables of interest and join into new data set

"The two data sets are related to the Human Development Index (HDI) 
and the Gender Inequality Index (GII). The data combines several indicators 
from most countries in the world."

# More information at: https://hdr.undp.org/data-center/human-development-index


# Data Wrangling 

#Relevant packages and libraries 
library(tidyverse)

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

# TASK 4------------------------------------------------------------------------

# join together the two data sets 
human <- inner_join(hd, gii, by = "Country")
