** AUTOREGRESSION - Houston ozone and weather data **;
PROC IMPORT DATAFILE="/home/tomsager/TS/Ozone and weather.xlsx"
            OUT=ozone
            DBMS=xlsx
            REPLACE;
            RANGE="Ozone and weather$A10:H133";
RUN;
* Add lagOzone = previous day's ozone to dataset *;
DATA OZONE;
  SET OZONE;
  lagOzone = lag(ozone);
RUN;
* How much does current ozone depend upon previous ozone? *;
PROC AUTOREG DATA=ozone;
  MODEL ozone = lagOzone;
RUN;
* Alternative approach through autoregressive errors *;
PROC AUTOREG DATA=ozone;
  MODEL ozone =  / NLAGS=1;
RUN;
* Get autocorrelation function of ozone by SAS trick *;
PROC AUTOREG DATA=ozone;
  MODEL ozone =  / NLAGS=10;
RUN;

* Diagnose adequacy of the regression model *;
* Test L,H,I,N *;
PROC REG DATA=ozone;
  VAR date;
  MODEL ozone = lagOzone;
  PLOT r. * p.;
  PLOT r. * date;
RUN;
PROC REG DATA=ozone;
  * SPEC implements White's test of Homoscedasticity *;
  MODEL ozone = lagOzone / spec ;
  OUTPUT OUT=ozone r=residOzone p=predOzone;
RUN;
PROC AUTOREG DATA=ozone;
  * RESET implements Ramsey's test of L *;
  MODEL ozone = lagOzone / RESET;
RUN;
PROC UNIVARIATE DATA=ozone normal;
  * NORMAL implements 4 tests of normality *;
  VAR residOzone;
RUN;

** Improve the model **;
DATA OZONE;
  SET OZONE;
  lagOzone = lag(ozone);
  logOzone = log(Ozone);
  laglogOzone = lag(logOzone);
  laglogOzone2 = laglogOzone**2;
RUN;
proc autoreg data=ozone;
  model logOzone = laglogOzone laglogOzone2 / reset dwprob;
  output out = outoz p=plogoz r=rlogoz;
RUN;
proc reg data=ozone;
  model logOzone = laglogOzone laglogOzone2 / spec;
RUN;
proc univariate data=outoz normal;
  var rlogoz;
RUN;
