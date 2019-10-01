% syms F G real
% syms K
syms f11 f22 g11 g22  real
syms f12 g12 k11 k12 k21 k22
F = [f11, f12; conj(f12), f22];
G = [g11, g12; conj(g12), g22];
K = [k11,k12;k21,k22];
U = sym('U',[4,4]);
L = [-F^-1*K, F^-1; G-K'*F^-1*K, K'*F^-1];
% L= [0 1/F; G 0];
J = [zeros(2),eye(2);-eye(2),zeros(2)];
simplify(J*L*J-L')
pretty(simplify(trace(U^-1*L*U)))


%%
syms a b c d f2 z sqrtD
usmall = z^(-1/2-sqrtD);
ubig = z^(-1/2+sqrtD);
x1L = a*usmall + b*ubig;
x2L = c*usmall + d*ubig;
UL = [x1L, x2L; f2*z^2*diff(x1L,z), f2*z^2*diff(x2L,z)];
pretty(det(UL))



x1R = a*usmall ;
x2R = c*usmall ;
UR = [x1R, x2R; f2*z^2*diff(x1R,z), f2*z^2*diff(x2R,z)];
pretty(det(UR))



