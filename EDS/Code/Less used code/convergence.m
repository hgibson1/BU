function [obs_compare,obs] = convergence(datapoints,obs_vec)
data=zeros(1,datapoints);
for i=1:10
    data(1,i)=obs_vec_no_lines(randi([1,30],1),randi([1,30],1));
end
obs_compare=sum(data)*900/datapoints;
obs=sum(obs_vec);
end

