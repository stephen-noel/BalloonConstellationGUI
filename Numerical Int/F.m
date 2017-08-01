%command line: [t,x]=ode45('F',[0,10800],[1,0]);
% plot(t,x(:,1))

function xp = F(t,x)
%Initial conditions
realCD = .47;
BMass = 12; %kg
PMass = 11; %kg
GVol = 100; % m^3
z = 0; %initial altitude in meters
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
mass = PMass+BMass+Mb;

    
    persistent old_z;
    z = x(1);
    dz = z - old_z;
    old_z = z; % set the value of old_z for next timestep
    
    % calculate variable parameters
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
    
    RhoA = (p/(.2869*tempK));
       
    Wg = Mb.*(1000*p).*vol/(r.*tempK);
    
    radius = ((3/(4*pi))*vol).^(1/3);
    Ca = pi*radius.^2;

    xp = zeros(2,1);
    xp(1) = x(2);
    xp(2) = (g*(RhoA*vol-mass)-.5*RhoA*realCD*x(2)*abs(x(2))*Ca)/(mass+cb*RhoA*vol);

    dz = z - old_z; %this is the change in altitude from the last second

    dVol = (r/(p*Mb))*(Wg*dTempK/dt)*dt + (RhoA/p)*(vol)*dz;

    vol = vol +dVol;


end
