function S = only_usefull_S_subseries(S)

[Y I] = sort(S(:,end));
S = S(I,:);
temp_S = S(1,:);
i=2;
while sum(ismember(sum(temp_S(:,2:end-1),1),0),2)>0
    temp_S = [temp_S ; S(i,:)];
    i = i+1;
end

S = temp_S;
end

