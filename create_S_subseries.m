function S = create_S_subseries(period,minimal_subseries_length,n)
%function return matrix S (of length n+2). Where first column are periods,
%last columns are 0 (empty waiting for prediction error)
%minimal_subseries_length: is minimal suberies taken into consideration

   S = combn([0 1],period);
   S = cloning(period,S,n);
   %removing too short subseries
   S(any(sum(S,2)<minimal_subseries_length,2),:)=[];
   %prefix-period i sufix-error
   S = [ones(size(S,1),1)*period S zeros(size(S,1),1)];
end