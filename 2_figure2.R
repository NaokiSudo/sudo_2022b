# read the original dataset
data2 <- read.csv("dataA.csv")

#make Figure2
library(ggplot2)

g2 <- ggplot(data2, aes(satis))+
  geom_histogram(binwidth = 1.0, color="black", fill="blue", alpha=0.6)+  
  xlab("Life Satisfaction")+ylab("Count")+
  scale_x_continuous(breaks = seq(0.0, 11.0, by = 1.0))
g2

nrow(data2)