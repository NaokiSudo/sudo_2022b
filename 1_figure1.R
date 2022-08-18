library("ggplot2")
library("sf")
library("rnaturalearth")
library("rnaturalearthdata")

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

#pepare a world map
world <- ne_countries(scale = "medium", returnclass = "sf")
world <- dplyr::full_join(world, dataCI, by = "name")

#make Figure 1
g1 <- ggplot(data = world) +
  geom_sf(aes(fill = satis), color="black") +
  scale_fill_viridis_c(option = "C", na.value = "white")+
  guides(fill=guide_colorbar(title=NULL))+
  coord_sf(xlim = c(-25, 55), ylim = c(35, 75))
g1

nrow(dataCI)
