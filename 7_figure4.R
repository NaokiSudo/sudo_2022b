library("ggplot2")

## make Figure 4 ##

# prepare data for Figure 4
dataC <- read.csv("country_new.csv")
dataG <- read.csv("dataG.csv")
dataCG <- dplyr::left_join(dataG, dataC, by="country")

dataCG$name <- as.character(dataCG$name)
dataCG <- subset(dataCG, !is.na(dataCG$satis))

  #prepare data framework for Figure 4
    graphD <- matrix(NA, 99, 2)

    for(i in 1:33){
     graphD[i,1] <- "Only Class1"
     graphD[i+33,1] <- "Only Class2"
     graphD[i+66,1] <- "Real"
  
     graphD[i,2] <- dataCG$mu1[i]
     graphD[i+33,2] <- dataCG$mu2[i]
     graphD[i+66,2] <- dataCG$satis[i]
    }

    graphD <- data.frame(graphD)
    colnames(graphD) <- c("Cases","Lsatis")

    graphD$Lsatis <- as.character(graphD$Lsatis)
    graphD$Lsatis <- as.numeric(graphD$Lsatis)

# make Fgiure 4
g4 <- ggplot(graphD, aes(Cases,Lsatis))
g4 <- g4 + geom_boxplot( )
g4 <- g4 + xlab(" ")+ylab("Life Satisfaction")
g4
