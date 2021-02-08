* Encoding: UTF-8.

*********************1)Examine and interpret the demographic characteristics of the sample and the other measures.*********************

*** Run frequency to have a look a data to understand what needs to be done

FREQUENCIES VARIABLES=id q1 q2 q3 q4 q5 q6 q7 q8 Gender SelfConfidence Persistence
  /NTILES=4
  /STATISTICS=STDDEV MINIMUM MAXIMUM MEAN MEDIAN MODE
  /ORDER=ANALYSIS.

*There is impermissible data -q2, q4, q5, q7, gender, self-confidence, and persistence in minutes
*Missing data in self-efficacy questions not much of a concern since it ranges from  .5%-3.5% 
*Q3, has 21 missing which is the highest missing number, it corresponds to 35% of the data
*Persistence measure one outlier of 10,000 minutes, respondents 7739 - Remove? Persistent time was of 10,000, no self-confidence no results, and self-efficacy all 5 might be an indicator of not taking very seriously 

*** Filter out the 10,000. Chose 14 since last two numbers on sequence is 13.28 & 13.55

USE ALL.
COMPUTE filter_$=(Persistence <= 14).
VARIABLE LABELS filter_$ 'Persistence <= 14(FILTER)'.
VALUE LABELS filter_$ 0 'Not Selected' 1 'Selected'.
FORMATS filter_$ (f1.0).
FILTER BY filter_$.
EXECUTE.

*** Recoding impermissible data on self-efficacy. Minimum and maximum should be 1-5

RECODE q1 q2 q3 q4 q5 q6 q7 q8 (1=1) (2=2) (3=3) (4=4) (5=5) (ELSE=SYSMIS) INTO q1_new q2_new 
    q3_new q4_new q5_new q6_new q7_new q8_new.
VARIABLE LABELS  q1_new 'Q1_I will be able to achieve most of the goals that I have set for myself' 
    /q2_new 'Q2_When facing difficult tasks, I am certain that I will accomplish them' /q3_new 
    'Q3_In general, I think that I can obtain outcomes that are important to me' /q4_new 'Q4_I '+
    'believe I can succeed at most any endeavor to which I set my mind' /q5_new 'Q5_I will be able '+
    'to succesfully overcome many challenges' /q6_new 'Q6_I am confident that I can perform '+
    'effctively on my different tasks' /q7_new 'Q7_Compared to other people, I can do most tasks '+
    'very well' /q8_new 'Q8_Even when things are tough, I can perform quite well'.
EXECUTE.

*** Recode gender to 0 male and 1 female

RECODE Gender (0=0) (1=1) (ELSE=SYSMIS) INTO gender_new.
VARIABLE LABELS  gender_new 'Gender 0_male, 1_female'.
EXECUTE.

*** Check to see if recode worked

FREQUENCIES VARIABLES=q1_new q2_new q3_new q4_new q5_new q6_new q7_new q8_new gender_new 
    SelfConfidence Persistence
  /STATISTICS=STDDEV MINIMUM MAXIMUM MEAN MEDIAN MODE
  /ORDER=ANALYSIS.

*** Run explore to get a sense of distribution 

EXAMINE VARIABLES=q1_new q2_new q3_new q4_new q5_new q6_new q7_new q8_new gender_new 
    SelfConfidence Persistence
  /PLOT BOXPLOT STEMLEAF HISTOGRAM
  /COMPARE GROUPS
  /STATISTICS DESCRIPTIVES
  /CINTERVAL 95
  /MISSING LISTWISE
  /NOTOTAL.

*Self-efficacy
*Individual items 1-8 for self-efficacy are negatively skewed, therefore most of the answers are on the agreeable side
*Outliers:   
q1 - 21 extremes =<2 - no restriction of range
q2 - There is restriction of range as 1 is missing
q3 -  68 extremes =<2 no restriction of range
q4 - 21 extremes  =<2 no restriction of range
q5 - 4 extremes =<1 no restriction of range
q6 - 22 are =<2 don't believe that they are confident in performing effectively on many different tasks, 90 >= 5 are highly confident, 296 choose 4 agree
So 72% of participants score themselves highly on being confident to perform effectively 4-5
q7- 2 extremes =<1 no restriction of range
q8 - 4 extremes = =<1 no restriction of range

*Self-confidence
No restriction of range
Mean and median are more or less a like 3.55 and 3.64 if there are outliers they are not affecting the average 
No outliers
Majority of the respondent are pretty self-confident as they score between 3-5, 70% of respondents
 
*Persistence in minutes
Between 6-9 minutes a large amount of people
Outliers- 2 extremes >= 13.3, one being 10,000 (respondent 7739) 

