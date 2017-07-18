%% Vertical Balloon Dynamics Script (hardcoded inputs)
% 07.18.17


clc; clear;

%Hard-coded function variables
realCD = .47;           %coefficient of drag, []
BMass = 200;            %Mass of balloon, [kg]
PMass = 50;             %Mass of payload, [kg]
GVol = 200;             %Volume of Gas (initial), [m^3]

%Variables and Constants
z = 1;                  %initial altitude, [m]
dz = 0;                 %initial change in altitude
vol = GVol;             %the initial balloon volume is equal to the amount of air pumped in, [m^3]
dVol = 0;               %the change of the volume is initally 0
r = 287;                %gas constant, [J/(kgK)]  
Mb = 4.0026;            %molecular weight of the balloon gas (Helium)
p = 101325;             %Inital atmospheric pressure [Pa] or [kg/ms^2]
temp = 15;              %Initial temperature, [C]
tempK = temp + 273.15;  %Temperature, [K]
RhoA = p/(287*tempK);   %Density of air [kg/m^3]
Wg = Mb*p*vol/(r*tempK);
Wf = BMass*0.0098;      %Weight of the balloon, [Newtons] (Bmass is in grams)
Wp = PMass*0.0098;      %Weight of the payload, [Newtons]
cb = 0.55;              %Apparent additional mass coefficient for balloons (based on a study from UMich in 1995)
g = 9.81;               %Acceleration caused by gravity [m/s^2]
dt = 1;                 %timestep intialization
radius = ((3/(4*pi))*vol)^(1/3);

%Duration of float mode (GUI input -- get string)
float_dur = 22; % [s]

%Ascent/Float/Descent Timestep Intervals (modify structure based on power control??)
start_asc = 1;                  %ascending
stop_asc = 75;                  %ascending

start_fl = stop_asc;            %float    
stop_fl = start_fl + float_dur; %float

start_dec = stop_fl;            %descending
stop_dec = start_dec + 154;     %descending


%---- ASCENT ----
for t_asc = start_asc:stop_asc
    
    
    oldTemp = temp;
    oldTempK = tempK; % https://www.grc.nasa.gov/www/k-12/airplane/atmosmet.html
    
    %Atmospheric parameters
    if (z <= 11000)                     %Meters (Troposhpere)
        temp = 15.04 - 0.00649*z; 
        tempK = temp + 273.15;
        p = 101.29*((temp+273.1)/(288.08)).^5.256;
    elseif (z > 11000 && z < 25000)     %Meters (Lower Stratosphere)
        temp = -56.46;
        tempK = temp + 273.15;
        p = 22.65*exp(1.73-0.000157*z);
    else                                %Upper Stratosphere
        temp = -131.21 + 0.00299*z; 
        tempK = temp + 273.15;
        p = 2.488 * ((temp+273.1)/216.6)^-11.388;
    end

    dTemp = abs(temp - oldTemp);
    dTempK = abs(tempK - oldTempK); 
    
    RhoA = (p/(.2869*(temp+273.1)))*9.81; %Density of Air, needs to be updated for new temperature
    Wg = Mb.*p.*vol/(r.*tempK); %Weight of the gas, needs to be updated for the new temperature
    
    radius = ((3/(4*pi))*vol).^(1/3);
    Ca = pi*radius.^2;   
    
    %Differential Equation Constants
    A = (Wp + Wf + Wg + cb.*p.*vol); 
    B = (1/2*g * realCD * RhoA * Ca); 
    C = (RhoA*vol - Wg - Wp - Wf);
    
    old_z = z;
    
    %Altitude Array
    z = (A/C).*log(cosh( (sqrt(B).*sqrt(C).*t_asc)/A) );
    z_array(t_asc) = z;
    
    dz = z - old_z;  %Change in altitude from the last second
    
    %Change in Volume, New Volume
    dVol = (r/(p*Mb))*(Wg*dTempK/dt)*dt + (RhoA/p)*(vol)*dz;
    vol = vol + dVol; 
    
    
end


%---- FLOAT ----
last_asc_idx = t_asc;                 %get value of the "balloon" at the last time step
float_alt = z_array(last_asc_idx);    %set float_alt to value at end of ascent

%Loop through timestep and set as constant float_alt
for t = start_fl:stop_fl
    z = float_alt;
    z_array(t) = z;
end


%---- DESCENT ----
for t = start_dec:stop_dec
    
    
    oldTemp = temp;
    oldTempK = tempK; % https://www.grc.nasa.gov/www/k-12/airplane/atmosmet.html
    
    %Altitude Parameters
    if (z <= 11000)                     %Meters (Troposhpere)
        temp = 15.04 - 0.00649*z; 
        tempK = temp + 273.15;
        p = 101.29*((temp+273.1)/(288.08))^5.256;  
    elseif (z > 11000 && z < 25000)     %Meters (Lower Stratosphere)
        temp = -56.46;
        tempK = temp + 273.15;
        p = 22.65*exp(1.73-0.000157*z);
    else                                %Upper Stratosphere
        temp = -131.21 + 0.00299*z; 
        tempK = temp + 273.15;
        p = 2.488 * ((temp+273.1)/216.6)^-11.388;
    end

    %Change in temperature
    dTemp = abs(temp - oldTemp);
    dTempK = abs(tempK - oldTempK); 
    
    RhoA = (p/(.2869*(temp+273.1)))*9.81; %Density of air, needs to be updated for the new temperature
    Wg = Mb*p*vol/(r*tempK); %Weight of the gas, needs to be updated for the new temperature
    
    radius = ((3/(4*pi))*vol)^(1/3);
    Ca = pi*radius^2;   
    
    %Differential Equation Constants
    A = (Wp + Wf + Wg + cb*p*vol); 
    B = (1/2*g * realCD * RhoA * Ca); 
    C = (RhoA*vol - Wg - Wp - Wf);
    
    old_z = z;    
    
    %Altitude Array
    z = -(A/C)*log(cosh( (sqrt(B)*sqrt(C)*t)/A) );
    z_array(t) = z;
    
    dz = z - old_z; %this is the change in altitude from the last second
    
    %Change in Volume
    dVol= (r/(p*Mb))*(Wg*dTempK/dt)*dt + (RhoA/p)*(vol)*dz;
    vol = vol + dVol; 
    
end

%{
%Scatter plot for Altitude
t = 1:length(z_array);
scatter(t,z_array,'filled');
%}


%Scatter plot for real component (just a working hack for now)
t = 1:length(z_array);
realz_array = real(z_array);
scatter(t,realz_array,'filled');


