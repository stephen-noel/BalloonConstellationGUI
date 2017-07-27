function [z,v,t] = rktest( )

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
Ca = pi*radius.^2;
mass = PMass+BMass+Mb;

h = 1;
t = 0:200;
N = length(t);
z = zeros(N,1);
v = zeros(N,1);
z(1) = 1;
v(1) = 0;


for i = 1:(N-1)   
    
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
end
    function Q=f(v)
        function [RhoA,Ca,vol]=inputs(z)%need current conditions
                vol = GVol;
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
    
            RhoA = (p/(.2869*tempK))*9.81;
            Wg = Mb.*(1000*p).*vol/(r.*tempK);
    
            radius = ((3/(4*pi))*vol).^(1/3);
            Ca = pi*radius.^2;
            old_z = z;
            dz = z - old_z;
            dVol = (r/(p*Mb))*(Wg*dTempK/dt)*dt + (RhoA/p)*(vol)*dz;
            vol = vol + dVol;

        end
        [RhoA,Ca,vol]=inputs(z);
        Q=(g*(RhoA*vol-mass)-.5*RhoA*realCD*v*abs(v)*Ca)/(mass+cb*RhoA*vol);
    end
plot(t,z)
end
