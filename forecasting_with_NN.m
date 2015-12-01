function tablica_przewidywan = forecasting_with_NN(train_set,ile_elementow_kazdy_model_musi_przewidziec)
        

        %time series forecasting is much more unpredictible then ARIMA
        %method. This is why we do not predict values ones but 8 times and calculate mean values. 
        %I know, quite complicated and time consuming method but improve quality. 
        if (size(train_set,2)>size(train_set,1))
            train_set = train_set.';            
        end    
        tablica_z = zeros(5,ile_elementow_kazdy_model_musi_przewidziec);
        for z=1:5
        tablica_z(z,:) = matlabNeuralNetworkScript(train_set.',ile_elementow_kazdy_model_musi_przewidziec);
        end
            
        tablica_przewidywan = mean(tablica_z,1);
        
        
        

end