*********************2) Perform a CTT item analysis on the item data. Interpret the results.*********************

*** Explore the items and total score mean, median, mode, and standard deviation

FREQUENCIES VARIABLES=q1_new q2_new q3_new q4_new q5_new q6_new q7_new q8_new
  /STATISTICS=STDDEV MEAN MEDIAN MODE
  /ORDER=ANALYSIS.

*Item Difficulty:
*Item with the highest mean in terms of self-efficacy was question 3 (In general, I think that I can obtain outcomes that are important to me)
*Item with the lowest mean in terms of self-efficacy was question 8 (Even when things are tough, I can perform quite well.) - Lets consider the way this question was written, and when looking at reliability and validity. 
*Question 2 and 8 are similar but with different words and different mean, do the words affect measuring of self?
*Even the lowest mean is pretty high, out of 5, 3.61 is a high mean, meaning more agreeableness   

*** Look to see if the items discriminate wells 

RELIABILITY
  /VARIABLES=q1_new q2_new q3_new q4_new q5_new q6_new q7_new q8_new
  /SCALE('ALL VARIABLES') ALL
  /MODEL=ALPHA
  /SUMMARY=TOTAL.

*Item Discrimination:
 *All items have a corrected item total correlation above .5, so it discrimate welll 
 *The item with the highest corrected item-total correlation is question 6 
 *The item with the least corrected item-total correlation is question 3 
 
*********************3) Create a self-efficacy score and conduct an item analysis on the measure.*********************

* Create composite of self-efficacy

COMPUTE selfefficaccycomposite=MEAN(q1_new,q2_new,q3_new,q4_new,q5_new,q6_new,q7_new,q8_new).
VARIABLE LABELS  selfefficaccycomposite 'Self Efficacy Composite'.
EXECUTE.

*Look at self-efficacy frequency and distribution

FREQUENCIES VARIABLES=selfefficaccycomposite
  /NTILES=4
  /STATISTICS=STDDEV MINIMUM MAXIMUM MEAN MEDIAN MODE
  /ORDER=ANALYSIS.

EXAMINE VARIABLES=selfefficaccycomposite
  /PLOT BOXPLOT STEMLEAF HISTOGRAM
  /COMPARE GROUPS
  /STATISTICS DESCRIPTIVES
  /CINTERVAL 95
  /MISSING LISTWISE
  /NOTOTAL.

*9 extremes for =<2.6 - almost having restriction of range since only 9 people selected below 2.6
majority are grouped on the agreeableness side, from 3-5 pretty high scores

*********************Using gender to look at items*********************

SORT CASES  BY gender_new.
SPLIT FILE LAYERED BY gender_new.

*** Explore if items are differentially difficult 

FREQUENCIES VARIABLES=SelfConfidence Persistence q1_new q2_new q3_new q4_new q5_new q6_new q7_new 
    q8_new selfefficaccycomposite
  /STATISTICS=STDDEV MINIMUM MAXIMUM MEAN MEDIAN MODE
  /HISTOGRAM
  /ORDER=ANALYSIS.

*** Explore if items are differentially discriminating 

RELIABILITY
  /VARIABLES=q1_new q2_new q3_new q4_new q5_new q6_new q7_new q8_new
  /SCALE('ALL VARIABLES') ALL
  /MODEL=ALPHA
  /SUMMARY=TOTAL.

*** Explore at correlation of self-efficacy and self-confidence by gender

CORRELATIONS
  /VARIABLES=selfefficaccycomposite SelfConfidence
  /PRINT=TWOTAIL NOSIG
  /MISSING=PAIRWISE.

SPLIT FILE OFF.

** Gender comments:
*Difficulty indexes
*For self confidence, mean scores for Males (3.62) females (3.53)
*For persistence, mean scores for Males (8.08) Females (7.97)
*For self efficacy composite score Males (M=3.99) Females (M=3.86)
*On individual items, mean scores for males are => 4 for 5 out of 8 questions whereas, mean scores for females
are =>4 for 3 out of 8 questions. 
*Q7 and Q8 females scores between 3 and 4
*Based upon the above information, it would be interesting to look at t-test

*Discrimination indices
*Item discriminates well for male and female, with slight exception of:
*Item 3 - male = .56, female = .49
*Item 1 - male = .495, female =.538 

*Correlation
*Correlation between Self-Efficacy and Self-Confidence is weakly and positively correlated, significant (p<.001) values, 
*Self-efficacy and self-confidence don't work too well for females, Female .27 as opposed to Male .32

*Correlation between ability and job performance is higher, the pearson correlation for whites is .42, positive and significant (p<.001)
which means the test works better for whites

