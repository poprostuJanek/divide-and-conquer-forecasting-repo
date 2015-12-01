function subseries = create_subseries(binary_vector,X)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
temp = 1;
subseries = ones(1,sum(binary_vector,2));
    for j=1:1:size(binary_vector,2) 
        if(binary_vector(j) == 1)
            subseries(temp) = X(j);
            temp = temp+1;
        end
    end

