function [z,v] = runge_kutta(h,t,f,z0,v0)

% http://12000.org/my_notes/mma_matlab_control/KERNEL/KEse159.htm#x164-2050004.22

% Let z = z(t), z'(t) = v(t) and v'(t)=z"(t)=f(z,v,t)

% Equation:
% z"(t)=(g*(RhoA*vol-mass)-.5*RhoA*realCD*z'(t)*abs(z'(t))*Ca)/(mass+cb*RhoA*vol)
%mass = PMass+BMass+Mb

% f = @(z,v,t) (g*(RhoA*vol-mass)-.5*RhoA*realCD*v(t)*abs(v(t))*Ca)/(mass+cb*RhoA*vol)

% h: time step
% t: total time
% z0: initial altitude
% v0: initial velocity


%Preallocating
N = length(t);
z = zeros(N,1);
v = zeros(N,1);

%Initial conditions
z(1) = z0;
v(1) = v0;

for i = 1:(n-1)
    k1 = h * v(i);
    s1 = h * f(t(i), z(i), v(i));
    
    k2 = h * (v(i) + 1/2* s1);
    s2 = h * f(t(i)+1/2*h , z(i)+1/2*k1 , v(i)+1/2*s1);
    
    k3 = h * (v(i) + 1/2* s2);
    s3 = h * f(t(i)+1/2*h , z(i)+1/2*k2 , v(i)+1/2*s2);
    
    k4 = h * (v(i) + s3);
    s4 = H * f(t(i)+h , z(i)+k3 , v(i)+s3);
    
    z(i+1) = z(i)+1/6*(k1+2*k2+2*k3+k4);
    
    v(i+1) = v(i)+1/6*(s1+2*s2+2*s3+s4);
end
end
