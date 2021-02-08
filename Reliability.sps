* Encoding: UTF-8.
*1)Conduct the basic descriptive statistics and item analyses
a. Was this a hard test for this sample? Which item was the most difficult? Which was the easiest?

*the test was not hard, it was average as the means are in between .4 and .5 with the exception test a3 
*the most difficult a3 mean = . 28
*easiest b 2

DATASET ACTIVATE DataSet1.
FREQUENCIES VARIABLES=id tst_a_1 tst_a_2 tst_a_3 tst_a_4 tst_a_5 tst_b_1 tst_b_2 tst_b_3 tst_b_4 
    tst_b_5
  /STATISTICS=STDDEV VARIANCE MINIMUM MAXIMUM MEAN MEDIAN MODE
  /ORDER=ANALYSIS.


FREQUENCIES VARIABLES=retst_a1 retst_a2 retst_a3 retst_a4 retst_a5 retst_b1 retst_b2 retst_b3 
    retst_b4 retst_b5
  /STATISTICS=MINIMUM MAXIMUM MEAN MEDIAN MODE
  /ORDER=ANALYSIS.

*b)Which item is the most discriminating? Which is the least?

*Test a 
the most discriminating: a4 corrected item total correlation = .486
the least discriminating a3 corrected item total correlation  = .119

*retest a
the most discriminating: a2 corrected item total correlation = .601
the least discriminating a3 corrected item total correlation  = -.464


*Test b
the most discriminating: b2  corrected item total correlation =.418
The least discriminating: b1  corrected item total correlation =.155
*overall test b discriminates better since the corrected item total correlation are higher, though still not too high 

*retest b
the most discriminating: b1 corrected item total correlation = .621
the least discriminating b2 corrected item total correlation  = .457

RELIABILITY
  /VARIABLES=tst_a_1 tst_a_2 tst_a_3 tst_a_4 tst_a_5 tst_b_1 tst_b_2 tst_b_3 tst_b_4 tst_b_5
  /SCALE('ALL VARIABLES') ALL
  /MODEL=ALPHA
  /SUMMARY=TOTAL.

RELIABILITY
  /VARIABLES=retst_a1 retst_a2 retst_a3 retst_a4 retst_a5 retst_b1 retst_b2 retst_b3 
    retst_b4 retst_b5
  /SCALE('ALL VARIABLES') ALL
  /MODEL=ALPHA
  /SUMMARY=TOTAL.

*c) How well are the items related to one another?
not so well related, there is a low correlation between test a and test b and negative correlations with the re-test

CORRELATIONS
  /VARIABLES=tst_a_1 tst_a_2 tst_a_3 tst_a_4 tst_a_5 tst_b_1 tst_b_2 tst_b_3 tst_b_4 tst_b_5 
    retst_a1 retst_a2 retst_a3 retst_a4 retst_a5 retst_b1 retst_b2 retst_b3 retst_b4 retst_b5
  /PRINT=TWOTAIL NOSIG
  /MISSING=PAIRWISE.

*2) For each set of items, compute the total test scores

COMPUTE test_a=SUM(tst_a_1,tst_a_2,tst_a_3,tst_a_4,tst_a_5).
EXECUTE.

COMPUTE test_b=SUM(tst_b_1,tst_b_2,tst_b_3,tst_b_4,tst_b_5).
EXECUTE.

COMPUTE retest_a=SUM(retst_a1,retst_a2,retst_a3,retst_a4,retst_a5).
EXECUTE.

COMPUTE retest_b=SUM(retst_b1,retst_b2,retst_b3,retst_b4,retst_b5).
EXECUTE.

*i. What is the shape of the distribution of total test scores?
i. Compute the total score mean, median, mode, and standard deviation

EXAMINE VARIABLES=test_a test_b retest_a retest_b
  /PLOT BOXPLOT STEMLEAF HISTOGRAM
  /COMPARE GROUPS
  /STATISTICS DESCRIPTIVES
  /CINTERVAL 95
  /MISSING LISTWISE
  /NOTOTAL.

*test a is normally distributed
*test b is slightly negatively skewed as it is heavily concentrated on scores 2,3,4
*retest a is negatively skewed, most answers sits on score 4
*retest b is negatively skewed, most answers sits on score 5 

*3) Estimate the alternative form reliability with each time point
a. Interpret the result
b. Does either measure qualify as a parallel measure?

CORRELATIONS
  /VARIABLES=test_a test_b
  /PRINT=TWOTAIL NOSIG
  /MISSING=PAIRWISE.

CORRELATIONS
  /VARIABLES=retest_a retest_b
  /PRINT=TWOTAIL NOSIG
  /MISSING=PAIRWISE.

