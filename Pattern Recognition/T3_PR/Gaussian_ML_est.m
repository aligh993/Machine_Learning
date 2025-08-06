% @author: ALI GHANBARI
% @email: alighanbari446@gmail.com

function [means, covariance] = Gaussian_ML_est(t_data)
N = size(t_data,2);
means = sum(t_data,2)/N;
covariance = (t_data-means*ones(1,N))*(t_data-means*ones(1,N)).'/N;
end