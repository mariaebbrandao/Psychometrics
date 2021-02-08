* Encoding: UTF-8.
*Maria Brandao-Sze Homework - Differential Item Functioning Exercise

* Run frequency to check for impermissible values, missing data, skewness 

FREQUENCIES VARIABLES=sc_nat01 sc_nat02 sc_nat03 sc_nat04 sc_nat05 sc_nat06 sc_nat07 sc_nat08 
    sc_nat09 sc_nat10 sc_nat11 race2 Gender score Performance
  /NTILES=4
  /STATISTICS=STDDEV VARIANCE RANGE MINIMUM MAXIMUM MEAN MEDIAN MODE SKEWNESS SESKEW
  /HISTOGRAM NORMAL
  /ORDER=ANALYSIS.

*About 10% of scores are missing on the the indiviual scored national items. 
*There are impermessiable data on scored national items since there are additional values besides 0 and 1
*There is a majority of whites, 78% and 22% being black
*The sample is composed of 60% male and 40% female
*Job performance is slightly negative skewed with 63% of people being at the lower standads of  job performance and 40%being above average and outstanding

*recode scores to remove impermessiable scores

RECODE sc_nat01 sc_nat02 sc_nat03 sc_nat04 sc_nat05 sc_nat06 sc_nat07 sc_nat08 sc_nat09 sc_nat10 
    sc_nat11 (0=0) (1=1) (ELSE=SYSMIS) INTO sc_nat01_new sc_nat02_new sc_nat03_new sc_nat04_new 
    sc_nat05_new sc_nat06_new sc_nat07_new sc_nat08_new sc_nat09_new sc_nat10_new sc_nat11_new.
VARIABLE LABELS  sc_nat01_new 'noimperm' /sc_nat02_new 'noimperm' /sc_nat03_new 'noimperm' 
    /sc_nat04_new 'noimperm' /sc_nat05_new 'noimperm' /sc_nat06_new 'noimperm' /sc_nat07_new 'noimperm' 
    /sc_nat08_new 'noimperm' /sc_nat09_new 'noimperm' /sc_nat10_new 'noimperm' /sc_nat11_new 'noimperm'.    
EXECUTE.

*Double checking removal of impermessiable values

DESCRIPTIVES VARIABLES=sc_nat01_new sc_nat02_new sc_nat03_new sc_nat04_new sc_nat05_new 
    sc_nat06_new sc_nat07_new sc_nat08_new sc_nat09_new sc_nat10_new sc_nat11_new race2 Gender score 
    Performance
  /STATISTICS=MEAN STDDEV MIN MAX.

* 1) Compute a total score for each individual.
*Dichotomous variable (0 & 1) so use sum

COMPUTE totalscore=SUM(sc_nat01_new,sc_nat02_new,sc_nat03_new,sc_nat04_new,sc_nat05_new,
    sc_nat06_new,sc_nat07_new,sc_nat08_new,sc_nat09_new,sc_nat10_new,sc_nat11_new).
EXECUTE.

*2)Is this a hard test
*Values closer to 1 = easy, closer to 0 = hard

FREQUENCIES VARIABLES=totalscore
  /NTILES=4
  /STATISTICS=STDDEV RANGE MINIMUM MAXIMUM MEAN MEDIAN MODE SKEWNESS SESKEW
  /HISTOGRAM NORMAL
  /ORDER=ANALYSIS.

* Overall test score mean is at 5.7 and median of 6 out of 11, therefore majority, 57%, of the sample scored on the lower side of the test

FREQUENCIES VARIABLES=sc_nat01_new sc_nat02_new sc_nat03_new sc_nat04_new sc_nat05_new sc_nat06_new 
    sc_nat07_new sc_nat08_new sc_nat09_new sc_nat10_new sc_nat11_new
  /STATISTICS=STDDEV MINIMUM MAXIMUM MEAN 
  /ORDER=ANALYSIS.

* 8 of 11 items are in between .45 and .59 with the execption of items 3 with a mean of .31, item 4 with a mean of .67 and item 7 mean .76
So based on the total score 57% of people scored on the lower side 
And based on the item means, 8 of the 11 questions were at the mid point of 0 and 1 
so the test was fair, not too hard or easy, it was average

*3) Is it discriminating  
  
FREQUENCIES VARIABLES=totalscore
  /NTILES=4
  /STATISTICS=STDDEV RANGE MINIMUM MAXIMUM MEAN MEDIAN MODE SKEWNESS SESKEW
  /HISTOGRAM NORMAL
  /ORDER=ANALYSIS.


***Index of discrimination - recode items to top and bottom 25% by choosing 0 for bottom and 1 for top 25%,
new values comes from old values where 25 percentile scored 4 and 75 percentile scored 8
D= upper 25% - lower 25%
  
