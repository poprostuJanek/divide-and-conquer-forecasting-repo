function X_PREDICTION = forecasting_with_S(X,testset_multivariables,horizon,S,metoda)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

if size(X,1)>size(X,2)
    X =X.';
end

if size(testset_multivariables,1)>size(testset_multivariables,2)
    testset_multivariables =testset_multivariables.';
end


S_p = zeros(size(S,1),size(X,2)+horizon);
for i=1:size(S,1)
S_p(i,:) = cloning(S(i,1),S(i,2:end-1),size(X,2)+horizon);
end
S_predykcji = S_p(:,end-horizon+1:end);

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
   temp_end = size(S_p,2)-horizon;
   train_set = create_subseries(S_p(i,1:temp_end), X.').'; 
   testset_multivariables_temp = create_subseries(S_p(i,temp_end+1:end), testset_multivariables.').'; 
      %Different methods 
    if(strcmp(metoda,'arima'))
       forecasted_matrix(i,1:d) = forecasting_with_ARIMA_horizont(train_set,d);
    elseif(strcmp(metoda,'fitlm'))
       forecasted_matrix(i,1:d) = forecasting_with_FITLM_horizont(train_set,testset_multivariables_temp,d);
    elseif(strcmp(metoda,'varmax'))
       forecasted_matrix(i,1:d) = forecasting_with_VARMAX_horizont(train_set,testset_multivariables_temp,d,1,0);
    else        
       forecasted_matrix(i,1:d) = forecasting_with_NN(train_set,d);
    end
end
end

X_PREDICTION = find_element(S_predykcji,forecasted_matrix);

end
