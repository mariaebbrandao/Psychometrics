* Encoding: UTF-8.
*Maria Brandao-Sze


*1)What do the item level frequencies of these data indicate?
*no impermissiable
*looking at the standard deviation majority are close to 1 or above meaning good variance
*missing data not too worried about, even though I don't know what the questions stand for, missing data is on the 30s and less so not too worried
*negative skewed, majority of the mean scores 3 and above
***Nicola is asking what else

DATASET ACTIVATE DataSet1.
FREQUENCIES VARIABLES=q1 q7 q22 q33 q34 q45 q46 q47 q50 q56 q57 q59 q96 q97 q101 q102 q106 q108 
    q116 q128 q139 q151 q157 q158 q159 q163 q176 q177 q186 q204 q210 q213 q219 q231 q234 q256 q274 q290 
    q295 q296 q299
  /STATISTICS=STDDEV VARIANCE MINIMUM MAXIMUM MEAN
  /ORDER=ANALYSIS.

*2) Is missing data a substantial problem? If it is, why would it have occurred?
*not a problem with it, specially because the large missing data are towards the last questions

*3) Are there any aberrant responses or data entry errors?
assuming we are measuring a construct in a likerscale there are no aberrant data as all questions
responses range from 1-5

*4) What is the shape of the distribution of the composite scores?

COMPUTE Composite=MEAN(q1,q7,q22,q33,q34,q45,q46,q47,q50,q56,q57,q59,q96,q97,q101,q102,q106,q108,
    q116,q128,q139,q151,q157,q158,q159,q163,q176,q177,q186,q204,q213,q219,q231,q234,q256,q274,q290,q295,
    q296,q299).
EXECUTE.

FREQUENCIES VARIABLES=Composite
  /STATISTICS=STDDEV MEAN MEDIAN MODE
  /HISTOGRAM NORMAL
  /ORDER=ANALYSIS.

*Even though the histogram present a normal bell curve, majority of the responses do lie between 3 to 5 which makes it be negative skewed

*5) Compute the item and total score mean, median, mode, and standard deviation
a. Was this a “hard” assessment for this sample? Which item demonstrated the highest mean? Which was the lowest? 
*Not too "hard" since the mean, 3.73. Most of the responses were in the agreeable side
*Q47 highest mean
*Q290 lowest mean 

EXAMINE VARIABLES=Composite
  /PLOT BOXPLOT STEMLEAF HISTOGRAM
  /COMPARE GROUPS
  /STATISTICS DESCRIPTIVES
  /CINTERVAL 95
  /MISSING LISTWISE
  /NOTOTAL.

*6. Which item is the most discriminating? Which is the least?

RELIABILITY
  /VARIABLES=q1 q7 q22 q33 q34 q45 q46 q47 q50 q56 q57 q59 q96 q97 q101 q102 q106 q108 q116 q128 
    q139 q151 q157 q158 q159 q163 q176 q177 q186 q204 q210 q213 q219 q231 q234 q256 q274 q290 q295 q296 
    q299
  /SCALE('ALL VARIABLES') ALL
  /MODEL=ALPHA
  /STATISTICS=SCALE
  /SUMMARY=TOTAL.

*Q102 is the most discriminating
*Q33 is the least discriminating

*7. How well are the items related to one another?

CORRELATIONS
  /VARIABLES=q1 q7 q22 q33 q34 q45 q46 q47 q50 q56 q57 q59 q96 q97 q101 q102 q106 q108 q116 q128 
    q139 q151 q157 q158 q159 q163 q176 q177 q186 q204 q210 q213 q219 q231 q234 q256 q274 q290 q295 q296 
    q299
  /PRINT=TWOTAIL NOSIG
  /MISSING=PAIRWISE.

* all questions are statiscally significant so they are correlated to each other, many have a weak correlation as they have a pearson correlation of .1,, and 
some have a moderate peason correlation of .3

*8. How many factors exist in the data? Explain your justification for this determination.

FACTOR
  /VARIABLES q1 q7 q22 q33 q34 q45 q46 q47 q50 q56 q57 q59 q96 q97 q101 q102 q106 q108 q116 q128 
    q139 q151 q157 q158 q159 q163 q176 q177 q186 q204 q210 q213 q219 q231 q234 q256 q274 q290 q295 q296 
    q299
  /MISSING LISTWISE 
  /ANALYSIS q1 q7 q22 q33 q34 q45 q46 q47 q50 q56 q57 q59 q96 q97 q101 q102 q106 q108 q116 q128 
    q139 q151 q157 q158 q159 q163 q176 q177 q186 q204 q210 q213 q219 q231 q234 q256 q274 q290 q295 q296 
    q299
  /PRINT UNIVARIATE INITIAL KMO EXTRACTION
  /FORMAT BLANK(.15)
  /PLOT EIGEN
  /CRITERIA MINEIGEN(1) ITERATE(25)
  /EXTRACTION PAF
  /ROTATION NOROTATE
  /METHOD=CORRELATION.

*There are at least 5 factors based on Kaiser's criterion and the scree plot. To look further a parallel analysis was conducted in  R to confirm the 5 factors 

*9. Is the theoretical structure of this trait replicated?
At first the structure looked like there was crossloading, but once rotation was applied and excel was used to sort and organize the structures it took a simple structure 
format which determines that the assessment is testing for 5 factors which can be replicated

DATASET ACTIVATE DataSet1.
FACTOR
  /VARIABLES q1 q7 q22 q33 q34 q45 q46 q47 q50 q56 q57 q59 q96 q97 q101 q102 q106 q108 q116 q128 
    q139 q151 q157 q158 q159 q163 q176 q177 q186 q204 q210 q213 q219 q231 q234 q256 q274 q290 q295 q296 
    q299 Composite
  /MISSING LISTWISE 
  /ANALYSIS q1 q7 q22 q33 q34 q45 q46 q47 q50 q56 q57 q59 q96 q97 q101 q102 q106 q108 q116 q128 
    q139 q151 q157 q158 q159 q163 q176 q177 q186 q204 q210 q213 q219 q231 q234 q256 q274 q290 q295 q296 
    q299 Composite
  /PRINT UNIVARIATE INITIAL KMO EXTRACTION ROTATION
  /FORMAT BLANK(.15)
  /PLOT EIGEN
  /CRITERIA FACTORS(5) ITERATE(25)
  /EXTRACTION PAF
  /CRITERIA ITERATE(25)
  /ROTATION PROMAX(4)
  /METHOD=CORRELATION.
