# read the original dataset
data2 <- read.csv("dataA.csv")

dataT1 <- dplyr::select(data2, satis, age, female, married, widowed,unmarried,       
                        lower, medium, higher,
                        fulltime, parttime, selfemployed, nopaid, unemployed,           
                        uw, lw, blue, income,
                        GDP_2017, libdem_2017)

#descriptive statistics (overall) <- Table 1
library(psych)

describe(dataT1)[,c("mean","sd","min","max")]
nrow(dataT1)