*** Run t-test for mean differences

T-TEST GROUPS=gender_new(0 1)
  /MISSING=ANALYSIS
  /VARIABLES=SelfConfidence Persistence 
  /CRITERIA=CI(.95).

*No mean differences for self-confidence and persistence in time

*********************4)What is the evidence of reliability of the scores on the measure?*********************

*** Look at Cronbach's alpha

RELIABILITY
  /VARIABLES=q1_new q2_new q3_new q4_new q5_new q6_new q7_new q8_new
  /SCALE('ALL VARIABLES') ALL
  /MODEL=ALPHA
  /SUMMARY=TOTAL.

*Cronbach's alpha is very good (.845). Deleting any item would decrease its value

*** Look at split-half method

RELIABILITY
  /VARIABLES=q1_new q2_new q3_new q4_new q5_new q6_new q7_new q8_new
  /SCALE('ALL VARIABLES') ALL
  /MODEL=SPLIT
  /STATISTICS=SCALE.

*Spearment-Brown coefficient (.761) denotes a strong relationship

*********************5) Is the measure unidimensional?*********************

*** Look at correlations

CORRELATIONS
  /VARIABLES=q1_new q2_new q3_new q4_new q5_new q6_new q7_new q8_new
  /PRINT=TWOTAIL NOSIG
  /MISSING=PAIRWISE.

*Most question are highly correlated with exception of question 7 and 1 = .282, 7 and 3 = .270
*All questions are positively related 

 FACTOR
  /VARIABLES q1_new q2_new q3_new q4_new q5_new q6_new q7_new q8_new
  /MISSING LISTWISE 
  /ANALYSIS q1_new q2_new q3_new q4_new q5_new q6_new q7_new q8_new
  /PRINT UNIVARIATE INITIAL CORRELATION SIG KMO EXTRACTION ROTATION
  /FORMAT BLANK(.15)
  /PLOT EIGEN
  /CRITERIA MINEIGEN(1) ITERATE(25)
  /EXTRACTION PAF
  /CRITERIA ITERATE(25)
  /ROTATION PROMAX(4)
  /METHOD=CORRELATION.

*N = 574, ok 
*SD are ok 
*Commonalities output table:
*The commonality to the latent factors are mostly of 30%, with the exception of questions 5 = 50%, question 6 = 54%, and question 8 =50%

*KMO/Bartletts' is sig = thats good
*KMO and Bartlett's test is significant, meaning there is a sufficient amount of variance in the data to run a factor analysis

*Kaiser's Criterion: Eigenvalues for the first factor is greater than 1.0, the rest are less than 1.0
*Cattel's Scree Plot: Factor 1 (and 2 (the break)) is on the 'elbow' of the scree plot
*Parallel Regression: 'Real' eigenvalue was greater than the chance for Factor 1. Chance was greater than 'real' eigenvalues for the rest

*Analysis suggests that the measure is unidimensional 

*********************7) Are there mean differences between males and females on this measure?*********************

*** Run t-test for mean differences

T-TEST GROUPS=gender_new(0 1)
  /MISSING=ANALYSIS
  /VARIABLES=q1_new q2_new q3_new q4_new q5_new q6_new q7_new q8_new
  /CRITERIA=CI(.95).  

T-TEST GROUPS=gender_new(0 1)
  /MISSING=ANALYSIS
  /VARIABLES=selfefficaccycomposite
  /CRITERIA=CI(.95).

*Men, N = 226, Mean = 3.9850, SD = .54643, Std. Error Mean = .03635
*Females, N = 374, Mean = 3.8572, SD = .53297, Std. Error Mean = .02756
*Based on levene's test equal variances can be assumed, the t-test for equality of means
**Cohen's D is .237. Which is minuscule

*********************8) Score the data so that 4 and 5 become a ‘1’ and 1 and 2 become a ‘0’. The 3s should become missing.*********************

*** Recode observations with 4 and 5 to 1, 1 and 2 to 0, 3 to missing

RECODE q1_new q2_new q3_new q4_new q5_new q6_new q7_new q8_new (4=1) (5=1) (2=0)(1=0) (3=SYSMIS).
EXECUTE.

*** Compute a total score 

COMPUTE totalscore=SUM(q1_new,q2_new,q3_new,q4_new,q5_new,q6_new,q7_new,q8_new).
EXECUTE.

*********************9) Conduct a differential item functioning analysis on the rescored data.*********************

*Compute interaction variable

COMPUTE TestGenderInteraction=gender_new*totalscore.
VARIABLE LABELS  TestGenderInteraction 'TestGenderInteraction'.
EXECUTE.

**Logistic regression for items 1-8