RECODE totalscore (Lowest thru 4=0) (8 thru Highest=1) (ELSE=SYSMIS) INTO indexdescrim.
VARIABLE LABELS  indexdescrim 'totalscorenewindexdesc'.
EXECUTE.

*Frequency is run to look at the grouping of tob and bottom 25%
33% of people scored at the bottom 25%, 28.3% of people scored at the top 28.3%, and 38.8% are missing 

FREQUENCIES VARIABLES=indexdescrim
  /NTILES=4
  /STATISTICS=STDDEV RANGE MINIMUM MAXIMUM MEAN MEDIAN MODE SKEWNESS SESKEW
  /HISTOGRAM NORMAL
  /ORDER=ANALYSIS.

*split the file by groups of top and bottom 25%

SORT CASES  BY indexdescrim.
SPLIT FILE SEPARATE BY indexdescrim.

*run frequency on top and bottom 25% groups

FREQUENCIES VARIABLES=sc_nat01_new sc_nat02_new sc_nat03_new sc_nat04_new sc_nat05_new sc_nat06_new 
    sc_nat07_new sc_nat08_new sc_nat09_new sc_nat10_new sc_nat11_new
  /NTILES=4
  /STATISTICS=STDDEV RANGE MINIMUM MAXIMUM MEAN MEDIAN MODE SKEWNESS SESKEW
  /HISTOGRAM NORMAL
  /ORDER=ANALYSIS.

*take the difference between mean of upper 25% - lower 25%  
All the values were above .36 so good to very good discrimination, little modification needed on items 2 and 3

SORT CASES  BY indexdescrim.
SPLIT FILE SEPARATE BY indexdescrim.
SPLIT FILE OFF.


***Correlation indices - This method uses all data, it does not group between top and bottom 25%

* Reliability test to get corrected item correlation 

RELIABILITY
  /VARIABLES=sc_nat01_new sc_nat02_new sc_nat03_new sc_nat04_new sc_nat05_new sc_nat06_new 
    sc_nat07_new sc_nat08_new sc_nat09_new sc_nat10_new sc_nat11_new
  /SCALE('ALL VARIABLES') ALL
  /MODEL=ALPHA
  /SUMMARY=TOTAL.

* Look at corrected item total correlation, 0= no differentiation 1 = lots of differentiation
correlation of .3 to .4 has good differentiation between high and low ability, harder to get .7 or .8  
Items 4 very good,  5 and 7-11 good differentiation
Items 1-3 & 6 low differentiation 
Since 7 out of 11 questions discriminate well, the test is good in differentiating between high and low ability test takers 
The test should improve items 1-3 & 6 

*4) Is it differentially difficult and discriminating for Black and White Examinees?

*Split file by race- black and white to investigate if the items are differentially difficult and discriminating 

SORT CASES  BY race2.
SPLIT FILE SEPARATE BY race2.

RELIABILITY
  /VARIABLES=sc_nat01_new sc_nat02_new sc_nat03_new sc_nat04_new sc_nat05_new sc_nat06_new 
    sc_nat07_new sc_nat08_new sc_nat09_new sc_nat10_new sc_nat11_new
  /SCALE('ALL VARIABLES') ALL
  /MODEL=ALPHA
  /SUMMARY=TOTAL.

* Look at corrected item total correlation, 0= no differentiation 1 = lots of differentiation
Out of 11 questions only 5 are in between .3 to .4, the remaining 6 contains a corrected item-total correlation <.3
So the test is not so good at differentiating, there is poor differentiation for blacks
* 7 out of 11 questions contains a corrected item-total correlation between .3 and .4
 So the test discriminates better the differences between high vs low ability for whites

DATASET ACTIVATE DataSet1.
FREQUENCIES VARIABLES=sc_nat01_new sc_nat02_new sc_nat03_new sc_nat04_new sc_nat05_new sc_nat06_new 
    sc_nat07_new sc_nat08_new sc_nat09_new sc_nat10_new sc_nat11_new
  /NTILES=4
  /STATISTICS=MEAN
  /ORDER=ANALYSIS.

*8 of 11 items have a mean of .5 and > for whites with 6 items having a mean higher than .6,
So the test was on the easier side for whites
While for blacks 6 items were less than .4, and 3 less than .5
This makes 9 out of 11 questions either harder or average for blacks 
So the test was more difficult

*In conclusion the test is on the harder side for blacks and it does not do a good job in differentiating between high and low abilities test takers
*In conclusion the test is on the easier side for whites and it does provide better differentiation between high and low abilities test taker

SPLIT FILE OFF.

*5) Are there mean differences between Black and White examinees on the total score? What is the size of the effect?

