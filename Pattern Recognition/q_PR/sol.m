% @author: ALI GHANBARI
% @email: alighanbari446@gmail.com

syms x y
eqn = 0.1*x.^2 + 1.1*y.^2 - 0.8*x*y + 3.8*x - 6*y + 0.5 == 0;
sola = solve(eqn, y)