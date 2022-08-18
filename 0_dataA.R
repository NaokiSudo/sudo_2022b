# read the original dataset
data1 <- read.csv("file of EVS2017")

#prepare variables
satis <- data1$v39 #life satisfaction
country <- data1$country #country ID
age <- data1$age #respondent's age
female <- data1$v225-1 #sex (female=1, male=0)

level_income <- 3-data1$v66
housing <- 3-data1$v67
friends_m <- 3-data1$v70

for (i in 1:nrow(data1)) {
if(level_income[i] > 3){level_income[i] <- NA}else{}
if(housing[i] > 3){housing[i] <- NA}else{}
if(friends_m[i] > 3){friends_m[i] <- NA}else{}
}

data0 <- data.frame(Id=1:nrow(data1), married=NA, widowed=NA, unmarried=NA, marr_missing=NA,
                    lower=NA, medium=NA, higher=NA, edu_missing=NA,
                    fulltime=NA, parttime=NA, selfemployed=NA, unemployed=NA, nopaid=NA, job_missing=NA,
                    uw=NA, lw=NA, blue=NA, occu_missing=NA,
                    income=NA, income_missing=NA)

for (i in 1:nrow(data1)){
if(data1$v234[i]==1 | data1$v234[i]==2){data0$married[i]=1}else{data0$married[i]=0}
if(data1$v234[i]==3 | data1$v234[i]==4 |data1$v234[i]==5){
  data0$widowed[i]=1}else{data0$widowed[i]=0}  
if(data1$v234[i]==6){data0$unmarried[i]=1}else{data0$unmarried[i]=0}  
if(data1$v234[i]<=0){data0$marr_missing[i]=1}else{data0$marr_missing[i]=0}  
  
if(data1$v243_r[i]==1){data0$lower[i]=1}else{data0$lower[i]=0}
if(data1$v243_r[i]==2){data0$medium[i]=1}else{data0$medium[i]=0}
if(data1$v243_r[i]==3){data0$higher[i]=1}else{data0$higher[i]=0}
if(data1$v243_r[i]==66|data1$v243_r[i]<=0){data0$edu_missing[i]=1}else{data0$edu_missing[i]=0}
  
if(data1$v244[i]==1){data0$fulltime[i]=1}else{data0$fulltime[i]=0}
if(data1$v244[i]==2){data0$parttime[i]=1}else{data0$parttime[i]=0}
if(data1$v244[i]==3){data0$selfemployed[i]=1}else{data0$selfemployed[i]=0}
if(data1$v244[i]>=4 & data1$v244[i]<=7 | data1$v244[i]==9){data0$nopaid[i]=1}else{data0$nopaid[i]=0}
if(data1$v244[i]==8){data0$unemployed[i]=1}else{data0$unemployed[i]=0}
if(data1$v244[i]>=10|data1$v244[i]<=0){data0$job_missing[i]=1}else{data0$job_missing[i]=0}
  
if(data1$v246_ISCO_2[i]>=10 & data1$v246_ISCO_2[i]<=39 & data1$v244[i]>=1 & data1$v244[i]<=3)
  {data0$uw[i]=1}else{data0$uw[i]=0}
if(data1$v246_ISCO_2[i]>=40 & data1$v246_ISCO_2[i]<=59 & data1$v244[i]>=1 & data1$v244[i]<=3)
  {data0$lw[i]=1}else{data0$lw[i]=0}
if(data1$v246_ISCO_2[i]>=60 & data1$v246_ISCO_2[i]<=96 & data1$v244[i]>=1 & data1$v244[i]<=3)
  {data0$blue[i]=1}else{data0$blue[i]=0}
if((data1$v246_ISCO_2[i]==99 | data1$v246_ISCO_2[i]<=-1) & data1$v244[i]>=1 & data1$v244[i]<=3)
  {data0$occu_missing[i]=1}else{data0$occu_missing[i]=0}
  
if(data1$v261[i]>=0){data0$income[i]=data1$v261[i]}else{data0$income[i]=0}  
if(data1$v261[i]<=0){data0$income_missing[i]=1}else{data0$income_missing[i]=0}    
}

married <- data0$married # dummy variable of marriage
widowed <- data0$widowed # dummy vaqrialbe of widowed/divorced/separated
unmarried <- data0$unmarried # dummy variable of unmarried
marr_missing <- data0$marr_missing # sign of missing for marital status 

lower <- data0$lower # dummy variable of lower education
medium <- data0$medium # dummy variable of medium education
higher <- data0$higher # dummy variable of higher education
edu_missing <- data0$edu_missing # sigy of missing for educational level

fulltime <- data0$fulltime # dummy variable of fulltime employment
parttime <- data0$parttime # dummy variable of parttime employment (less than 30h a week)
selfemployed <- data0$selfemployed # dummy variable of selfemployed
nopaid <- data0$nopaid # dummy variable of no paid employment
unemployed <- data0$unemployed # dummy variable of unemployed
job_missing <- data0$job_missing # sign of missing for employment satus

uw <- data0$uw # dummy variable of high skiiled white collar
lw <- data0$lw # dummy variable of low skilled white collar
blue <- data0$blue # dummy variable of blue collar
occu_missing <- data0$occu_missing # sign of missing for occupation

income <- data0$income # variable of standardized household income
income_missing <- data0$income_missing # sif of missing for household income

#making the data set for analysing
data2 <- data.frame(cbind(satis, country,age,female,
                          married, widowed, unmarried, marr_missing,
                          lower, medium, higher, edu_missing,
                          fulltime,parttime, selfemployed, nopaid, unemployed, job_missing,
                          uw, lw, blue,
                          income, income_missing,
                          level_income, housing, friends_m))

data2 <-subset(data2, data2$satis >=0 & data2$age >=0 & female >=0
               & marr_missing == 0 & edu_missing == 0 & job_missing == 0 
               & occu_missing == 0 & income_missing == 0)

data3 <- read.csv("country_new.csv")
data3$libdem_2017 <- data3$v2x_libdem
data3 <- dplyr::select(data3, country, GDP_2017, libdem_2017)

data4 <- dplyr::left_join(data2, data3, by="country")

write.csv(data4, "dataA.csv")
