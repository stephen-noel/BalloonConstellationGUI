% http://12000.org/my_notes/mma_matlab_control/KERNEL/KEse159.htm#x164-2050004.22

clear;
clc;

realCD = .47;
BMass = 12; %kg
PMass = 11; %kg
GVol = 50; % m^3
dz = 0; %initial change in altitude is 0 meters
vol = GVol; %the initial balloon volume is equal to the amount of air pumped in. (m^3)
dVol = 0; %the change of the volume is initally 0
r = 287; %This is the gas constant. Units are J/(kgK). 
Mb = 4.0026; %This is the molecular weight of the balloon gas (Helium)
p = 101325;%This is the inital atmospheric pressure (Pa) or kg/ms^2
temp = 15; %This is the initial temperature Celsius
tempK = temp + 273.15; % This is the temperature in Kelvin
RhoA = p/(.2869*tempK); %This is the density of air (kg/m^3) https://www.grc.nasa.gov/www/k-12/airplane/atmosmet.html
Wg = Mb*p*vol/(r*tempK);
Wf = BMass*9.81; % This is the weight of the balloon in Newtons (Bmass is in kg)
Wp = PMass*9.81; % This is the weight of the payload in Newtons
cb = 0.55; % This is the apparent additional mass coefficient for balloons based on a study from UMich in 1995
g = 9.81; % acceleration caused by gravity (m/sec^2)
dt = 1;
radius = ((3/(4*pi))*vol)^(1/3);


t = 10800;
%Initial conditions
z0 = 1;
v0 = 0;
z(1) = z0;
v(1) = v0;
h = 1;

N = t - 1;
mass = PMass+BMass+Mb;
for i = 1:N
    
         oldTemp = temp;
    oldTempK = tempK; % https://www.grc.nasa.gov/www/k-12/airplane/atmosmet.html
    if (z <= 11000) %Meters (Troposhpere)
        temp = 15.04 - 0.00649*z; 
        tempK = temp + 273.15;
        p = 101.29*((temp+273.1)/(288.08)).^5.256; %kPa
        
    elseif (z > 11000 && z < 25000) %Meters (Lower Stratosphere)
        temp = -56.46;
        tempK = temp + 273.15;
        p = 22.65*exp(1.73-0.000157*z); %kPa
        
    else %Upper Stratosphere
        temp = -131.21 + 0.00299*z; 
        tempK = temp + 273.15;
        p = 2.488 * ((temp+273.1)/216.6).^-11.388; %kPa
    end

    dTemp = abs(temp - oldTemp);
    dTempK = abs(tempK - oldTempK); 
    
    RhoA = (p/(.2869*tempK))*9.81; %This is the density of air which needs to be updated. [kg/m^2s^2] Newtons per meter.
                                   % RhoA needs to be in Newtons per meter for the calculation in C
    Wg = Mb.*(1000*p).*vol/(r.*tempK); %The weight of the gas has to be updated for the new temperature
    
    radius = ((3/(4*pi))*vol).^(1/3);
    Ca = pi*radius.^2;
    
    f = @(z,v,t) (g*(RhoA*vol-mass)-.5*RhoA*realCD*v(i)*abs(v(i))*Ca)/(mass+cb*RhoA*vol);
    
    
    k1 = h * v(i);
    s1 = h * f(t(i), z(i), v(i));
    
    k2 = h * (v(i) + 1/2* s1);
    s2 = h * f(t(i)+1/2*h , z(i)+1/2*k1 , v(i)+1/2*s1);
    
    k3 = h * (v(i) + 1/2* s2);
    s3 = h * f(t(i)+1/2*h , z(i)+1/2*k2 , v(i)+1/2*s2);
    
    k4 = h * (v(i) + s3);
    s4 = h * f(t(i)+h , z(i)+k3 , v(i)+s3);
    
    z(i+1) = z(i)+1/6*(k1+2*k2+2*k3+k4);
    
    v(i+1) = v(i)+1/6*(s1+2*s2+2*s3+s4);

end

t = 1:length(z);
scatter(t,z,'filled');

title('Altitude versus Time')
xlabel('Time [seconds]')
ylabel('Altitude [meters]')
