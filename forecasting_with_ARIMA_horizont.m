function predicted_values = forecasting_with_ARIMA_horizont(train_set,p,d,q,minimal_subseries_length)
        k = 1;
        if (size(train_set,2)>size(train_set,1))
            train_set = train_set.';            
        end
        while k>0
            try
                Mdl = arima(p,d,q);
                EstMdl = estimate(Mdl,train_set(k:end,1),'Display','off');
                [yF,yMSE] = forecast(EstMdl,minimal_subseries_length,'Y0',train_set);
                predicted_values = yF.';
                k = -1;
            catch
                k = k+1;
                if k>6
                   k=-1;
                   predicted_values = zeros(1,minimal_subseries_length)
                end
            end
        end
end