% Vertical Balloon Dynamics Semi-hardcode (basic function variables,
% hardcoded inputs)

function [realz_at_timestep] = vertTraj(timeidx)

%Hardcoded inputs
realCD = .47;
BMass = .12; %kg
PMass = 11; %kg
GVol = 10; % m^3
z = 1; %initial altitude in meters
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


flag = 0; %use flag to break out of loop when looking for float altitude
%N must be at least 2000 for the float_alt variable to kick in
total_time = 5*24*60*60; %5 days of seconds

for t_asc = 1:total_time
    
    
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
    
    A = (Wp + Wf + Wg + cb.*p.*vol);
    B = (1/2*g * realCD * RhoA * Ca); %kgm/s^4
    C = (RhoA*vol - Wg - Wp - Wf); % kgm/s^2
    
    old_z = z;
    
    
    z = (A/C).*log(cosh( (sqrt(B).*sqrt(C).*t_asc)/A) );
    z_array(t_asc) = z;
    
    dz = z - old_z; %this is the change in altitude from the last second
    
    dVol = (r/(p*Mb))*(Wg*dTempK/dt)*dt + (RhoA/p)*(vol)*dz;
    
    vol = vol + dVol; 
    
    for t_asc=1:100:total_time
        if abs(dz) <= .01
            float_alt = z; 
            flag = 1;
            break;          
       end
    end
    if flag == 1
        break;
    end
end

% Reset variables
realCD = .47;
BMass = .12; %kg
PMass = 11; %kg
GVol = 1000; % m^3
z = 1; %initial altitude in meters
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


float_time = 1000; %seconds




% Power Control


for time = 1:total_time
    
    
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
    
    A = (Wp + Wf + Wg + cb.*p.*vol);
    B = (1/2*g * realCD * RhoA * Ca); %kgm/s^4
    C = (RhoA*vol - Wg - Wp - Wf); % kgm/s^2
    
    old_z = z;
    %ASCENT
    if z < float_alt
        z = (A/C).*log(cosh( (sqrt(B).*sqrt(C).*time)/A) );
        z_array(time) = z;
        time_ascent = time;
        float_stop = time_ascent + float_time; %adjusts when float will stop according to how long you want to float
    
    else
         if time>=time_ascent && time<float_stop
            z = float_alt;
            z_array(time) = z;

         else %time>=float_stop
             break; %breaks out of loop 
         end
    end

    
    dz = z - old_z; %this is the change in altitude from the last second
    
    dVol = (r/(p*Mb))*(Wg*dTempK/dt)*dt + (RhoA/p)*(vol)*dz;
    
    vol = vol + dVol; 
    
end
for time=float_stop:total_time
    z = z-.1; %altitude decreases by .1
    z_array(time) = z;
    if z<0 %makes sure altitude doesn't drop below 0
       z = 0;
       z_array(time) = z;
    end
end
   
%% Real component of altitude array
realz_array = real(z_array);

realz_at_timestep = realz_array(timeidx);

%% Plotting
%Scatter plot
%t = 1:length(z_array);
%scatter(t,z_array,'filled');


%Scatter plot for real component (just a working hack for now)
t = 1:length(z_array);
realz_array = real(z_array);
%scatter(t,realz_array,'filled');   %commented out b/c it's showing up behind panels in the GUI


end