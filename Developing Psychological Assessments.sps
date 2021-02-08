* Encoding: UTF-8.

*Relationship between Ci and Tsa composites

DATASET ACTIVATE DataSet1.
* Chart Builder.
  
GGRAPH
  /GRAPHDATASET NAME="graphdataset" VARIABLES=tca_composite ci_composite MISSING=LISTWISE 
    REPORTMISSING=NO
  /GRAPHSPEC SOURCE=INLINE
  /FITLINE TOTAL=YES.
BEGIN GPL
  SOURCE: s=userSource(id("graphdataset"))
  DATA: tca_composite=col(source(s), name("tca_composite"))
  DATA: ci_composite=col(source(s), name("ci_composite"))
  GUIDE: axis(dim(1), label("tca_composite"))
  GUIDE: axis(dim(2), label("ci_composite"))
  GUIDE: text.title(label("Simple Scatter with Fit Line of ci_composite by tca_composite"))
  ELEMENT: point(position(tca_composite*ci_composite))
END GPL.

*Relationship between Ci and Tsa composites ascs_composite

* Chart Builder.
GGRAPH
  /GRAPHDATASET NAME="graphdataset" VARIABLES=ascs_composite ci_composite MISSING=LISTWISE 
    REPORTMISSING=NO
  /GRAPHSPEC SOURCE=INLINE
  /FITLINE TOTAL=YES.
BEGIN GPL
  SOURCE: s=userSource(id("graphdataset"))
  DATA: ascs_composite=col(source(s), name("ascs_composite"))
  DATA: ci_composite=col(source(s), name("ci_composite"))
  GUIDE: axis(dim(1), label("ascs_composite"))
  GUIDE: axis(dim(2), label("ci_composite"))
  GUIDE: text.title(label("Simple Scatter with Fit Line of ci_composite by ascs_composite"))
  ELEMENT: point(position(ascs_composite*ci_composite))
END GPL.

*Relationship between Ci and Tsa composites vitq_composite

* Chart Builder.
GGRAPH
  /GRAPHDATASET NAME="graphdataset" VARIABLES=vitq_composite ci_composite MISSING=LISTWISE 
    REPORTMISSING=NO
  /GRAPHSPEC SOURCE=INLINE
  /FITLINE TOTAL=YES.
BEGIN GPL
  SOURCE: s=userSource(id("graphdataset"))
  DATA: vitq_composite=col(source(s), name("vitq_composite"))
  DATA: ci_composite=col(source(s), name("ci_composite"))
  GUIDE: axis(dim(1), label("vitq_composite"))
  GUIDE: axis(dim(2), label("ci_composite"))
  GUIDE: text.title(label("Simple Scatter with Fit Line of ci_composite by vitq_composite"))
  ELEMENT: point(position(vitq_composite*ci_composite))
END GPL.

*Relationship between ascs and  tca composites vitq_composite

* Chart Builder.
GGRAPH
  /GRAPHDATASET NAME="graphdataset" VARIABLES=ascs_composite tca_composite MISSING=LISTWISE 
    REPORTMISSING=NO
  /GRAPHSPEC SOURCE=INLINE
  /FITLINE TOTAL=YES.
BEGIN GPL
  SOURCE: s=userSource(id("graphdataset"))
  DATA: ascs_composite=col(source(s), name("ascs_composite"))
  DATA: tca_composite=col(source(s), name("tca_composite"))
  GUIDE: axis(dim(1), label("ascs_composite"))
  GUIDE: axis(dim(2), label("tca_composite"))
  GUIDE: text.title(label("Simple Scatter with Fit Line of tca_composite by ascs_composite"))
  ELEMENT: point(position(ascs_composite*tca_composite))
END GPL.

**Relationship between ascs and  vitq composites vitq_composite


* Chart Builder.
GGRAPH
  /GRAPHDATASET NAME="graphdataset" VARIABLES=ascs_composite vitq_composite MISSING=LISTWISE 
    REPORTMISSING=NO
  /GRAPHSPEC SOURCE=INLINE
  /FITLINE TOTAL=YES.
BEGIN GPL
  SOURCE: s=userSource(id("graphdataset"))
  DATA: ascs_composite=col(source(s), name("ascs_composite"))
  DATA: vitq_composite=col(source(s), name("vitq_composite"))
  GUIDE: axis(dim(1), label("ascs_composite"))
  GUIDE: axis(dim(2), label("vitq_composite"))
  GUIDE: text.title(label("Simple Scatter with Fit Line of vitq_composite by ascs_composite"))
  ELEMENT: point(position(ascs_composite*vitq_composite))
END GPL.

*Outliers - exploer command


EXAMINE VARIABLES=ci_composite 
  /PLOT BOXPLOT STEMLEAF
  /COMPARE GROUPS
  /STATISTICS DESCRIPTIVES EXTREME
  /CINTERVAL 95
  /MISSING LISTWISE
  /NOTOTAL.

EXAMINE VARIABLES= tca_composite 
  /PLOT BOXPLOT STEMLEAF
  /COMPARE GROUPS
  /STATISTICS DESCRIPTIVES EXTREME
  /CINTERVAL 95
  /MISSING LISTWISE
  /NOTOTAL.

EXAMINE VARIABLES= ascs_composite 
  /PLOT BOXPLOT STEMLEAF
  /COMPARE GROUPS
  /STATISTICS DESCRIPTIVES EXTREME
  /CINTERVAL 95
  /MISSING LISTWISE
  /NOTOTAL.

EXAMINE VARIABLES=vitq_composite
  /PLOT BOXPLOT STEMLEAF
  /COMPARE GROUPS
  /STATISTICS DESCRIPTIVES EXTREME
  /CINTERVAL 95
  /MISSING LISTWISE
  /NOTOTAL.

*Operationalizing knowledge of I/O - able to observe and measure employee behavior at the workspace in order to provide insight on ways to improve employee productivity, engagement  and well being.  

*Test plan - Utilize Virtual Reality Performance Assessment which contains adaptive and interactive virtual scenarios to measure test taker understanding and aptitude of KSAOs needed to be an I/O Psychologist professional. KSAOs- methods to observe, collect, analyze, and present data.      
