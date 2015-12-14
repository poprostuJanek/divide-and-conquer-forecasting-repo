function S = create_S(X, c, minimal_subseries_length,method,error)
%where:
%X: is known time series
%c: is maximal period taken into considaration
%minimal_subseries_length: is minimal suberies taken into consideration (in
%order to avoid a subseries which have only a few elements and
%forecast on them could be misleading)
%error: is method of measure of time series prediction accuracy. By default 'MSE'. We
%propose 'SMAPE'. Probably rather negligible parameter ;).


if size(X,2)<size(X,1)
    X=X.';
end

periods_vector = ceil((c+1)/2):c;
%periods_vector is vector of all periods taken into consideration

S = [];
for i=1:size(periods_vector,2)
    S =[S; create_S_subseries(periods_vector(1,i),minimal_subseries_length,size(X,2))];
end

for i=1:size(S,1)
subseries = create_subseries(S(i,2:end-1),X);
    if ((findstr('arima', method)) == 1)       
        S(i,end) = forecasting_with_ARIMA(subseries,0.3,str2num(method(6)),str2num(method(7)),str2num(method(8)),error);
    
    elseif ((findstr('fitlm', method)) == 1)    
        horizon = 12;
        testing_subseries = subseries(1,end-horizon+1:end);
        temp_fitlm_pred = forecasting_with_FITLM_horizont(subseries(:,1:end-horizon),subseries(2:end,end-horizon+1:end),horizon);     
        MSE_Fitlm = mean((temp_fitlm_pred-testing_subseries).^2);
        S(i,end) = MSE_Fitlm;
    elseif ((findstr('varmax', method)) == 1)
        horizon = 12;
        testing_subseries = subseries(1,end-horizon+1:end);
        temp_varmax_pred = forecasting_with_VARMAX_horizont(subseries(:,1:end-horizon),subseries(2:end,end-horizon+1:end),horizon,1,0);
        MSE_varmax = mean((temp_varmax_pred.'-testing_subseries).^2);
        S(i,end) = MSE_varmax;
    else
    %     if size(X,2)*0.1 > 10
    %         horizon = round(size(X,2)*0.1);
    %     else
    %         horizon = 10;
    %     end
        horizon = 12;
        testing_subseries = subseries(1,end-horizon+1:end);
        temp_nn_pred = forecasting_with_NN(subseries(1,1:end-horizon),horizon);     
        MSE_NN = mean((temp_nn_pred-testing_subseries).^2);
        S(i,end) = MSE_NN;
    end
end

[Y I] = sort(S(:,end));
S = S(I,:);

S = only_usefull_S_subseries(S);

end