*Run a t-test to detect mean differences between blacks and whites

T-TEST GROUPS=race2(1 0)
  /MISSING=ANALYSIS
  /VARIABLES=totalscore
  /CRITERIA=CI(.95).

*calculate cohen d to determine effect size
* There is a significant mean difference between black and white in regards to total score, p<.001
*Large effect size, Cohen d .74 

*6) Is there differential prediction?

*Run t-test to see if there are any differences between whites and blacks in regards to total test score(ability) and job performance 

T-TEST GROUPS=race2(1 0)
  /MISSING=ANALYSIS
  /VARIABLES=totalscore Performance
  /CRITERIA=CI(.95).

*There are differences in test, total score and job performance sig p<.05
 Should be concerned since there are differences between blacks and whites

*run correlation for overall correlation between totalscore(ability) and job performance

CORRELATIONS
  /VARIABLES=totalscore Performance
  /PRINT=TWOTAIL NOSIG
  /MISSING=PAIRWISE.

*High positive correlation(.38 pearson correlation) and significant, p <.001 between ability and performance
The higher the test score the higher the performance

* split file to look at correlation of ability and performance by race

SORT CASES  BY race2.
SPLIT FILE SEPARATE BY race2.

CORRELATIONS
  /VARIABLES=totalscore Performance
  /PRINT=TWOTAIL NOSIG
  /MISSING=PAIRWISE.

*Correlation between ability and job performance still has a high,positive and significant (p<.001) values, 
but the pearson correlation is a bit less .24 as opposed to .383, which means that the test doesn't work too well for blacks

*Correlation between ability and job performance is higher, the pearson correlation for whites is .42, positive and significant (p<.001)
which means the test works better for whites

SPLIT FILE OFF.     

CORRELATIONS
  /VARIABLES=totalscore Performance race2
  /PRINT=TWOTAIL NOSIG
  /MISSING=PAIRWISE.

*When looking at overall correlation between job performance, total test score and race it is interesting to notice
that there is a high correlation between job performance and total score,
and a much smaller correlation between race and job performance
which means that race doesn't explain much about job performance, though significant to the group
and highly significant to total score
though all are significant p<.05
*all three variables correlate so they can be added to the linear regression model

*create interactio between total score and race 

COMPUTE interaction=race2 * totalscore.
EXECUTE.

CORRELATIONS
  /VARIABLES=totalscore Performance race2 interaction
  /PRINT=TWOTAIL NOSIG
  /MISSING=PAIRWISE.

*all variables correlate 

*run linear regression with correlated variables

REGRESSION
  /DESCRIPTIVES MEAN STDDEV CORR SIG N
  /MISSING LISTWISE
  /STATISTICS COEFF OUTS R ANOVA COLLIN TOL
  /CRITERIA=PIN(.05) POUT(.10)
  /NOORIGIN 
  /DEPENDENT Performance
  /METHOD=ENTER race2 totalscore interaction.

*VIF higher than 5 so multicolinearity, I will be removing race out of the equation

REGRESSION
  /DESCRIPTIVES MEAN STDDEV CORR SIG N
  /MISSING LISTWISE
  /STATISTICS COEFF OUTS R ANOVA COLLIN TOL
  /CRITERIA=PIN(.05) POUT(.10)
  /NOORIGIN 
  /DEPENDENT Performance
  /METHOD=ENTER totalscore interaction.

*VIF <5 so removed multicolinearity. Anova is significant, p<.001 - there is evidence of statistical significance 
There is differential prediction as relationship between test scores and job performance are different and dependent on the race group

* 7) Use the Mantel-Haenszel procedure to examine if there is race-based DIF on this measure. What do you conclude? If there is DIF, is the effect strong? Who does it favor?

* run frequency to understand number of missing data that will be removed from the crosstabs

FREQUENCIES VARIABLES=totalscore
  /NTILES=4
  /ORDER=ANALYSIS.

*run crosstab to get an understanding of number of blacks and whites per item

CROSSTABS
  /TABLES=totalscore BY race2
  /FORMAT=AVALUE TABLES
  /CELLS=COUNT EXPECTED 
  /COUNT ROUND CELL.

* item 11 only have 1 black. Use rank to thicken number of responses per black on item 11

RANK VARIABLES=totalscore (A)
  /NTILES(9)
  /PRINT=YES
  /TIES=MEAN.

*run crosstab with new variable to see new frequency

CROSSTABS
  /TABLES=Ntotalsc BY race2
  /FORMAT=AVALUE TABLES
  /STATISTICS=CHISQ CMH(1)
  /CELLS=COUNT EXPECTED 
  /COUNT ROUND CELL.

