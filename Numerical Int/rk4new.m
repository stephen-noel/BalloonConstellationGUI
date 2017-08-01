% Runge-Kutta 4th order to solve 2nd order equation
%z" = (g*(RhoA*vol-mass)-.5*RhoA*realCD*z'*abs(z')*Ca)/(mass+cb*RhoA*vol);
clear;
clc;
%Constants
realCD = .47;
BMass = 12; %kg
PMass = 11; %kg
r = 287; 
Mb = 4.0026;
cb = 0.55; % This is the apparent additional mass coefficient for balloons based on a study from UMich in 1995
g = 9.81;
GVol = 50; % m^3

mass = PMass+BMass+Mb;

% Step size
h=.01;
tfinal=20000;
N=ceil(tfinal/h);% ceil rounds up


% Initial conditions
t(1)=0;
z(1)=0;
v(1)=0;
vol(1) = GVol;
temp(1) = 15; % Celsius
tempK(1) = temp(1) + 273.15; %Kelvin
p(1) = 101325;
radius(1) = ((3/(4*pi))*vol(1))^(1/3);
RhoA(1) = p(1)/(.2869*tempK(1));
Ca(1) = pi*radius(1).^2;
Wg(1) = Mb.*(1000*p(1)).*vol(1)/(r.*tempK(1));



% Update loop
for i=1:N
    
    % Define function handle
    f=@(v) (g*(RhoA(i)*vol(i)-mass)-.5*RhoA(i)*realCD*v*abs(v)*Ca(i))/(mass+cb*RhoA(i)*vol(i));
    
    % Update atmosphere properties
    oldTemp(i) = temp(i);
    oldTempK(i) = tempK(i); % https://www.grc.nasa.gov/www/k-12/airplane/atmosmet.html
    if (z(i) <= 11000) %Meters (Troposhpere)
         temp(i) = 15.04 - 0.00649*z(i); 
         tempK(i) = temp(i) + 273.15;
         p(i) = 101.29*((tempK(i))/(288.08)).^5.256; %kPa
       
    elseif (z(i) > 11000 && z(i) < 25000) %Meters (Lower Stratosphere)
         temp(i) = -56.46;
         tempK(i) = temp(i) + 273.15;
         p(i) = 22.65*exp(1.73-0.000157*z(i)); %kPa
        
    else %Upper Stratosphere
         temp(i) = -131.21 + 0.00299*z(i); 
         tempK(i) = temp(i) + 273.15;
         p(i) = 2.488 * ((tempK(i))/216.6).^-11.388; %kPa
    end
    
    % Update Variables
    dTempK(i) = abs(tempK(i) - oldTempK(i));
    RhoA(i) = (p(i)/(.2869*tempK(i)))*9.81;
    Wg(i) = Mb.*(1000*p(i)).*vol(i)/(r.*tempK(i));
    radius(i) = ((3/(4*pi))*vol(i)).^(1/3);
    Ca(i) = pi*radius(i).^2;
    old_z(i) = z(i);

    
    
    
        % Update time
        t(i+1)=t(i)+h;
        
        % Fourth Order
        k1 = h * v(i);
        s1 = h * f(v(i));
    
        k2 = h * (v(i) + 1/2* s1);
        s2 = h * f(v(i)+1/2*s1);
    
        k3 = h * (v(i) + 1/2* s2);
        s3 = h * f(v(i)+1/2*s2);
    
        k4 = h * (v(i) + s3);
        s4 = h * f(v(i)+s3);
    
        z(i+1) = z(i)+1/6*(k1+2*k2+2*k3+k4);
    
        v(i+1) = v(i)+1/6*(s1+2*s2+2*s3+s4);
        
    temp(i+1)=temp(i);    
    tempK(i+1)=tempK(i);
    dt = h;    
    dz(i) = z(i+1) - old_z(i);
    dVol(i) = (r/(p(i)*Mb))*(Wg(i)*dTempK(i)/dt)*dt + (RhoA(i)/p(i))*(vol(i))*dz(i);
    if t<=10800
        vol(i+1) = vol(i) + dVol(i);
    else
        vol(i+1) = vol(i) - 10;
    end
end

% Plot
plot(t,z)
xlabel('Time [s]')
ylabel('Altitude [m]')
title('Altitude vs Time')

