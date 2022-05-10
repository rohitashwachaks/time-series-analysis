** Napa Valley Winery Forecast of SALES (log scale) **;
** This program is a tweaked version that preserves explanatory power with reasonable parsimony *;
** The tweaking enables satisfaction of LHIN -  see discussion below *;

data NAPA;
  input year month $ sales;
  trend = _n_;
  trend2 = trend**2;
  logSales = log(Sales);
  lagSales = lag(Sales);
  lagLogSales = lag(logSales);
  M1 = (month='Jan');
  M2 = (month='Feb');
  M3 = (month='Mar');
  M4 = (month='Apr');
  M5 = (month='May');
  M6 = (month='Jun');
  M7 = (month='Jul');
  M8 = (month='Aug');
  M9 = (month='Sep');
  M10= (month='Oct');
  M11= (month='Nov');
  M12= (month='Dec');
  month8 = (trend = 8);
  half2006 = (73 le trend le 79);  
cards;
2000    Jan 6632
2000    Feb 6534
2000    Mar 6675
2000    Apr 6692
2000    May 6984
2000    Jun 7133
2000    Jul 6385
2000    Aug 7364
2000    Sep 7171
2000    Oct 8690
2000    Nov 10299
2000    Dec 11997
2001    Jan 6979
2001    Feb 6962
2001    Mar 7606
2001    Apr 7909
2001    May 8504
2001    Jun 7977
2001    Jul 7816
2001    Aug 6520
2001    Sep 8525
2001    Oct 9510
2001    Nov 12079
2001    Dec 13746
2002    Jan 8225
2002    Feb 8164
2002    Mar 9324
2002    Apr 8820
2002    May 9313
2002    Jun 9419
2002    Jul 8700
2002    Aug 6960
2002    Sep 9091
2002    Oct 10933
2002    Nov 13117
2002    Dec 15337
2003    Jan 11267
2003    Feb 8889
2003    Mar 9612
2003    Apr 10511
2003    May 10571
2003    Jun 10644
2003    Jul 9766
2003    Aug 7672
2003    Sep 11016
2003    Oct 11802
2003    Nov 14923
2003    Dec 17460
2004    Jan 10053
2004    Feb 10807
2004    Mar 10713
2004    Apr 10731
2004    May 11344
2004    Jun 11510
2004    Jul 10725
2004    Aug 8395
2004    Sep 11983
2004    Oct 14028
2004    Nov 17202
2004    Dec 18821
2005    Jan 11098
2005    Feb 11089
2005    Mar 11730
2005    Apr 11534
2005    May 12323
2005    Jun 12067
2005    Jul 10893
2005    Aug 9137
2005    Sep 12805
2005    Oct 14612
2005    Nov 18844
2005    Dec 22207
2006    Jan 10272
2006    Feb 10602
2006    Mar 11156
2006    Apr 11602
2006    May 10791
2006    Jun 11970
2006    Jul 12269
2006    Aug 9686
2006    Sep 13442
2006    Oct 14774
2006    Nov 18460
2006    Dec 21951
2007    Jan 12287
2007    Feb 11519
2007    Mar 12767
2007    Apr 13235
2007    May 13643
2007    Jun 13552
2007    Jul 13349
2007    Aug 10240
2007    Sep 14781
2007    Oct 17123
2007    Nov 20396
2007    Dec 23609
2008    Jan 14031
2008    Feb 13109
2008    Mar 14248
2008    Apr 14468
2008    May 14250
2008    Jun 15024
2008    Jul 13837
2008    Aug 10522
2008    Sep   .
2008    Oct   .
2008    Nov   .
2008    Dec   .
RUN;
* Develop a reasonable regression model to forecast sales *;
* Use predictors suggested by features seen in the data *;
* The main visible features in plots are an uptrend, strong seasonality, and increasing variability *;
* Model in log scale to account for increasing variability *;
* Stepwise selection can find a model that has high explanatory power and reasonable parsimony *;
proc reg data=NAPA;
  model logsales = trend trend2 laglogsales M1-M12 / selection=stepwise slentry=0.05 slstay=0.05 spec dwprob;
run;
* Test selected model for validity;
proc reg data=NAPA;
  model logsales = trend trend2 M1 M2 M7 M8 M10-M12  / spec dwprob;
  output out=NAPAout p=predLogSales r=residLogSales;
run;
proc autoreg data=NAPA;
  model logsales = trend trend2 M1 M2 M7 M8 M10-M12  / reset dwprob;
run;
proc univariate data=NAPAout normal;
  var residLogSales;
RUN;
* Further scrutiny shows that there are two additional features that prevent ordinary *;
*   stepwise regression from finding a model that satisfies LHIN in addition to explanatory power and parsimony *;
* These two features are 
*  (1) Month 8 sales (Aug 2008) are significantly higher than they should be in comparison with other Augusts *;
*  (2) Spring and summer sales in 2006 are significantly depressed compared with same seasons in other years *;
* These can be modeled by indicator variables, month8 and half2006, as above *;
* These indicator variables stand for unknown causes that were specific to those times *;
* Those causes no longer affect the future of sales but prevent passage of LHIN for past asles *;
proc reg data=NAPA;
  model logsales = trend trend2 laglogsales M1-M12 month8 half2006 / selection=stepwise slentry=0.05 slstay=0.05 spec dwprob;
run;
* The selected model has 11 predictors: trend trend2 M1 M2 M7 M8 M10-M12 month8 half2006 *;
* But the last few variables contribute little in explanatory power *;
* So judgmentally drop some selected predictors in favor of parsimony *;
* The model below is successful and includes forecasts of Sep - Dec 2008 in the Forecasts dataset*;
* This version of the model is the result of considerable tweaking *;
proc reg data=NAPA;
  model logSales = trend trend2 M8-M12 month8 half2006 / spec dwprob;
  output out=NAPAout p=predLogSales r=residLogSales;
RUN;
proc autoreg data=NAPA;
  model logSales = trend trend2 M8-M12 month8 half2006 / reset dwprob;
RUN;
quit;
proc univariate data=NAPAout normal;
  var residLogSales;
RUN;
*Calculation of forecasts;
data forecasts;
  set NAPAout;
  if _n_ > 104;
  forecast = exp(predLogSales);
RUN;
* The total forecast for Sep-Dec 2008 is 76055 ;
proc means data=forecasts sum;
  var forecast;
RUN;


