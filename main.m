load chickenpox_dataset.MAT
time_series = cell2mat(chickenpoxTargets);
%load some time series.
error1 = 'SMAPE';
%Error measurement use during S matrix creation. 
error2 = 'SMAPE';
%Error measurement use in finial test. 
period = 4;
%period is maximal period taken into consideration
method ='arima210';
%which method we would like to use for forecasting for example
%'arima210' (arima and last 3 numbers are parameters p,d,q) or 
%'nn' (neural network automated generetad matlab script, please see matlabNeuralNetworkScript.m) 
horizon = 12;
minimal_series_length = 10;
testset = [];
[SMAPE_error forecasted_values]= error_of_h_steps_ahead_forecasting(period,time_series,testset,minimal_series_length,method,horizon,error1,error2);
