*Maria Brandao Sze - HW 1 Warm Up

* Encoding: UTF-8.

*Run descriptive statistics

DATASET ACTIVATE DataSet1.
FREQUENCIES VARIABLES=race sex age born lang ascs1 ascs2 ascs3 ascs4 ascs5 ascs6 ascs7 ascs8 ascs9 
    ascs10 ascs11 ascs12 ascs13 ascs14 ascs15 ascs16 ascs17 ascs18 ascs19 ascs20 ascs21 ascs22 ascs23 
    ascs24 ascs25 ascs26 ascs27 ascs28 ascs29 ascs30 ascs31 ascs32 ascs33 ascs34 ascs35 ascs36 ascs37 
    ascs38 ascs39 ascs40 tca1 tca2 tca3 tca4 tca5 tca6 tca7 tca8 tca9 tca10 tca11 tca12 tca13 tca14 
    tca15 tca16 tca17 tca18 tca19 tca20 tca21 tca22 tca23 tca24 tca25 ci1 ci2 ci3 ci4 ci5 ci6 ci7 ci8 
    ci9 ci10 ci11 ci12 ci13 ci14 ci15 ci16 ci17 ci18 ci19 ci20 ci21 ci22 VITQ1 VITQ2 VITQ3 VITQ4 VITQ5 
    VITQ6 VITQ7 VITQ8 VITQ9 VITQ10 VITQ11 VITQ12 VITQ13 VITQ14 VITQ15 VITQ16 VITQ17 VITQ18 VITQ19 
    VITQ20 VITQ21 VITQ22 VITQ23 VITQ24 VITQ25 VITQ26 VITQ27 VITQ28 VITQ29 VITQ30 VITQ31 VITQ32 VITQ33 
    VITQ34 VITQ35 VITQ36 VITQ37 VITQ38 VITQ39 VITQ40
  /NTILES=4
  /STATISTICS=STDDEV VARIANCE RANGE MINIMUM MAXIMUM MEAN MEDIAN MODE SKEWNESS SESKEW
  /ORDER=ANALYSIS.

*Composite of variables ascs 1-4

COMPUTE ascscomposite=MEAN(ascs1,ascs2,ascs3,ascs4).
VARIABLE LABELS  composite 'COMPUTE composite=MEAN(ascs1,ascs2,ascs3,ascs4)'.
EXECUTE.

COMPUTE tcacomposite=MEAN(tca1,tca2,tca3,tca4).
VARIABLE LABELS  composite 'COMPUTE composite=MEAN(ascs1,ascs2,ascs3,ascs4)'.
EXECUTE.

COMPUTE cicomposite=MEAN(ci1,ci2,ci3,ci4).
VARIABLE LABELS  composite 'COMPUTE composite=MEAN(ascs1,ascs2,ascs3,ascs4)'.
EXECUTE.

COMPUTE vitcomposite=MEAN(VITQ1,VITQ2,VITQ3,VITQ4).
VARIABLE LABELS  composite 'COMPUTE composite=MEAN(ascs1,ascs2,ascs3,ascs4)'.
EXECUTE.

*Descriptive on the composite variable ascs 1-4

FREQUENCIES VARIABLES= ascscomposite,  tcacomposite, cicomposite, vitcomposite
  /NTILES=4
  /STATISTICS=STDDEV VARIANCE RANGE MINIMUM MAXIMUM MEAN MEDIAN MODE SKEWNESS SESKEW
  /ORDER=ANALYSIS.

* Correlation between composites ascscomposite,  tcacomposite, cicomposite, vitcomposite
* Results -   

CORRELATIONS
  /VARIABLES=ascscomposite tcacomposite cicomposite vitcomposite
  /PRINT=TWOTAIL NOSIG
  /STATISTICS DESCRIPTIVES
  /MISSING=PAIRWISE.

* Z-scores 

DESCRIPTIVES VARIABLES=ascscomposite tcacomposite cicomposite vitcomposite
  /SAVE
  /STATISTICS=MEAN STDDEV MIN MAX SEMEAN.

* T-test 
* Recode male to 1 and female to 2

RECODE sex ('Male'=1) ('Female'=0) INTO sexvalues.
VARIABLE LABELS  sexvalues '1 male 0 female'.
EXECUTE.

T-TEST GROUPS=sexvalues(1 0)
  /MISSING=ANALYSIS
  /VARIABLES=ascscomposite tcacomposite cicomposite vitcomposite
  /CRITERIA=CI(.95).

*Result - There is a significant difference between men and women in the variables ascscomposite, tcacomposite and cicomposite, p < .05
