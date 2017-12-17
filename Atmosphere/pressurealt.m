%% pressurealt.m
% Julianna Evans
% 07.25.17

%% Function converts pressure altitude to pressure
% Purpose of this is to get the altitude in m and convert into a pressure,
% in order to match the closest dataset index.


% based off of equation and matlab script from: 
% 'https://physics.stackexchange.com/questions/14678/pressure-at-a-given-altitude'

function [pressure_mbar] = pressurealt(h)

p0 = 101325;      %Sea-level standard atmospheric pressure, [Pa]  
L = 0.0065;       %Temperature Lapse Rate, [K/m]
T0 = 288.15;      %Sea-level Standard Temperature, [K]
g = 9.80665;      %Earth-surface gravitational acceleragion, [m/s^2]
M = 0.0289644;    %Molar Mass of Dry Air, [kg/mol]
R = 8.31447;      %Universal Gas Constant, [J/(mol*K)]

%Equation Simplification Constants
A = (g*M)/(R*L);
B = L/T0;

pressure_Pa = p0.*(1-B.*h).^A;       %Pressure, [Pa]
pressure_mbar = pressure_Pa*0.01;    %Pressure, [mbar]

end

