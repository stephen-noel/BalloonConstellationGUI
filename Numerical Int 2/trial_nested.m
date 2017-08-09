clear
clc
dz=0;
vol=4;
tempK = 288;

tspan = [0 15000];
x0 = [1 0];

[t,x]=ode45(@(t,x) nestedfunctions(t,x,vol,tempK),tspan,x0);
%plot(t,x(:,1))
