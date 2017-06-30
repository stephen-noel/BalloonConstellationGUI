%% Temp and Density according to altitude
%http://www.engineeringtoolbox.com/standard-atmosphere-d_604.html

function [Temp,AirDensity] = TempDensity_SI(z)
% NOTE: z is altitude in meters, Temp is in Celsius and Density is kg/m^3
if z < 1000
    Temp = 15; %Celsius
    AirDensity = 12.25*10^(-1); %kg/m^3
elseif z >= 1000 && z < 2000
    Temp = 8.50;
    AirDensity = 11.12*10^(-1);
elseif z >= 2000 && z < 3000
    Temp = 2;
    AirDensity =10.07*10^(-1);
elseif z >= 3000 && z<4000
    Temp = -4.49;
    AirDensity = 9.093*10^(-1);
elseif z >= 4000 && z < 5000
    Temp = -10.98;
    AirDensity = 8.194*10^(-1);
elseif z >= 5000 && z < 6000
    Temp = -17.47;
    AirDensity = 7.364*10^(-1);
elseif z >= 6000 && z < 7000
    Temp = -23.96;
    AirDensity = 6.601*10^(-1);
elseif z >= 7000 && z < 8000
    Temp = -30.45;
    AirDensity = 5.9*10^(-1);
elseif z >= 8000 && z < 9000
    Temp = -36.94;
    AirDensity = 5.258*10^(-1);
elseif z >= 9000 && z < 10000
    Temp = -43.42;
    AirDensity = 4.671*10^(-1);
elseif z >= 10000 && z < 15000
    Temp = -49.9;
    AirDensity =4.135*10^(-1);
elseif z >= 15000 && z < 20000
    Temp = -56.5;
    AirDensity = 1.948*10^(-1);
elseif z >= 20000 && z < 25000
    Temp = -56.5;
    AirDensity = .8891*10^(-1);
elseif z >= 25000 && z < 30000
    Temp = -51.6;
    AirDensity = .4008*10^(-1);
elseif z >= 30000 && z < 40000
    Temp = -46.64;
    AirDensity = .1841*10^(-1);
elseif z >= 40000 && z < 50000
    Temp = -22.8;
    AirDensity = .03996*10^(-1);
elseif z >= 50000 && z < 60000
    Temp = -2.5;
    AirDensity = .01027*10^(-1);
elseif z >= 60000 && z < 70000
    Temp = -26.13;
    AirDensity = .003097*10^(-1);
elseif z >= 70000 && z < 80000
    Temp = -53.57;
    AirDensity = .0008283*10^(-1);
elseif z >= 80000
    Temp = -74.51;
    AirDensity = .0001846*10^(-1);
end



end
