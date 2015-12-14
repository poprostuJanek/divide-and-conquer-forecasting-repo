function predicted_values = forecasting_with_VARMAX_horizont(train_set,testset_multivariables,horizon,AR,MA)


%%%%%%%%%%The most important ! The first column is the column which we
%%%%%%%%%%would like to predict !!!!

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
            PreSample = additional_information(1:AR,:);
            Sample = additional_information(AR+1:end,:);
            numPreds0 = size(additional_information,2);
            VARSpec = vgxvarx(vgxset('n',numPreds0,'Constant',true,'nAR',AR),Sample,[],PreSample);
            predicted_values = vgxpred(VARSpec,horizon,[],additional_information);
            ForecastX =zeros(horizon,size(predicted_values,2));
            for i=1:1:horizon
            ForecastY(i,:) = [1,predicted_values(i,:)]*betaHat0;
            end
            predicted_values = ForecastY;
end