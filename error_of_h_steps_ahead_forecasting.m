function [Error,X_PREDICTION]= error_of_h_steps_ahead_forecasting(c,time_series,minimal_subseries_length,metoda,horizon,error1,error2)
if size(time_series,2)>size(time_series,1)
    time_series = time_series.';
end

        %S matrix evaluating
        n = size(time_series,1);
        X_train = time_series(1:n-horizon,:);
        S = create_S(X_train, c, minimal_subseries_length,metoda,error1);
        
        %error evaluating
        X_train = time_series(1:n-horizon,:);
        X_TEST = time_series(n-horizon+1:end,:); 
        [Error, X_PREDICTION] = error_of_forecasting_with_S(X_train,X_TEST,S,metoda,error2);
       
end