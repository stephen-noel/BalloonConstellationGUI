% Linear Differential Equation Plot
clc; clear;

realCD = .47;
BMass = 200;
PMass = 50;
GVol = 200;
z = 1; %initial altitude in meters
dz = 0; %initial change in altitude is 0 meters
vol = GVol; %the initial balloon volume is equal to the amount of air pumped in. (m^3)
dVol = 0; %the change of the volume is initally 0
r = 287; %This is the gas constant. Units are J/(kgK). 
Mb = 4.0026; %This is the molecular weight of the balloon gas (Helium)
p = 101325;%This is the inital atmospheric pressure (Pa) or kg/ms^2
temp = 15; %This is the initial temperature Celsius
tempK = temp + 273.15; % This is the temperature in Kelvin
RhoA = p/(287*tempK); %This is the density of air (kg/m^3)
Wg = Mb*p*vol/(r*tempK);
Wf = BMass*0.0098; % This is the weight of the balloon in Newtons (Bmass is in grams)
Wp = PMass*0.0098; % This is the weight of the payload in Newtons
cb = 0.55; % This is the apparent additional mass coefficient for balloons based on a study from UMich in 1995
g = 9.81; % acceleration caused by gravity (m/sec^2)
dt = 1;
radius = ((3/(4*pi))*vol)^(1/3);





%Constants
%A = 60;
%B = 60;
%C = 60;

float_dur = 22; % [s]

%Intervals
start_asc = 1;                  %ascending
stop_asc = 75;                 %ascending

start_fl = stop_asc;            %float    
stop_fl = start_fl + float_dur; %float

start_dec = stop_fl;            %descending
stop_dec = start_dec + 154;     %descending


%---- ASCENT ----
for t_asc = start_asc:stop_asc
    
    
     oldTemp = temp;
    oldTempK = tempK; % https://www.grc.nasa.gov/www/k-12/airplane/atmosmet.html
    if (z <= 11000) %Meters (Troposhpere)
        temp = 15.04 - 0.00649*z; 
        tempK = temp + 273.15;
        p = 101.29*((temp+273.1)/(288.08)).^5.256;
        
    elseif (z > 11000 && z < 25000) %Meters (Lower Stratosphere)
        temp = -56.46;
        tempK = temp + 273.15;
        p = 22.65*exp(1.73-0.000157*z);
        
    else %Upper Stratosphere
        temp = -131.21 + 0.00299*z; 
        tempK = temp + 273.15;
        p = 2.488 * ((temp+273.1)/216.6)^-11.388;
    end

    dTemp = abs(temp - oldTemp);
    dTempK = abs(tempK - oldTempK); 
    
    RhoA = (p/(.2869*(temp+273.1)))*9.81; %This is the density of air which needs to be updated. 9.81 is the conversion factor between kg and Newtons.

    Wg = Mb.*p.*vol/(r.*tempK); %The weight of the gas has to be updated for the new temperature
    
    radius = ((3/(4*pi))*vol).^(1/3);
    Ca = pi*radius.^2;   
    
    A = (Wp + Wf + Wg + cb.*p.*vol); 
    B = (1/2*g * realCD * RhoA * Ca); 
    C = (RhoA*vol - Wg - Wp - Wf);
    
    old_z = z;
    
    
    z = (A/C).*log(cosh( (sqrt(B).*sqrt(C).*t_asc)/A) );
    z_array(t_asc) = z;
    
    dz = z - old_z; %this is the change in altitude from the last second
    
    dVol = (r/(p*Mb))*(Wg*dTempK/dt)*dt + (RhoA/p)*(vol)*dz;
    
    vol = vol + dVol; 
    
    
end


%---- FLOAT ----
last_asc_idx = t_asc;           %get value of the "balloon" at the last time step
float_alt = z(last_asc_idx);    %set float_alt to value at end of ascent

for t = start_fl:stop_fl
    z = float_alt;
    z_array(t) = z;
end


%---- DESCENT ----
for t = start_dec:stop_dec
    
    
         oldTemp = temp;
    oldTempK = tempK; % https://www.grc.nasa.gov/www/k-12/airplane/atmosmet.html
    if (z <= 11000) %Meters (Troposhpere)
        temp = 15.04 - 0.00649*z; 
        tempK = temp + 273.15;
        p = 101.29*((temp+273.1)/(288.08))^5.256;
        
    elseif (z > 11000 && z < 25000) %Meters (Lower Stratosphere)
        temp = -56.46;
        tempK = temp + 273.15;
        p = 22.65*exp(1.73-0.000157*z);
        
    else %Upper Stratosphere
        temp = -131.21 + 0.00299*z; 
        tempK = temp + 273.15;
        p = 2.488 * ((temp+273.1)/216.6)^-11.388;
    end

    dTemp = abs(temp - oldTemp);
    dTempK = abs(tempK - oldTempK); 
    
    RhoA = (p/(.2869*(temp+273.1)))*9.81; %This is the density of air which needs to be updated. 9.81 is the conversion factor between kg and Newtons.

    Wg = Mb*p*vol/(r*tempK); %The weight of the gas has to be updated for the new temperature
    
    radius = ((3/(4*pi))*vol)^(1/3);
    Ca = pi*radius^2;   
    
    A = (Wp + Wf + Wg + cb*p*vol); 
    B = (1/2*g * realCD * RhoA * Ca); 
    C = (RhoA*vol - Wg - Wp - Wf);
    
    old_z = z;    
    
    z = (start_dec+float_alt)-(A/C)*log(cosh( (sqrt(B)*sqrt(C)*t)/A) );
    z_array(t) = z;
    
     dz = z - old_z; %this is the change in altitude from the last second
    
    dVol= (r/(p*Mb))*(Wg*dTempK/dt)*dt + (RhoA/p)*(vol)*dz;
    
    vol = vol + dVol; 
    
end

%{
%Normal Plot
plot(z_array);
%}

%Scatter plot
t = 1:length(z_array);
scatter(t,z_array,'filled');


%{
%Zeroline
hold on;
zeroline = zeros(length(z_array));
plot(zeroline);
hold off;
%}
%}
