function [J,h] = finDifJac(f,t,x,errtol)
    %computes a finite difference approximation to the jacobian of a function f at the point x
    %uses centered difference
    n = length(x);
    m = length(f(t,x));
    sz = [m,n];
    J = inf(sz);
    h = 1e-4*ones(n,1);
    err = inf;
    while (err>errtol)
        Jold = J;
        for i=1:n
            xp = x+[zeros(i-1,1);h(i);zeros(n-i,1)];
            xm = x-[zeros(i-1,1);h(i);zeros(n-i,1)];
            fp = f(t,xp);
            fm = f(t,xm);
            J(:,i) = (fp-fm)/(2*h(i));
        end
        errmat = abs(J-Jold);
        err = max(errmat(:));
        toohigh = find(errmat>errtol);
        [rowidx,~] = ind2sub(sz,toohigh);
        h(rowidx) = h(rowidx)/2;
        if any(h<100*eps)
            warning('step size is close to machine precision! h = %e, max error on last iteration = %e',min(h),max(errmat(:)));
        end
    end
end