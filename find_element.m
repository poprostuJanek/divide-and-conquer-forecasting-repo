function X_PREDICTION = find_element(S_predykcji,tablica_przewidywan)
%jaki period p
%jaka macierz S
%do jakiej dlugosci n
aaa = S_predykcji;
na_ktorym_miejscu=ones(size(S_predykcji,1),1);
for i=1:size(S_predykcji,1)
    for j=1:size(S_predykcji,2)
        if(S_predykcji(i,j) ~= 0)
        aaa(i,j) = tablica_przewidywan(i,na_ktorym_miejscu(i));
        na_ktorym_miejscu(i) = na_ktorym_miejscu(i)+1;
        end
    end
end
na_ktorym_miejscu=ones(size(S_predykcji,1),1);
X_PREDICTION = zeros(1,size(S_predykcji,2));
for i = 1:size(S_predykcji,2)
    proponowane = find(S_predykcji(:,i)==1);
    r = min(proponowane);
    X_PREDICTION(1,i) = aaa(r,i);
end

end

