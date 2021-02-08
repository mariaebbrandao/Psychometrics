* Encoding: UTF-8.
*Maria Brandao-Sze

*1) Data Preparation
a. What is the sex composition of this sample?
*Response: There are 257 females and 349 males. A total of 606 individuals.

DATASET ACTIVATE DataSet1.
FREQUENCIES VARIABLES=sex
  /NTILES=4
  /STATISTICS=STDDEV VARIANCE RANGE MINIMUM MAXIMUM SEMEAN MEAN MEDIAN MODE SKEWNESS SESKEW
  /ORDER=ANALYSIS.

*b. Compute the item level frequencies

FREQUENCIES VARIABLES=q1 q2 q3 q4 q5 q6 q7 q8 q9 q10 
  /NTILES=4
  /STATISTICS=STDDEV VARIANCE RANGE MINIMUM MAXIMUM SEMEAN MEAN MEDIAN MODE SKEWNESS SESKEW
  /ORDER=ANALYSIS.

*1bi) Is missing data a substantial problem? If it is, why would it have occurred?
Response: Job knowledge test question 10 has 151 missing datas out of 606. So substancial 
It might have occurred due to item question being difficult to understand, not applicable to the respondents, might not want to disclose lack of job knowledge or fear of consequences, might have run out of time

*1bii) Are there any aberrant responses or data entry errors
Response: Looking at the minimum and maximum no number was above the range. So no aberrant responses.

*1c) Compute the total test scores

DATASET ACTIVATE DataSet1.
COMPUTE totaltestscore=SUM.1(q1,q2,q3,q4,q5,q6,q7,q8,q9,q10).
VARIABLE LABELS  totaltestscore 'totaltestscore'.
EXECUTE.

*1ci) What is the shape of the distribution of total test scores?
*Response: The shape of the distribution is skewed to the right where majority of people were aggregated on the lower scores

FREQUENCIES VARIABLES=totaltestscore
  /NTILES=4
  /STATISTICS=STDDEV VARIANCE RANGE MINIMUM MAXIMUM SEMEAN MEAN MEDIAN MODE SKEWNESS SESKEW
  /HISTOGRAM NORMAL
  /ORDER=ANALYSIS.

*2) Descriptive statistics
2a) Compute the item and total score mean, median, mode, and standard deviation

FREQUENCIES VARIABLES=totaltestscore q1 q2 q3 q4 q5 q6 q7 q8 q9 q10
  /STATISTICS=STDDEV MINIMUM MAXIMUM MEAN MEDIAN MODE
  /HISTOGRAM NORMAL
  /ORDER=ANALYSIS.

EXAMINE VARIABLES=totaltestscore
  /PLOT BOXPLOT STEMLEAF
  /COMPARE GROUPS
  /STATISTICS DESCRIPTIVES
  /CINTERVAL 95
  /MISSING LISTWISE
  /NOTOTAL.

*2ai) Was this a hard test for this sample? Which item was the most difficult? Which was the easiest?
*Response: This was a hard test because the distribution is skewed to the right, where majority of the individuals scored low. The median was 3 when the maximun could have been a score of 10.
*The most difficult item or less answered correctly was 8 and 5. Their mean was the smallest and frequency of  incorrects were 546 and 548 respectively. 
*The easiest was question number 9. The mean was .63 and the one most answered correctly, 384

*2b)Compute the item discrimination indices using the point biserial and biserial correlation

RELIABILITY
  /VARIABLES=q1 q2 q3 q4 q5 q6 q7 q8 q9 q10
  /SCALE('ALL VARIABLES') ALL
  /MODEL=ALPHA
  /SUMMARY=TOTAL.

*2bi) Which item is the most discriminating? Which is the least?
*Response: Most discriminating is item 10, least discriminating is item 9 

*2c)How well are the items related to one another? 
Response: Most questions are related to each other with the exception of question 9. 

