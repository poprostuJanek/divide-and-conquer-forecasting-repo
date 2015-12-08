function subseries = create_subseries(binary_vector,X)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

if size(X,1)>size(X,2)
    X = X.';
end

temp = 1;
subseries = ones(size(X,1),sum(binary_vector,2));
    for j=1:1:size(binary_vector,2) 
        if(binary_vector(j) == 1)
            subseries(:,temp) = X(:,j);
            temp = temp+1;
        end
    end

