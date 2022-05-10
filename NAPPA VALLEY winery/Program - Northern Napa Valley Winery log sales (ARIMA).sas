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
* Identify the input form;
proc arima data=NAPA;
   identify var=logsales(1); 
run;
proc arima data=NAPA;
   identify var=logsales(12); 
run;
proc arima data=NAPA;
   identify var=logsales(1,12); 
run;

* Estimate the autocorrelation structure;
proc arima data=NAPA;
   identify var=logsales(1,12); 
   estimate q=(1)(12) p=1;
run;
* Information criteria comparison of alternative models;
AIC -191.701 p=1
SBC -186.679 
AIC -202.267 p=(1)(12)
SBC -194.734
AIC -212.555 q=1 
SBC -207.534
AIC -221.268 q=(1)(12)
SBC -213.735
AIC -219.268 q=(1)(12) p=1
SBC -209.224 
* Forecasts of next 4 months with best model;
proc arima data=NAPA;
   identify var=logsales(1,12); 
   estimate q=(1)(12);
   forecast lead=4;
run;
*Forecasts for variable logSales ;
Obs Forecast Std Error 95% Confidence Limits 
105 9.6690 0.0706 9.5306 9.8073 
106 9.8014 0.0720 9.6604 9.9425 
107 9.9967 0.0734 9.8529 10.1405 
108 10.1490 0.0747 10.0025 10.2954 
*;
* Exponentiated to convert to original scale;
Obs Forecast Std Error 95% Confidence Limits 
105	15820	1.07315	13775	18166
106	18059	1.07466	15684	20796
107	21954	1.07616	19013	25349
108	25566	1.07756	22082	29596
* The sum of exp(forecast) = 81398 ;
data;
  input month forecast stderror cllower clupper;
  expforecast = exp(forecast);
  expstderror = exp(stderror);
  expcllower = exp(cllower);
  expclupper = exp(clupper);
cards;
105 9.6690 0.0706 9.5306 9.8073 
106 9.8014 0.0720 9.6604 9.9425 
107 9.9967 0.0734 9.8529 10.1405 
108 10.1490 0.0747 10.0025 10.2954 
proc print; var expforecast--expclupper; run;
proc means sum;
run;


 


 
 