CORRELATIONS
  /VARIABLES=q1 q2 q3 q4 q5 q6 q7 q10 q9 q8 totaltestscore
  /PRINT=TWOTAIL NOSIG
  /MISSING=PAIRWISE.

*3) Are there difference between men and women in the total test score? 
Response: Yes, there is a difference between males and females

T-TEST GROUPS=sex(0 1)
  /MISSING=ANALYSIS
  /VARIABLES=totaltestscore
  /CRITERIA=CI(.95).

*Q11-Q18

*1)  Data Preparation
*1a) Compute the item level frequencies

FREQUENCIES VARIABLES=q11 q12 q13 q14 q15 q16 q17 q18
  /STATISTICS=STDDEV VARIANCE RANGE MINIMUM MAXIMUM MEAN MEDIAN MODE
  /HISTOGRAM NORMAL
  /ORDER=ANALYSIS.

*1aii) Is missing data a substantial problem? If it is, why would it have occurred? 
Response: No issue with missing data

*1aiii) Are there any aberrant responses or data entry errors? 
Response: No aberrant responses

*1b)Reverse code q18

RECODE q18 (1=5) (2=4) (3=3) (4=2) (5=1) INTO q18v2.
VARIABLE LABELS  q18v2 'q18v2'.
EXECUTE.

*1c) Compute the total self-efficacy scores

COMPUTE totalselfefficacy=MEAN(q11,q12,q13,q14,q15,q16,q17,q18v2).
EXECUTE.

*1civ) What is the shape of the distribution of total self-efficacy scores? 
*Response: Skewed to the left

FREQUENCIES VARIABLES=totalselfefficacy
  /STATISTICS=STDDEV VARIANCE RANGE MINIMUM MAXIMUM MEAN MEDIAN MODE
  /HISTOGRAM NORMAL
  /ORDER=ANALYSIS.

*2)Descriptive statistics
*2a) Compute the item and total score mean, median, mode, and standard deviation

FREQUENCIES VARIABLES=q11 q12 q13 q14 q15 q16 q17 q18v2 totalselfefficacy
  /NTILES=4
  /STATISTICS=STDDEV MEAN MEDIAN MODE
  /HISTOGRAM NORMAL
  /ORDER=ANALYSIS

*2ai) Which item was most agreeable? Which was least agreeable? 
 Response q13 most agreeable (highest mean), least agreeable q 18 (smallest mean)
 
*2b) How would you characterize the feeling of this sample?
Response - The feeling is more agreeable as it is postive skewed, more people aggregated on the higher scores, 4 and 5  

EXAMINE VARIABLES=q11 q12 q13 q14 q15 q16 q17 q18v2 totalselfefficacy
  /PLOT BOXPLOT STEMLEAF
  /COMPARE GROUPS
  /STATISTICS DESCRIPTIVES
  /CINTERVAL 95
  /MISSING LISTWISE
  /NOTOTAL.

*2c) Compute the item discrimination indices

RELIABILITY
  /VARIABLES=q11 q12 q13 q14 q15 q16 q17 q18v2
  /SCALE('ALL VARIABLES') ALL
  /MODEL=ALPHA
  /SUMMARY=TOTAL.

*2ci) Which item is the most discriminating? Which is the least?
Response: Q16 is the most discriminating and q13 is the least discriminating

*2d) How well are the items related to one another? Are they more strongly related for men or for women? 
*Response: They are well related to each other

CORRELATIONS
  /VARIABLES=totalselfefficacy q11 q12 q13 q14 q15 q16 q17 q18v2
  /PRINT=TWOTAIL NOSIG
  /MISSING=PAIRWISE.

*4) Are there any differences between men and women in their level of self-efficacy? What is the size of the effect? 
*Response: There is a significance difference between men and woman. Cohen's d effect size.777 medium to large effect size

T-TEST GROUPS=sex(0 1)
  /MISSING=ANALYSIS
  /VARIABLES=totalselfefficacy
  /CRITERIA=CI(.95).




