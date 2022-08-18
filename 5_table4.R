## descriptive statistics (by each latent class) <- Table 4 ##
library(haven)
library(dplyr)

data3 <- read_dta("dataY.dta")  # Latent Class1
data4 <- read_dta("dataX.dta")  # Latent Class2

data3$level_income <- as.numeric(data3$level_income)
data3$housing <- as.numeric(data3$housing)
data3$friends_m <- as.numeric(data3$friends_m)

data4$level_income <- as.numeric(data4$level_income)
data4$housing <- as.numeric(data4$housing)
data4$friends_m <- as.numeric(data4$friends_m)


# select variables used in the analyses
dataT3 <- dplyr::select(data3, satis, level_income, housing, friends_m)
dataT4 <- dplyr::select(data4, satis, level_income, housing, friends_m)

library(psych)

describe(dataT3)[,c("n","mean","sd","min","max")] # <- Table 4 left
describe(dataT4)[,c("n","mean","sd","min","max")] # <- Table 4 right

t.test(dataT3$satis, dataT4$satis, var.equal = F, paired = F)
t.test(dataT3$level_income, dataT4$level_income, var.equal = F, paired = F)
t.test(dataT3$housing, dataT4$housing, var.equal = F, paired = F)
t.test(dataT3$friends_m, dataT4$friends_m, var.equal = F, paired = F)

## make a data set for Figure 3 and 4 ## 
data3$class1 <- 1
data3$class2 <- 0
data4$class1 <- 0
data4$class2 <- 1

dataG1 <- rbind(data3, data4)

dataG2 <- group_by(dataG1, country)

# aggregate values by country
dataG <- data.frame(
  summarise(dataG2, 
          country=mean(country),satis=mean(satis), 
          mu1=mean(mu1), mu2=mean(mu2),
          class1=mean(class1), class2=mean(class2))
)

# make data set for Figure 3 and 4
write.csv(dataG, "dataG.csv")
