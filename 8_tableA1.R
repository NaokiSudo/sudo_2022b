library(dplyr)

#read the code table of countries included EVS 2017

dataC <- read.csv("country_new.csv")

# read the original data of EVS 2017
data <- read.csv("file of EVS2017")

#select variables from EVS 2017
satis <- data$v39 #life satisfaction
country <- data$country #country ID
dataI <- data.frame(country, satis)
dataI <- subset(dataI, dataI$satis>=0) #exlude cases with missing values

#calcurate average life satisfaction by eacn country (N=30)
dataI <- data.frame(aggregate(satis~country, dataI,mean))

#merge average life satisfaction data and the country code table
dataCI <- dplyr::full_join(dataC, dataI)
dataCI$name <- as.character(dataCI$country_name)
dataCI <- subset(dataCI, !is.na(name))

for(i in 1:nrow(dataCI)){
 if(dataCI$name[i]=="Great Britain"){dataCI$name[i] <- "United Kingdom"}else{ }
 if(dataCI$name[i]=="Czech Republic"){dataCI$name[i] <- "Czech Rep."}else{ } 
 if(dataCI$name[i]=="Slovak Republic"){dataCI$name[i] <- "Slovakia"}else{ }
} #modify country's name to concord with the rnaturaleathdata

t_a1 <- select(dataCI, name, v2x_libdem, GDP_2017, satis)
t_a1
nrow(t_a1)

write.csv(t_a1, "t_a1.csv")
