/* Pollution and weather data from Houston:                                                  
  OZONE       Houston area maximum of hourly ozone measurements (pphm) for the day        
  WIND SPEED  Houston area average wind speed (mph) 10:00am-1:00pm                        
  MAX TEMP    Houston area average maximum temperature (degrees F.) for the day           
  RAIN        Houston International Airport rainfall (1=yes, 0=no)                             
  NOX         Houston area average nitrogen oxides concentration (ppb) 6:00am-9:00am      
  RADIATION   Houston area average non-negative net solar radiation for the day           
  OPAQUENESS  Houston area average opaque sky (%) 7:00am-11:00am                          
*/
data ozone;
  input DATE mmddyy10.  OZONE   WINDSPEED   MAXTEMP RAIN    NOX RADIATION   OPAQUENESS;
  ozone          = log(ozone); * Switch ozone and its lags to log scale;
  WindSpeed2     = WindSpeed**2;
  lag1ozone      = lag1(ozone);
  lag2ozone      = lag2(ozone);
  lag3ozone      = lag3(ozone);
  lag4ozone      = lag4(ozone);
  lag1WindSpeed  = lag1(windspeed);
  lag1WindSpeed2 = lag1(windspeed2);
  lag1MaxTemp    = lag1(maxtemp);
  lag1Rain       = lag1(rain);
  lag1NOx        = lag1(NOx);
  lag1Radiation  = lag1(radiation);
  lag1Opaqueness = lag1(opaqueness);
