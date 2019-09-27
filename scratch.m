syms x a
a=1;
y = x^2*(-(x-a)+(x-a)^2);
yp = diff(y,x);
f = 2*x^3*(x-a)^2;
g = simplify(yp+y^2/f)
ga = subs(g,x,a)
fplot(g,[0,2])