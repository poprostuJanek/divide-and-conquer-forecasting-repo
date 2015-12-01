function y_predykcja = matlabNeuralNetworkScript(training_set, horizon)
%T = simplenarTargets;
T= tonndata(training_set,true,false);
trainFcn = 'trainlm';  % Levenberg-Marquardt
feedbackDelays = 1:2;
hiddenLayerSize = 10;
net = narnet(feedbackDelays,hiddenLayerSize,'open',trainFcn);
net.input.processFcns = {'removeconstantrows','mapminmax'};
[x,xi,ai,t] = preparets(net,{},{},T);
net.divideParam.trainRatio = 0.55;
net.divideParam.valRatio = 0.15;
net.divideParam.testRatio = 0.30;
net.trainParam.showWindow = false;
net.performFcn = 'mse';  % Mean squared error
% Train the Network
[net tr Ys Es Xf Af ] = train(net,x,t,xi,ai,'useParallel','no');
y = net(x,xi,ai);
y_predykcja = zeros(1,horizon);
for i=1:horizon
    Xnew = net(x,Xf,Af);
    Xf = [Xf Xnew(1,1)];
    Xf = Xf(1,2:3);
    y_predykcja(1,i) = cell2mat(Xf(1,2));
end
end
