% @author: ALI GHANBARI
% @email: alighanbari446@gmail.com

function [avg,std1,maximum,minimum,time,accuracy]= DWKNN(image,K)
% Z:khoruji
% z:10halate mokhtalef

[X, Y] = size(image);
Z=image(:,Y);

N=floor(X/10);
M=Y-1;

%Test: first set
tic;

Train(1:X-N, 1:M) = image(N+1:X, 1:M);
Test(1:N, 1:M) = image(1:N, 1:M);

% PCA:
PC=princomp(Train);
PC=PC(:,1:5);
Train=Train*PC; 
Test=Test*PC;
%

Z_Train(1:X-N,1) = Z(N+1:X);
Z_Test(1:N,1) = Z(1:N, 1);

distan=dist(Test,Train'); 
[sortdistan,index1]=sort(distan,2);
weight=(sortdistan.^2).^(-1);

[a,b]= size(Z_Test);
 correct=correct_DWKNN(Z_Test,Z_Train,index1,a,K,weight);
accuracy(1,1)= (correct/a)*100; 

t(1)=toc;

%Test: middle  sets
for i=1:8
    tic
    Train(1:N*i, 1:M) = image(1:N*i, 1:M);
    Train(N*i+1:X-N, 1:M) = image(N*i+N+1:X, 1:M);
    Test(1:N, 1:M) = image(N*i+1:N*i+N, 1:M);
    
    % PCA:
    PC=princomp(Train);
    PC=PC(:,1:5);
    Train=Train*PC; 
    Test=Test*PC;
    %
    
    Z_Train(1:N*i, 1) = Z(1:N*i,1);
    Z_Train(N*i+1:X-N, 1) = Z(N*i+N+1:X,1);
    Z_Test(1:N,1) = Z(N*i+1:N*i+N, 1);
        
    distan=dist(Test,Train'); 
    [sortdistan,indexn]=sort(distan,2);
    weight=(sortdistan.^2).^(-1);
    
    [a,b]= size(Z_Test);
    correct=correct_DWKNN(Z_Test,Z_Train,indexn,a,K,weight);
    accuracy(i+1,1)= (correct/a)*100; 
    
    t(i+1)=toc;
end  

% Test: last set
tic;

Train(1:9*N, 1:M) = image(1:9*N, 1:M);
Test(1:X-9*N, 1:M) =image(9*N+1:X, 1:M);

% PCA:
PC=princomp(Train);
PC=PC(:,1:5);
Train=Train*PC; 
Test=Test*PC;
%
Z_Train(1:9*N,1) = Z(1:9*N,1);
Z_Test(1:X-9*N,1) = Z(9*N+1:X,1);

distan=dist(Test,Train'); 
[sortdistan,index10]=sort(distan,2);
weight=(sortdistan.^2).^(-1);

[a,b]= size(Z_Test);
correct=correct_DWKNN(Z_Test,Z_Train,index10,a,K,weight);
accuracy(10,1)= (correct/a)*100;
 
t(10)=toc;
 
avg=mean(accuracy);
minimum=min(accuracy);
maximum=max(accuracy);
std1=std(accuracy);
time=mean(t);
end