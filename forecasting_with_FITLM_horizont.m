function predicted_values = forecasting_with_FITLM_horizont(train_set,testset_multivariables,horizon)
if size(train_set,2) > size(train_set,1)
    train_set = train_set.';
end

if size(testset_multivariables,2) > size(testset_multivariables,1)
    testset_multivariables = testset_multivariables.';
end
            additional_information = train_set(:,2:end);
            time_series = train_set(:,1);
            Data = [additional_information time_series];
            DataTable = array2table(Data);
            M0 = fitlm(DataTable);
            betaHat0 = M0.Coefficients.Estimate;
            predicted_values = zeros(1,horizon);
            for i = 1:horizon
                predicted_values(i) = [1, testset_multivariables(i,:)]*betaHat0;
            end
            
end