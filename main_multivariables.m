function main_multivariables(period)

%load some time series.
error1 = 'SMAPE';
%Error measurement use during S matrix creation. 
error2 = 'SMAPE';
%Error measurement use in finial test. 
%period = 4;
%period is maximal period taken into consideration
method ='varmax';
%which method we would like to use for forecasting for example
%'arima210' (arima and last 3 numbers are parameters p,d,q) or 
%'nn' (neural network automated generetad matlab script, please see matlabNeuralNetworkScript.m) 
horizon = 48;
minimal_subseries_length = 10;
testset = [];


%train = importfile_train_wszystkie('train.csv', 2, 1017210);
%testset_multivariables = importfile_test_wszystkie('test.csv', 2, 41089);
%train = importfile_train_wszystkie('train.csv', 2, 10000);
%testset_multivariables = importfile_test_wszystkie('test.csv', 2, 1000);
load train.mat
load test.mat
%[SMAPE_error forecasted_values]= error_of_h_steps_ahead_forecasting(period,time_series,testset_multivariables,minimal_series_length,method,horizon,error1,error2);
%usuwanie wierszow skorelowanych z treningu i testow
additional_information = train(:,2:end);
[additional_information,testset_multivariables, idx] = linear_independent(additional_information,testset_multivariables);

train =  [train(:,1) additional_information];
train(isnan(train)) = 0 ;
testset_multivariables(isnan(testset_multivariables)) = 0 ;
z_min = 1;
z_max = size(train,1);


train = flipud(train);
testset_multivariables = flipud(testset_multivariables);
horizont = zeros(1,1115);
for i=1:1:size(testset_multivariables,1)
    horizont(testset_multivariables(i,1)) =  horizont(testset_multivariables(i,1))+1;
end
horizont = flipud(horizont);
horizon = 48;
forecasted_values = zeros(1115,horizon);

for z=z_min:1:1115
if(horizont(z) >0)
n = size(train,1);
time_series = [];
testset_multivariables_time_series = [];
for i=1:1:n
    if train(i,2) == z
        time_series = [time_series;train(i,:)];
    end
end
n = size(testset_multivariables,1);
for i=1:1:n
    if testset_multivariables(i,1) == z
        testset_multivariables_time_series =  [testset_multivariables_time_series; testset_multivariables(i,:)];
    end
end   
additional_information = time_series(:,2:end);
[additional_information,testset_multivariables_time_series, idx] = linear_independent(additional_information,testset_multivariables_time_series);
time_series =  [time_series(:,1) additional_information];

time_series = [time_series(:,1) time_series(:,3:end)];
testset_multivariables_time_series = testset_multivariables_time_series(:,2:end);
forecasted_values(z,:) = h_steps_ahead_forecasting(period,time_series.',testset_multivariables_time_series,minimal_subseries_length,method,horizon,error1);
save(strcat('forecasted_values_',num2str(z_min),'_',num2str(z_max),'_',method,'period_',num2str(period),'.mat'),'forecasted_values');
z
end
end



my_prediction = [];
z = 1;
aaa = 1;
forecasted_values(all(forecasted_values==0,2),:)=[];
forecasted_values = fliplr(forecasted_values);
for i=1:1:size(forecasted_values,2)
    my_prediction = [my_prediction;forecasted_values(:,i)];
end

c = 1:1:size(my_prediction,1);

my_prediction = [c.' my_prediction];
r= my_prediction;
str=strcat('forecasted_values_',num2str(z_min),'_',num2str(z_max),'_',method,'period_',num2str(period),'.mat');
str1= strcat(num2str(r(:,1),'%0.0f'),',',num2str(r(:,2),'%0.1f'));
dlmwrite(str,str1,'-append', 'delimiter', '', 'precision','%0.1f','newline', 'pc'); 


end