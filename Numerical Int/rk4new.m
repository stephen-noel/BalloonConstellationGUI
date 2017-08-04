% Runge-Kutta 4th order to solve 2nd order equation
%z" = (g*(RhoA*vol-mass)-.5*RhoA*realCD*z'*abs(z')*Ca)/(mass+cb*RhoA*vol);
clear;
clc;
%Constants
realCD = .3;
BMass = 12; %kg
PMass = 100; %kg
r = 8.314; 
MW = 4.0026; %molecular weight/molecular mass
cb = 0.55; % This is the apparent additional mass coefficient for balloons based on a study from UMich in 1995
g = 9.81;
GVol = 2; % m^3



% Step size
h=.1;
tfinal=10000;
N=ceil(tfinal/h);% ceil rounds up


% Initial conditions
t(1)=0;
z(1)=0;
v(1)=0;
vol = GVol;
temp = 15; % Celsius
tempK = temp + 273.15; %Kelvin
p = 101.325; %kPa
radius = ((3/(4*pi))*vol)^(1/3);
RhoA = p/(.2869*tempK);
Ca = pi*radius.^2;
Wg = MW*(1000*p).*vol/(8.314*tempK); %comes out in kg [correct] | multiply p by 1000 to get to [Pa]
mass = PMass+BMass+Wg;


% Update loop
for i=1:N-1
    
    % Define function handle
    f=@(v) (g*(RhoA*vol-mass)-.5*RhoA*realCD*v*abs(v)*Ca)/(mass+cb*RhoA*vol);
    
    % Update atmosphere properties
    oldpress = p;
    
    oldTemp = temp;
    oldTempK = tempK; % https://www.grc.nasa.gov/www/k-12/airplane/atmosmet.html
    if (z(i) <= 11000) %Meters (Troposhpere)
         temp = 15.04 - 0.00649*z(i); 
         tempK = temp + 273.15;
         p = 101.29*((tempK)/(288.08))^5.256; %kPa
       
    elseif (z(i) > 11000 && z(i) < 25000) %Meters (Lower Stratosphere)
         temp = -56.46;
         tempK = temp + 273.15;
         p = 22.65*exp(1.73-0.000157*z(i)); %kPa
        
    else %Upper Stratosphere
         temp = -131.21 + 0.00299*z(i); 
         tempK = temp + 273.15;
         p = 2.488 * ((tempK)/216.6)^-11.388; %kPa
    end
    
    % Update Variables
    dTempK = abs(tempK - oldTempK);
    RhoA = (p/(.2869*tempK)); %[kg/m^3]
    Wg = MW*(1000*p)*vol/(8.314*tempK); %kg [correct]
    radius = ((3/(4*pi))*vol)^(1/3);
    Ca = pi*radius^2;
    old_z = z(i);
    
    dpress = p-oldpress;

    
    
    
        % Update time
        t(i+1)=t(i)+h;
        
        % Fourth Order
        k1 = h * v(i);
        s1 = h * f(v(i));
    
        k2 = h * (v(i) + (1/2* s1));
        s2 = h * f(v(i)+1/2*s1);
    
        k3 = h * (v(i) + (1/2* s2));
        s3 = h * f(v(i)+(1/2*s2));
    
        k4 = h * (v(i) + s3);
        s4 = h * f(v(i)+s3);
    
        z(i+1) = z(i)+(1/6)*(k1+(2*k2)+(2*k3)+k4);
    
        v(i+1) = v(i)+(1/6)*(s1+(2*s2)+(2*s3)+s4);
        

    dt = h;    
    dz = z(i) - old_z;
    dVol = (8.314/(p*MW))*((Wg*dTempK/dt)*dt + (RhoA/p)*(vol)*dz);
    %if t(i)<=10800
        vol = vol + dVol;
    %else
        %vol = vol - 10;
    %end
end

% Plot
plot(t,z)
xlabel('Time [s]')
ylabel('Altitude [m]')
title('Altitude vs Time')

