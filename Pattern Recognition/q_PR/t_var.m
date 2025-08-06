% @author: ALI GHANBARI
% @email: alighanbari446@gmail.com

function ml = t_var(param)
rng default;
data = random('norm',0,1,[400,1]);
z = (data - param(1)) ./ param(2);
L = -.5.*z.*z - log(sqrt(2.*pi).*param(2));
ml = -sum(numel(data).*L);