LOGISTIC REGRESSION VARIABLES q1_new
  /METHOD=ENTER TestGenderInteraction gender_new totalscore
  /SAVE=PRED
  /PRINT=CI(95)
  /CRITERIA=PIN(0.05) POUT(0.10) ITERATE(20) CUT(0.5).

*interaction not significant, p>.05. No non-uniform dif. 

LOGISTIC REGRESSION VARIABLES q2_new
  /METHOD=ENTER TestGenderInteraction gender_new totalscore
  /SAVE=PRED
  /PRINT=CI(95)
  /CRITERIA=PIN(0.05) POUT(0.10) ITERATE(20) CUT(0.5).

*interaction not significant, p>.05. No non-uniform dif. 

LOGISTIC REGRESSION VARIABLES q3_new
  /METHOD=ENTER TestGenderInteraction gender_new totalscore
  /SAVE=PRED
  /PRINT=CI(95)
  /CRITERIA=PIN(0.05) POUT(0.10) ITERATE(20) CUT(0.5).

*interaction not significant, p>.05. No non-uniform dif. 

LOGISTIC REGRESSION VARIABLES q4_new
  /METHOD=ENTER TestGenderInteraction gender_new totalscore
  /SAVE=PRED
  /PRINT=CI(95)
  /CRITERIA=PIN(0.05) POUT(0.10) ITERATE(20) CUT(0.5).

*Q4 - Interaction is significant, p<.05. No non-uniform dif. 
*The odds of a female getting item 4 correct are 2.136 times greater than for a male

LOGISTIC REGRESSION VARIABLES q5_new
  /METHOD=ENTER TestGenderInteraction gender_new totalscore
  /SAVE=PRED
  /PRINT=CI(95)
  /CRITERIA=PIN(0.05) POUT(0.10) ITERATE(20) CUT(0.5).

*interaction not significant, p>.05. No non-uniform dif. 

LOGISTIC REGRESSION VARIABLES q6_new
  /METHOD=ENTER TestGenderInteraction gender_new totalscore
  /SAVE=PRED
  /PRINT=CI(95)
  /CRITERIA=PIN(0.05) POUT(0.10) ITERATE(20) CUT(0.5).

*interaction not significant, p>.05. No non-uniform dif. 

LOGISTIC REGRESSION VARIABLES q7_new
  /METHOD=ENTER TestGenderInteraction gender_new totalscore
  /SAVE=PRED
  /PRINT=CI(95)
  /CRITERIA=PIN(0.05) POUT(0.10) ITERATE(20) CUT(0.5).

*interaction not significant, p>.05. No non-uniform dif. 

LOGISTIC REGRESSION VARIABLES q8_new
  /METHOD=ENTER TestGenderInteraction gender_new totalscore
  /SAVE=PRED
  /PRINT=CI(95)
  /CRITERIA=PIN(0.05) POUT(0.10) ITERATE(20) CUT(0.5).

**interaction not significant, p>.05. No non-uniform dif. 

********************* Run Mantel-Haenszel for items 1-3, 5-8 *********************

*Run crosstab to get an understanding of number of females and males per item

CROSSTABS
  /TABLES=totalscore BY gender_new
  /FORMAT=AVALUE TABLES
  /CELLS=COUNT EXPECTED 
  /COUNT ROUND CELL.

*Ability 0 only have 1 male. Use rank to thicken number of responses per male on item 1

RANK VARIABLES=totalscore (A)
  /NTILES(7)
  /PRINT=YES
  /TIES=MEAN.

*Re-run crosstab to check on thickening

CROSSTABS
  /TABLES=totalscore BY Ntotalsc
  /FORMAT=AVALUE TABLES
  /CELLS=COUNT
  /COUNT ROUND CELL.

*** Run Mantel-Haenszel per item by gender and new collapsed variable 

CROSSTABS
  /TABLES=q1_new,q2_new,q3_new,q5_new,q6_new,q7_new,q8_new BY gender_new BY Ntotalsc
  /FORMAT=AVALUE TABLES
  /STATISTICS=CMH(1)
  /CELLS=COUNT  
  /COUNT ROUND CELL.

*look at test of conditional independence Mantel-Haenszel
* item 1 p>.05, test for non-uniform. No uniform Dif.
* item 2 p>.05, test for non-unifiorm. No uniform Dif.
* item 3 p>.05, test for non-unifiorm. No uniform Dif.
* item 5 p>.05, test for non-unifiorm. No uniform Dif.
* item 6 p>.05, test for non-unifiorm. No uniform Dif.
* item 7 p>.05, test for non-unifiorm. No uniform Dif.
* item 8 p>.05, test for non-unifiorm. No uniform Dif.






