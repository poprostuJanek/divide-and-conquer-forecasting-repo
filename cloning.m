function S = cloning(period,S,n)
%S: S matrix
%n: length of new series

while size(S,2)<n
    S = [S S(:,end-period+1:end)];
end

if size(S,2)>n
    S = S(:,1:n);
end

end