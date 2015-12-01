function [calculated_error X_PREDICTION] = error_of_forecasting_with_S(X,X_TEST,S,method,error)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

if size(X,1)>size(X,2)
    X =X.';
end
if size(X_TEST,1)>size(X_TEST,2)
    X_TEST =X_TEST.';
end

S_p = zeros(size(S,1),size(X,2)+size(X_TEST,2));
for i=1:size(S,1)
S_p(i,:) = cloning(S(i,1),S(i,2:end-1),size(X,2)+size(X_TEST,2));
end
S_predykcji = S_p(:,end-size(X_TEST,2)+1:end);

for i = 1:size(S_predykcji,2)
    proponowane = find(S_predykcji(:,i)==1);
    if isempty(proponowane) 
        S_predykcji = [S_predykcji; ones(1,size(S_predykcji,2))];
        S_p = [S_p; ones(1,size(S_p,2))];
    end
end


%sprawdzenie ile elementow kazdy model musi przewidziec
how_many_elements_must_be_forecasted = sum(S_predykcji,2);
forecasted_matrix = zeros(size(S_predykcji,1),max(how_many_elements_must_be_forecasted));
for i=1:size(S_predykcji,1)
    d = how_many_elements_must_be_forecasted(i);
if d>0
   %wybieranie metody
   temp_end = size(S_p,2)-size(X_TEST,2);
   train_set = create_subseries(S_p(i,1:temp_end), X.').'; 
      %Right now only two methods. ARIMA and Neural Network. Place for
      %other methods implementation.
    if ((findstr('arima', method)) == 1) 

       forecasted_matrix(i,1:d) = forecasting_with_ARIMA_horizont(train_set,str2num(method(6)),str2num(method(7)),str2num(method(8)),d);
    else        
       forecasted_matrix(i,1:d) = forecasting_with_NN(train_set,d);
    end
end
end

X_PREDICTION = find_element(S_predykcji,forecasted_matrix);
if strcmp(error,'SMAPE')
SMAPE =mean(abs(X_PREDICTION-X_TEST)./(0.5*(abs(X_PREDICTION)+abs(X_TEST))));
calculated_error = SMAPE;
elseif strcmp(error,'RMSPE')
   RMSPE = (mean((X_TEST-X_PREDICTION)./(abs(X_TEST))))^(1/2);
   calculated_error = RMSPE;
else   
MSE = mean((X_PREDICTION-X_TEST).^2);
calculated_error = MSE;
end

end
