% @author: ALI GHANBARI
% @email: alighanbari446@gmail.com

randn('seed',0);
mean_1 = [1 2];
sigma_1 = [2 1; 1 1];
R1 = mvnrnd(mean_1, sigma_1, 500); 

mean_2 = [1 -2];
sigma_2 = [1 1; 1 2];
R2 = mvnrnd(mean_2, sigma_2, 500); 

scatter(R1(:,1), R1(:,2), '.');
hold on
scatter(R2(:,1), R2(:,2), '.');
x1 = min(R1(:,1)):.1:max(R1(:,1));
x2 = min(R2(:,1)):.1:max(R2(:,1));
y1 = 6 - (x1.^2 - 10.*x1 + 41).^(1/2);
% y1 = (x1.^2 - 10.*x1 + 41).^(1/2) + 6;
y2 = (4*x1)/11 - (5*(x1.^2/5 - (178*x1)/25 + 169/5).^(1/2))/11 + 30/11;
% y2 = (4*x1)/11 + (5*(x1.^2/5 - (178*x1)/25 + 169/5).^(1/2))/11 + 30/11;
plot(x1, y1);
plot(x1, y2);
hold off

xlabel('X'); 
ylabel('Y');