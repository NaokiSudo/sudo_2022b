library("ggplot2")

## make Figure 3 ##

# prepare data for Figure 3
dataC <- read.csv("country_new.csv")
dataG <- read.csv("dataG.csv")
dataCG <- dplyr::left_join(dataG, dataC, by="country")

dataCG$name <- as.character(dataCG$name)
dataCG <- subset(dataCG, !is.na(dataCG$satis))

## check correlation between average life satisfaction and rate of Latent Class 2
cor.test(dataCG$satis, dataCG$class2)

#make a figure of life satisfaction and class2
g4 <- ggplot(dataCG, aes(class2, satis), label=name) +
  geom_text(aes(label=name),hjust=0, vjust=0, size=3)+
  xlab("Composition Rate of Class2")+ylab("Life Satisfaction")+
  stat_smooth(method = "lm", se = TRUE, colour = "red")
g4


## make Table 5 ##
dataCG$GDP_2017<- dataCG$GDP_2017/10000

result1 <- lm(satis~GDP_2017, dataCG)
result2 <- lm(satis~GDP_2017+v2x_libdem, dataCG)
result3 <- lm(satis~GDP_2017+v2x_libdem+class2, dataCG)
texreg::screenreg(list(result1, result2, result3), digits = 3)