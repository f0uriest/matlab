clear
clc
format long

nvars = 11;
lb = 1*ones(1,nvars);
ub = 5*ones(1,nvars);
IntCon = 1:nvars;
intfun(IntCon)

[x,fval,exitflag] = ga(@optfun,nvars,[],[],[],[],...
    lb,ub,[],IntCon);

intfun(x)

function y = basefun(x,p)
y = (x.^p(1) + x.^p(8) + x.^p(9)).*cos(x./p(2) + x.^p(7)).*abs(x-p(5)/p(6)).^(p(3)/p(4));
end

function I = intfun(x)
fun = @(y) basefun(y,x(3:end));
I = integral(fun,x(1),x(2), 'AbsTol',1e-12) ;
end

function y = optfun(x)
y0 = 0.6174125101;
y = (intfun(x)-y0).^2;
end