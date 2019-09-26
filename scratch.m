syms x a

y = x^2*(-(x-a)+(x-a)^2);
yp = diff(y,x);
f = x^3*(x-a)^2;
g = simplify(yp+y^2/f)