*Parallel measures correlations are .803, since coefficient is not at .9 or higher it does not qualify as parallel measure


*4) Estimate the test re-test reliability for each test form
a. Interpret the results

CORRELATIONS
  /VARIABLES=test_a retest_a
  /PRINT=TWOTAIL NOSIG
  /MISSING=PAIRWISE.

CORRELATIONS
  /VARIABLES=retest_b retest_b
  /PRINT=TWOTAIL NOSIG
  /MISSING=PAIRWISE.

*The test re-test pearson correlations for test a and retest a is low, .019
The test retest pearson correlations for test b and retest b is high, 1

*************For the jealousy items
5) Conduct the basic descriptive statistics and item analyses

FREQUENCIES VARIABLES=jealous1 jealous2 jealous3 jealous4 jealous5 jealous6
  /STATISTICS=MINIMUM MAXIMUM MEAN MEDIAN MODE
  /ORDER=ANALYSIS.
*6) Compute the total test scores
b. What is the shape of the distribution of total test scores?
a. Compute the total score mean, median, mode, and standard deviation. Interpret these data.

COMPUTE jealousycomposite=mean(jealous1, jealous2, jealous3, jealous4, jealous5, jealous6).
EXECUTE.

EXAMINE VARIABLES=jealousycomposite
  /PLOT BOXPLOT STEMLEAF HISTOGRAM
  /COMPARE GROUPS
  /STATISTICS DESCRIPTIVES EXTREME
  /CINTERVAL 95
  /MISSING LISTWISE
  /NOTOTAL.

*Distribution is positively skewed, the mean and median are 2.53 and 2.50 so scores are mostly aggregated on the lower side of spectrum, 
in addition as their values are close to each other so the present outliers are not majorly affecting the skew of the data
Interpretation was this measure is that majority of people in this sample don't consider themselves jealous

*7) How many factors underlie these scores?

FACTOR
  /VARIABLES race jealous1 jealous2 jealous3 jealous4 jealous5 jealous6
  /MISSING LISTWISE 
  /ANALYSIS race jealous1 jealous2 jealous3 jealous4 jealous5 jealous6
  /PRINT INITIAL KMO EXTRACTION
  /FORMAT BLANK(.20)
  /PLOT EIGEN
  /CRITERIA MINEIGEN(1) ITERATE(25)
  /EXTRACTION PAF
  /ROTATION NOROTATE
  /METHOD=CORRELATION.

*Kaiser analysis there are 2 factors as eigen values are >1
*Scree plot there are 5 values as graph only truly levels out on 6
*Parallel analysis three factors are present since mean is >1 and close to the value of .978

*rerun the factor analysis with 3 since on the scree plot that would be a similar break to  parallel analysis

FACTOR
  /VARIABLES jealous1 jealous2 jealous3 jealous4 jealous5 jealous6
  /MISSING LISTWISE 
  /ANALYSIS jealous1 jealous2 jealous3 jealous4 jealous5 jealous6
  /PRINT UNIVARIATE INITIAL KMO EXTRACTION ROTATION
  /FORMAT BLANK(.20)
  /PLOT EIGEN
  /CRITERIA FACTORS(3) ITERATE(25)
  /EXTRACTION PAF
  /CRITERIA ITERATE(25)
  /ROTATION PROMAX(4)
  /METHOD=CORRELATION.

*With rotation there only two items load onto the third factor so the number of factors would be appropriate of 2 

*8) Estimate the internal consistency
a. What is coefficient alpha?

RELIABILITY
  /VARIABLES=jealous1 jealous2 jealous3 jealous4 jealous5 jealous6
  /SCALE('ALL VARIABLES') ALL
  /MODEL=ALPHA
  /SUMMARY=TOTAL.

*cronbach's alpha is .794
*overall discrimination is of corrected item-total correlation .551 so average, it can be better
* overall difficulty is of mean 2.5 so more on the not so jealous type
*internal reliabily could be improved 

*b. Which items should you drop to improve alpha?
*Drop q4 - if my supervisor were to ...
*possibly rewrite - q5 and q6 to increase internal consistency

*c. What is the odd-even split half reliability?

COMPUTE jealousy_odd=mean(jealous1, jealous3, jealous5).
EXECUTE.
COMPUTE jealousy_even=mean(jealous2, jealous4, jealous6).
EXECUTE.

CORRELATIONS
  /VARIABLES=jealousy_odd jealousy_even
  /PRINT=TWOTAIL NOSIG
  /MISSING=PAIRWISE.

*low pearson correlation of .698, so reliability can be improved by increasing the number of questions and removing items that are not correlated and don't discriminate well

*d. If you doubled the number of items, what is your estimate of split half reliability?
it will probably improve the split half reliability since this type of reliability requires large number of items 
 







