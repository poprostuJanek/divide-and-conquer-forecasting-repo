function main_h_steps_ahead_forecasting(method,z_min,z_max,period) 
error1 = 'SMAPE';
error2 = 'SMAPE';
%train = cell2mat(importfile('train.csv', 2, 1017210));
train = flipud(train);
minimal_subseries_length = 10;

[a,b] = importfile_test('test.csv',2, 41089);
c= [a b];
horizont = zeros(1,1115);
for i=1:1:size(c,1)
    horizont(c(i,2)) =  horizont(c(i,2))+1;
end
horizont = flipud(horizont);
horizon = 48;
forecasted_values = zeros(1115,horizon);
for z=z_min:1:z_max
if(horizont(z) >0)
n = size(train,1);
time_series = [];
for i=1:1:n
    if train(i,1) == z
        time_series = [time_series train(i,2)];
    end
end
forecasted_values(z,:) = h_steps_ahead_forecasting(period,time_series,minimal_subseries_length,method,horizon,error1,error2);
save(strcat('forecasted_values_',num2str(z_min),'_',num2str(z_max),'_',method,'.mat'),'forecasted_values');
%wyniki(z,:) = h_steps_ahead_forecasting(6,time_series,10,'arima',horizon,'SMAPE','SMAPE');
z
end
end

end