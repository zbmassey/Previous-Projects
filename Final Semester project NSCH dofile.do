*****FINAL STATA DOFILE FOR SEMESTER PROJECT***********************
********************ZAKREE MASSEY**********************************

*CREATED, IMPORTED, OPENED NSCH2011/2012 DATASET
*This dataset has already been cleaned and merged. 
*The varibles have already been made, renamed, and labeled. 
*The commands that follow will not include any of the data cleanup/setup
use "C:\Users\Owner\Documents\MS-Economic-Analytics\2.Applied MicroEconometrics\Semester Project\New Working Dataset (Only Varibles of Interest).dta" 

**Descriptive Statistics
 . su depresseddummy sports age sex race pov_lvl genhealth sleep unemployment_rate gsp numofactivephysicians minwage popdensity racism parentaldomesticabuse

 . asdoc su depresseddummy sports age sex race pov_lvl genhealth sleep unemployment_rate gsp numofactivephysicians minwage popdensity racism parentaldomesticabuse


**Cross-Tabs for main independent varibles
 . tab depresseddummy sports
 . asdoc tab depresseddummy sports

 **Running T-tests using the main dummy varibles for the two groups
 . ttest depresseddummy, by(sports)
 . asdoc ttest depresseddummy, by(sports)
 
 **Running simple linear regressions
. reg depresseddummy sports
. asdoc reg depresseddummy sports

**Probit estimates controlling for more independent variables (Females Only)
 . probit depresseddummy sports age sex race pov_lvl genhealth sleep unemployment_rate gsp numofactivephysicians minwage popdensity racism parentaldomesticabuse if sex == 2
 . asdoc probit depresseddummy sports age sex race pov_lvl genhealth sleep unemployment_rate gsp numofactivephysicians minwage popdensity racism parentaldomesticabuse if sex == 2

 *****************PROPENSITY SCORE MATCHING***********************
 
 . psmatch2 sports age sex race pov_lvl genhealth sleep unemployment_rate gsp numofactivephysicians minwage popdensity racism parentaldomesticabuse if sex == 2, out(depresseddummy) neighbor(1)
 . pstest

 . asdoc psmatch2 sports age sex race pov_lvl genhealth sleep unemployment_rate gsp numofactivephysicians minwage popdensity racism parentaldomesticabuse if sex == 2, out(depresseddummy) neighbor(1)
 
 . teffects psmatch (depresseddummy) (sports age sex race pov_lvl genhealth sleep unemployment_rate gsp numofactivephysicians minwage popdensity racism parentaldomesticabuse, probit) if sex == 2, atet vce(iid) nneighbor(1)
 
 . asdoc teffects psmatch (depresseddummy) (sports age sex race pov_lvl genhealth sleep unemployment_rate gsp numofactivephysicians minwage popdensity racism parentaldomesticabuse, probit) if sex == 2, atet vce(iid) nneighbor(1)
 
 
 **MH Bounds Test
 . mhbounds depresseddummy, gamma(1 (0.1) 3)
 . asdoc mhbounds depresseddummy, gamma(1 (0.1) 3)