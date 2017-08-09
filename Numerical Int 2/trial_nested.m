clear
clc
dz=0;
vol=4;
tempK = 288;
[t,x]=ode45(@(t,x) nestedfunctions(t,x,vol),[0,15000],[1,0]);
%plot(t,x(:,1))