datalines;
7/1/1982  7  9.8333  90.05  0  12.7932  604.25  4
7/2/1982  5  9.8  91.475  0  11.2365  643  1
7/3/1982  10  6.4667  91.575  0  7.0552  646.25  3
7/4/1982  9  7.1111  89.525  0  10.065  549.75  4
7/5/1982  5  11.0222  90.8  1  8.2405  572  4
7/6/1982  5  10.7556  91.5  0  10.0852  545.5  5
7/7/1982  9  6.1  90.1  0  12.2292  468.25  5
7/8/1982  15  5.0778  91.025  0  14.9292  605.25  3
7/9/1982  8  6.3222  89.95  0  19.9357  563.75  4
7/10/1982  7  7.6222  91.475  0  9.5569  605  4
7/11/1982  12  6.4889  93  0  6.8611  623.75  3
7/12/1982  19  5.6778  93.65  0  14.2358  610.5  3
7/13/1982  21  4.1778  91.8  1  18.7901  560.75  1
7/14/1982  19  4.3222  88.4  0  29.4312  360.75  3
7/15/1982  11  6.7  90.925  1  20.2303  484.5  4
7/16/1982  12  6.9333  88.2  0  23.3695  313.75  3
7/17/1982  9  6.9333  90.2  0  18.5507  465.75  4
7/18/1982  7  8.4889  90.2  0  18.3824  515.5  5
7/19/1982  11  6.3667  93.55  0  15.3564  586.75  4
7/20/1982  15  5.2056  93.9  0  11.3272  576.25  3
7/21/1982  18  5.0556  93.075  1  18.2917  404.75  5
7/22/1982  22  4.4167  89.125  0  23.7668  330.25  0
7/23/1982  17  5.8  93.1  1  13.392  504.25  1
7/24/1982  19  5.9  93.775  0  10.0715  586.75  4
7/25/1982  10  7.6444  94.25  0  10.366  554  4
7/26/1982  8  8.2667  91.65  0  19.1979  366.5  3
7/27/1982  9  6.1167  91.775  0  17.5928  400.25  4
7/28/1982  14  6.6667  95.25  0  13.6573  584.75  2
7/29/1982  11  7.2333  94.3  1  13.392  525.25  4
7/30/1982  7  8.3111  94.35  0  11.7544  415.75  6
7/31/1982  6  9.1222  93.525  0  11.1492  476  6
8/1/1982  8  8.4333  92.725  0  9.8676  511.25  3
8/2/1982  10  6.6  93.5  0  10.8805  569.75  3
8/3/1982  5  10.9333  93.675  0  15.261  613.25  3
8/4/1982  8  7.3333  94  0  14.1733  598  2
8/5/1982  23  5.2778  94.75  0  16.9693  570.75  0
8/6/1982  28  4.5778  94.025  0  27.0263  489.75  1
8/7/1982  11  3.6889  80.175  1  27.59  90.25  10
8/8/1982  15  4.8444  83.375  1  30.9127  428.25  5
8/9/1982  14  7.4444  84.225  1  36.9053  353.75  2
8/10/1982  10  10.0667  89.2  1  17.4558  495.25  3
8/11/1982  13  4.2333  86.35  0  26.1711  209.75  6
8/12/1982  10  6.4889  88.775  0  24.03  428.25  4
8/13/1982  10  7.0667  92.125  0  8.722  565.5  3
8/14/1982  9  7.2222  92.225  0  8.9  532.25  4
8/15/1982  13  6.6444  93.6  0  8.811  594.5  3
8/16/1982  16  5.2667  93.075  0  9.612  522.5  3
8/17/1982  28  4.0667  93.975  0  20.915  537.75  2
8/18/1982  11  7.2667  90.875  1  18.2673  377.75  9
8/19/1982  19  6.3778  90.375  0  8.7665  576  0
8/20/1982  14  7.4889  89.975  0  25.4095  504.75  2
8/21/1982  11  6.5222  89  0  14.0175  465.75  3
8/22/1982  28  3.9667  90.35  0  24.564  523.25  1
8/23/1982  5  9.9444  93.175  0  10.4631  559  3
8/24/1982  5  11.1889  92.65  0  12.6347  569.25  1
8/25/1982  11  6.4556  92.425  0  10.9517  523.5  2
8/26/1982  8  6.8444  92.4  0  8.366  550.25  4
8/27/1982  8  9.3444  93.975  0  14.6363  546  1
8/28/1982  12  4.6  91.275  0  16.4083  406.5  4
8/29/1982  18  5.3333  92.6  0  18.9003  525.5  5
8/30/1982  11  8.8556  92.5  0  31.59  530  3
8/31/1982  13  7.4667  91.8  1  13.6249  434  4
9/1/1982  12  9.1444  92  0  15.6598  549.25  4
9/2/1982  18  4.6222  92.65  0  11.4857  452.5  4
9/3/1982  19  4.8333  95.075  1  12.2884  425  1
9/4/1982  19  7.9444  87.05  0  10.2236  529  2
9/5/1982  16  6.8444  89.25  0  10.9915  564.25  0
9/6/1982  11  10.5444  88.675  0  20.0492  415.25  3
9/7/1982  14  8.1333  89.95  0  17.6929  484.75  2
9/8/1982  10  9.0278  90.15  0  14.4631  452.25  2
9/9/1982  8  11.5111  90.375  0  12.6686  501  0
9/10/1982  9  12.4556  86.675  0  15.6929  423.75  3
9/11/1982  7  10.0333  91.2  0  7.0132  295.75  5
9/12/1982  5  14.5667  91.225  1  16.0847  440.5  4
9/13/1982  5  13.2333  90.5  0  16.3112  482.5  5
9/14/1982  13  7.1778  84.85  0  43.61  205.5  6
9/15/1982  8  6.8667  88.625  1  16.9744  455.5  3
9/16/1982  19  5  93.425  0  36.4138  520.75  0
9/17/1982  15  6  91.125  0  7.403  392.5  1
9/18/1982  20  5.6333  93.775  0  15.1136  484.5  1
9/19/1982  18  4.2333  90.625  1  14.24  337.5  2
9/20/1982  9  9.0111  85.975  0  23.0976  323.5  10
9/21/1982  8  11.0333  80.7  0  16.133  515  2
9/22/1982  9  7.6889  76.4  0  12.9  508.5  0
9/23/1982  18  5.9333  78.675  0  21.4504  507.25  0
9/24/1982  19  4.9222  83.875  0  24.0217  483.25  0
9/25/1982  12  11.8111  88.5  0  35.7227  490.25  1
9/26/1982  18  4.6  81.1  0  18.0264  477  0
9/27/1982  10  12.6556  83.525  0  12.4177  470.75  0
9/28/1982  8  13.7444  86.05  0  12.476  497  4
9/29/1982  9  13.8444  85.875  0  13.5277  438.5  3
9/30/1982  10  11.5889  85.8  0  19.8451  447.25  1
10/1/1982  14  8.3889  87.65  0  15.3789  462.25  3
10/2/1982  15  8.1444  84.8  1  14.6444  258  2
10/3/1982  12  9.5667  88.9  0  12.9655  410.25  2
10/4/1982  13  7.2889  89.75  0  12.3207  419.25  0
10/5/1982  10  10.9778  86.88  0  46.1691  348  2
10/6/1982  5  12.8  83.7  1  18.35  176  8
10/7/1982  3  8.8556  78.58  0  36.8813  91.25  10
10/8/1982  3  16.2222  86.7  1  23.4376  279.75  10
10/9/1982  5  12.6556  89.7  0  10.9971  378.25  6
10/10/1982  6  9.6444  74.8  0  13.5213  246.25  10
10/11/1982  4  9.0556  66.58  1  12.5893  107  10
10/12/1982  4  9.4778  61.92  1  7.128  56.5  10
10/13/1982  6  10.7667  75.04  0  14.1329  440.75  2
10/14/1982  10  5.6111  78.42  0  43.0315  463.75  0
10/15/1982  12  6.7  81.12  1  24.2564  437.75  0
10/16/1982  17  7.8  81.56  0  15.0068  457.25  0
10/17/1982  12  9.3556  77.82  0  18.3079  347.75  4
10/18/1982  12  7.7944  82.96  0  20.7481  360.25  1
10/19/1982  8  14.0444  83.18  0  24.1221  349.25  5
10/20/1982  7  12.0667  71.26  0  13.5455  410.5  6
10/21/1982  6  9.0222  70.36  0  14.408  355  5
10/22/1982  6  8.3333  70.34  0  11.214  265  9
10/23/1982  9  9.2222  70.2  0  16.044  410.75  1
10/24/1982  9  8.8  70.54  0  16.8655  413.75  0
10/25/1982  11  6  71.68  0  17.1962  373.5  0
10/26/1982  14  6.3333  73.9  0  43.2578  386.25  0
10/27/1982  7  14.8444  78.08  0  18.9593  329.75  2
10/28/1982  5  14.1889  79.3  0  14.3958  220.5  10
10/29/1982  23  3.2  76.46  1  30.4298  254.5  10
10/30/1982  5  8.5222  80.96  1  21.8873  305.25  8
10/31/1982  5  13.5  82.94  0  13.3272  397.25  5
RUN;
proc arima data=ozone;
  identify var=ozone;
  estimate  plot;
