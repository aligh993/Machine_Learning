% @author: ALI GHANBARI
% @email: alighanbari446@gmail.com

randn('seed',0);
mu = [2 -2];
sigma = [0.9 0.2; 0.2 0.3];
X = mvnrnd(mu, sigma, 50)';
[mu_hat, sigma_hat] = Gaussian_ML_est(X)