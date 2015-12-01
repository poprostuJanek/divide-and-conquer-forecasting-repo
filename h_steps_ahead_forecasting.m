function X_PREDICTION= h_steps_ahead_forecasting(c,time_series,minimal_subseries_length,method,horizon,error1,error2)
if size(time_series,2)>size(time_series,1)
    time_series = time_series.';
end

        %S matrix evaluating
        S = create_S(time_series, c, minimal_subseries_length,method,error1);
        
        
        X_PREDICTION = forecasting_with_S(time_series,horizon,S,method);
       
end