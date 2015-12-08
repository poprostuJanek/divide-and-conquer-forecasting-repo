function [Error,X_PREDICTION]= error_of_h_steps_ahead_forecasting(period,time_series,testset_multivariables,minimal_subseries_length,method,horizon,error1,error2)

%time series should be column not row
if size(time_series,2)>size(time_series,1)
    time_series = time_series.';
end

% if size(time_series,2)>1
% %we have previous values of time series and other correlated values. We can
% %use VARMAX
%    
%     if size(testset_multivariables,2) == size(time_series,2)-1
%         %we know additional information
%         if ((findstr('varmax', method)) == 1)  
%             %forecasted_matrix(i,1:d) = forecasting_with_VARMAX_horizont(train_set,str2num(method(6)),str2num(method(7)),str2num(method(8)),d);
%         else
%            X_PREDICTION = forecasting_with_FITLM_horizont(time_series,testset_multivariables,horizon);
%         end
%     else
%         %we have to forecast additional information
%     end
%         
% else
%we have only previous values of time series. We can use ARIMA
        %S matrix evaluating
        n = size(time_series,1);
        X_train = time_series(1:n-horizon,:);
        S = create_S(X_train, period, minimal_subseries_length,method,error1);
        
        %error evaluating
        X_train = time_series(1:n-horizon,:);
        X_TEST = time_series(n-horizon+1:end,:); 
        [Error, X_PREDICTION] = error_of_forecasting_with_S(X_train,X_TEST,S,method,error2);
%end
end