run;

* You can add other time series as predictors in ARIMA;
* In the following, I selected the 4 best predictors from previous regression analysis;
* These 4 have R-square of about 75%;
* The following shows how to essentially replicate a multiple regression using ARIMA,
*  but without using much of the special time series capabilities of ARIMA;
* To do this, you use the CROSSCORR and INPUT capabilities ;
* The autocorrelation check for residuals indicates this is already a pretty good model;
proc arima data=ozone;
  identify var=ozone crosscorr=(windspeed opaqueness windspeed2 lag1ozone);
  estimate input=(windspeed opaqueness windspeed2 lag1ozone) plot;
run;
AIC 1.936371 
SBC 15.95648 

* Prepare to use ARIMA time series capabilities by making Y variable stationary;
proc arima data=ozone;
  identify var=ozone(1) crosscorr=(windspeed opaqueness windspeed2 lag1ozone);
  estimate input=(windspeed opaqueness windspeed2 lag1ozone) plot;
run;
AIC 1.936371 
SBC 15.95648 

* Test for AR(1) residuals;
* Not significant;
proc arima data=ozone;
  identify var=ozone(1) crosscorr=(windspeed opaqueness windspeed2 lag1ozone);
  estimate input=(windspeed opaqueness windspeed2 lag1ozone) plot p=1;
run;
AIC 3.112994 
SBC 19.93712 

* Test for MA(1) residuals;
* Not significant;
proc arima data=ozone;
  identify var=ozone(1) crosscorr=(windspeed opaqueness windspeed2 lag1ozone);
  estimate input=(windspeed opaqueness windspeed2 lag1ozone) plot q=1;
run;
AIC 3.05488 
SBC 19.87901 

* In order to forecast, you must supply future values for the predictors;
* These can be forecast from other sources and added to the input data;
* They can also be forecast within ARIMA;
* This means fitting an ARIMA model to each predictor; 
* If you do this within a single ARIMA, SAS will take the forecasts from each such model
*   to use as the future values of each predictor;
proc arima data=ozone;
  identify var=windspeed;
    estimate;
  identify var=opaqueness;
    estimate;
  identify var=windspeed2;
    estimate;
  identify var=lag1ozone;
    estimate;
  identify var=ozone(1) crosscorr=(windspeed opaqueness windspeed2 lag1ozone);
    estimate input=(windspeed opaqueness windspeed2 lag1ozone) plot;
    forecast lead=4;
run;
AIC 1.936371 
SBC 15.95648 

* The initial plots and tests for autocorrelation in the residuals show that the ARIMA models
*   for the predictors could be improved to make more nearly stationary; 
* But there is no requirement that the input series be stationary;
proc arima data=ozone;
  identify var=windspeed(1);
    estimate;
  identify var=opaqueness(1);
    estimate;
  identify var=windspeed2(1);
    estimate;
  identify var=lag1ozone(1);
    estimate;
  identify var=ozone(1) crosscorr=(windspeed(1) opaqueness(1) windspeed2(1) lag1ozone(1));
    estimate input=(windspeed opaqueness windspeed2 lag1ozone) plot;
    forecast lead=4;
run;
AIC 48.56535 
SBC 62.5443 
