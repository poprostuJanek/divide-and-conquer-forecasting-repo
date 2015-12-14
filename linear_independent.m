function [Xsub,XtestSub, idx]=linear_independent(Xtrain,Xtest,tol)

%na podstawie Xtrain wyznacza sie liniowo skorelowane ALE
%kolumny usuwa siê zarówno z Xtrain jak i Xtest

%Extract a linearly independent set of columns of a given matrix X
%
%    [Xsub,idx]=licols(X)
%
%in:
%
%  X: The given input matrix
%  tol: A rank estimation tolerance. Default=1e-10
%
%out:
%
% Xsub: The extracted columns of X
% idx:  The indices (into X) of the extracted columns
     if ~nnz(Xtrain) %X has no non-zeros and hence no independent columns
         Xsub=[]; idx=[];
         return
     end
     if nargin<3, tol=1e-10; end
       [Q, R, E] = qr(Xtrain,0); 
       if ~isvector(R)
        diagr = abs(diag(R));
       else
        diagr = R(1);   
       end
       %Rank estimation
       r = find(diagr >= tol*diagr(1), 1, 'last'); %rank estimation
       idx=sort(E(1:r));
       Xsub=Xtrain(:,idx);  
       XtestSub = Xtest(:,idx);