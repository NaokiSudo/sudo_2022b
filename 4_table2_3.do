clear

import delimited "dataA.csv"

generate gdp = gdp_2017/100000

fmm 1, vce(r): regress satis age female widowed unmarried lower higher /*
 */parttime selfemployed nopaid unemployed uw blue income gdp libdem_2017

estat lcprob
estat ic

fmm 2, vce(r): regress satis age female widowed unmarried lower higher /*
 */parttime selfemployed nopaid unemployed uw blue income gdp libdem_2017

estat lcprob
estat ic

predict mu*
predict prob1, classposteriorpr class(1)
predict prob2, classposteriorpr class(2)

preserve
drop if prob1 > prob2
summ
save dataX.dta, replace
restore

preserve
drop if prob1 <= prob2
summ
save dataY.dta, replace
restore
 
mixed satis age female widowed unmarried lower higher /*
 */parttime selfemployed nopaid unemployed uw blue income /*
 */ gdp libdem_2017 || country: , vce(r)
estat ic

