A = cos(0:0.1:100)*10;
A_tested = A(101:120);
A= A(1:100);

% B = []
% for i=1:1:110
%     if mod(i,2) ==0
%         B = [B 0];
%     else
%         B = [B 1];
%     end
% end
 B = sin(0:0.1:100)*10;
 B_tested = B(101:120);
 B=B(1:100);
% B= B(1:100);
C = A(1)+B(1);
for i = 2:1:100
    C(i) =  A(i)+B(i) + C(i-1);
end
%C= A + B;
time_series = [C;A;B].';
testset_multivariables = [A_tested;B_tested].';
%load some time series.
error1 = 'SMAPE';
%Error measurement use during S matrix creation. 
error2 = 'SMAPE';
%Error measurement use in finial test. 
period = 4;
%period is maximal period taken into consideration
method ='fitlm';
%which method we would like to use for forecasting for example
%'arima210' (arima and last 3 numbers are parameters p,d,q) or 
%'nn' (neural network automated generetad matlab script, please see matlabNeuralNetworkScript.m) 
horizon = 12;
minimal_subseries_length = 10;
testset = [];
%[SMAPE_error forecasted_values]= error_of_h_steps_ahead_forecasting(period,time_series,testset_multivariables,minimal_series_length,method,horizon,error1,error2);
X_PREDICTION = h_steps_ahead_forecasting(period,time_series,testset_multivariables,minimal_subseries_length,method,horizon,error1);
