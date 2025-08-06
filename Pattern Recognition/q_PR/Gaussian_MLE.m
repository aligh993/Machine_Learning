% @author: ALI GHANBARI
% @email: alighanbari446@gmail.com

function [means,covariance] = Gaussian_MLE(train_data)
N = size(train_data,2);
means = sum(train_data,2)/N;
covariance = (train_data-means*ones(1,N))*(train_data-means*ones(1,N)).'/N;
end