%% Temp and Density according to altitude

function [Temp,AirDensity] = TempDensity_Imperial(z)
% NOTE: z is altitude in feet, Temp is in Fahrenheit and Density is
% slugs/ft^3
if z < 5000
    Temp = 59;
    AirDensity = 23.77*10^(-4);
elseif z >= 5000 && z < 10000
    Temp = 41.17;
    AirDensity = 20.48*10^(-4);
elseif z >= 10000 && z < 15000
    Temp = 23.36;
    AirDensity =17.56*10^(-4);
elseif z >= 15000 && z< 20000
    Temp = 5.55;
    AirDensity = 14.96*10^(-4);
elseif z >= 20000 && z < 25000
    Temp = -12.26;
    AirDensity = 12.67*10^(-4);
elseif z >= 25000 && z < 30000
    Temp = -30.05;
    AirDensity = 10.66*10^(-4);
elseif z >= 30000 && z < 35000
    Temp = -47.83;
    AirDensity = 8.91*10^(-4);
elseif z >= 35000 && z < 40000
    Temp = -65.61;
    AirDensity = 7.38*10^(-4);
elseif z >= 40000 && z < 45000
    Temp = -69.70;
    AirDensity = 5.87*10^(-4);
elseif z >= 45000 && z < 50000
    Temp = -69.70;
    AirDensity = 4.62*10^(-4);
elseif z >= 50000 && z < 60000
    Temp = -69.70;
    AirDensity = 3.64*10^(-4);
elseif z >= 60000 && z < 70000
    Temp = -69.70;
    AirDensity = 2.26*10^(-4);
elseif z >= 70000 && z < 80000
    Temp = -67.42;
    AirDensity = 1.39*10^(-4);
elseif z >= 80000 && z < 90000
    Temp = -61.98;
    AirDensity = .86*10^(-4);
elseif z >= 90000 && z < 100000
    Temp = -56.54;
    AirDensity = .56*10^(-4);
elseif z >= 100000 && z < 150000
    Temp = -51.1;
    AirDensity = .33*10^(-4);
elseif z >= 150000 && z < 200000
    Temp = 19.4;
    AirDensity = .037*10^(-4);
elseif z >= 200000 && z < 250000
    Temp = -19.78;
    AirDensity = .0053*10^(-4);
elseif z >= 250000
    Temp = -88.77;
    AirDensity = .00065*10^(-4);
end



end