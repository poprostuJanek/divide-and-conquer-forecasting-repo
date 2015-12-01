function calculated_error = forecasting_with_ARIMA(y,test_size,p,D,q,error)
%test_size what part of whole time series should be test set.

    if size(y,2)>size(y,1)
        y=y.';
    end
    T = length(y);
    a = round((1-test_size)*size(y,1));
    train_set = y(1:a,:);
    test_set = y(a+1:end,:);
    Mdl = arima(p,D,q);
    k=1;
    while k>0
        try
           EstMdl = estimate(Mdl,train_set(k:end,1),'Display','off');
           [yF,yMSE] = forecast(EstMdl,size(test_set,1),'Y0',train_set);
           
           %Place to implement more error measures then MSE and SMAPE.
           if(strcmp(error,'SMAPE'))
               calculated_error =2*mean(abs(yF-test_set)./(abs(yF)+abs(test_set)));
           else  
           %MSE
           calculated_error = mean((yF-test_set).^2);
           end
           k=-1;
           
        catch exception
            k=k+1;
            if k>6
                k=-1
                calculated_error=1000000
            end
        end
    end

