* Validation of Autoregression Model for Dell Stock Price *;
PROC IMPORT DATAFILE="/home/tomsager/TS/Dell and Random Walk.xlsx"
            OUT=Dell
            DBMS=xlsx
            REPLACE;
            RANGE="Dell 1-plot$A3:B67";
RUN;
* Add lagDell = previous day's price to dataset *;
DATA Dell;
  SET Dell;
  lagDell = lag(Dell);
RUN;

* Fit and test validity of 1st order autoregression: Dell = a + b lagDell + e *;
* Run autoregression, get residuals for later Normal test, 
  test L with Ramsey's RESET, test I with 1st-order Durbin-Watson;
proc autoreg data=Dell; 
  model Dell = lagDell / reset dwprob;
  output out=Dell r=resDell;
run;
* Test H with White's SPEC test;
proc reg data=Dell; 
  model Dell = lagDell / spec;
run;
* Test N with 4 normal tests;
proc univariate data=Dell normal;
  var resDell;
run;

* To forecast automatically and get the correct confidence intervals, 
  add the lagDell values to the dataset, as follows: *;
data Dell;
  set Dell;
  output Dell;
  * After the last obs, add a new obs for next day,
    transfer last Dell price to new day's lagDell,
    set new day's Dell = missing;
  if _n_ = 64  then do;
    date = '23AUG2012'd;
    lagDell = Dell;
    Dell = .;
    output Dell;
  end;
run;
* Predict values and give 95% individual intervals, including for next day;
proc reg data=Dell; 
  model Dell = lagDell / CLI p;
run;