*run mantel-haenszel per item by race and new collapsed variable 

CROSSTABS
  /TABLES=sc_nat01_new sc_nat02_new sc_nat03_new sc_nat04_new sc_nat05_new sc_nat06_new 
    sc_nat07_new sc_nat08_new sc_nat09_new sc_nat10_new sc_nat11_new BY race2 BY Ntotalsc
  /FORMAT=AVALUE TABLES
  /STATISTICS=CMH(1)
  /CELLS=COUNT  
  /COUNT ROUND CELL.

*look at test of conditional independence
* item 1 p>.05, test for non-uniform. No uniform Dif.
* item 2 p>.05, test for non-unifiorm. No uniform Dif.
* item 3 p>.05, test for non-unifiorm. No uniform Dif.
* item 4 p>.05, test for non-unifiorm. No uniform Dif.
* item 5 p<.05, Uniform Dif. The odds of whites to get item 5 correct is less than the odds of blacks getting the item correct
* item 6 p>.05, test for non-unifiorm. No uniform Dif.
* item 7 p<.05, Uniform Dif. The odds of a white person getting the item 7 correct are 1.67 times greater than for a black person
* item 8 p>.05, test for non-unifiorm. No uniform Dif.
* item 9 p>.05, test for non-unifiorm. No uniform Dif.
* item 10 p>.05, test for non-unifiorm. No uniform Dif.
* item 11 p>.05, test for non-unifiorm. No uniform Dif.

*8)Perform a DIF analysis using logistic regression. Is your conclusion consistent with the M-H analysis?

DATASET ACTIVATE DataSet1.
LOGISTIC REGRESSION VARIABLES sc_nat01_new
  /METHOD=ENTER race2 totalscore interaction 
  /PRINT=CI(95)
  /CRITERIA=PIN(0.05) POUT(0.10) ITERATE(20) CUT(0.5).

*interaction not significant, p>.05. No non-uniform dif. 

LOGISTIC REGRESSION VARIABLES sc_nat02_new
  /METHOD=ENTER race2 totalscore interaction 
  /PRINT=CI(95)
  /CRITERIA=PIN(0.05) POUT(0.10) ITERATE(20) CUT(0.5).

*interaction is significant, p<.05. Non-uniform dif is present. The odds of a white person getting item 2 correct are 1.94 times greater than for a black person

LOGISTIC REGRESSION VARIABLES sc_nat03_new
  /METHOD=ENTER race2 totalscore interaction 
  /PRINT=CI(95)
  /CRITERIA=PIN(0.05) POUT(0.10) ITERATE(20) CUT(0.5).

*interaction not significant, p>.05. No non-uniform dif. 

LOGISTIC REGRESSION VARIABLES sc_nat04_new
  /METHOD=ENTER race2 totalscore interaction 
  /PRINT=CI(95)
  /CRITERIA=PIN(0.05) POUT(0.10) ITERATE(20) CUT(0.5).

*interaction not significant, p>.05. No non-uniform dif.  

LOGISTIC REGRESSION VARIABLES sc_nat06_new
  /METHOD=ENTER race2 totalscore interaction 
  /PRINT=CI(95)
  /CRITERIA=PIN(0.05) POUT(0.10) ITERATE(20) CUT(0.5).

*interaction not significant, p>.05. No non-uniform dif. 

LOGISTIC REGRESSION VARIABLES sc_nat08_new
  /METHOD=ENTER race2 totalscore interaction 
  /PRINT=CI(95)
  /CRITERIA=PIN(0.05) POUT(0.10) ITERATE(20) CUT(0.5).

*interaction not significant, p>.05. No non-uniform dif. 

LOGISTIC REGRESSION VARIABLES sc_nat09_new
  /METHOD=ENTER race2 totalscore interaction 
  /PRINT=CI(95)
  /CRITERIA=PIN(0.05) POUT(0.10) ITERATE(20) CUT(0.5).

*interaction not significant, p>.05. No non-uniform dif. 

LOGISTIC REGRESSION VARIABLES sc_nat10_new
  /METHOD=ENTER race2 totalscore interaction 
  /PRINT=CI(95)
  /CRITERIA=PIN(0.05) POUT(0.10) ITERATE(20) CUT(0.5).

*interaction is significant, p<.05. Non-uniform dif is present. The odds of a white person getting item 10 correct is less than the odds of blacks getting the item correct, exp (B) is .471

LOGISTIC REGRESSION VARIABLES sc_nat11_new
  /METHOD=ENTER race2 totalscore interaction 
  /PRINT=CI(95)
  /CRITERIA=PIN(0.05) POUT(0.10) ITERATE(20) CUT(0.5).

*interaction not significant, p>.05. No non-uniform dif. 
