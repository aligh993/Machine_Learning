% @author: ALI GHANBARI
% @email: alighanbari446@gmail.com

clc;
clear all;
close all;

% normal guassian 1
normal_mean_1 = [1 2];
normal_sigma_1 = [2 1;1 1];
a = mvnrnd(normal_mean_1,normal_sigma_1,500); 
x = min(a(:,1)):.1:max(a(:,1));
y = min(a(:,1)):.1:max(a(:,1));
[X, Y] = meshgrid(x,y);
Z = mvnpdf([X(:) Y(:)],normal_mean_1,normal_sigma_1);
Z = reshape(Z,size(X));

figure(1);
subplot(1,2,1),surf(X,Y,Z);
subplot(1,2,2),contour(X,Y,Z);

% maximum likelihood estimation
[m1_hat, s1_hat]= Gaussian_MLE(X);

% normal guassian 2
normal_mean_2 = [1 -2];
normal_sigma_2 = [1 1;1 2];
a = mvnrnd(normal_mean_2,normal_sigma_2,500); 
x = min(a(:,1)):.1:max(a(:,1));
y = min(a(:,1)):.1:max(a(:,1));
[X, Y] = meshgrid(x,y);
Z = mvnpdf([X(:) Y(:)],normal_mean_2,normal_sigma_2);
Z = reshape(Z,size(X));

figure(2);
subplot(1,2,1),surf(X,Y,Z);
subplot(1,2,2),contour(X,Y,Z);

% maximum likelihood estimation
[m2_hat, s2_hat]= Gaussian_MLE(X);

r=1;