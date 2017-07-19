%% convertWind
% Converts NOAA ADDS wind data (.*txt) into MATLAB variables
% inputs are user inputs
% outputs are what x(aka u) y(aka v) wind speeds NOAA gives us

function [ugrd_3658m, vgrd_3658m] = convertWind(inputlat1,inputlong1)
scenarioStartTime = datetime(d,'InputFormat','YYYYMMDD')
windspeed = sqrt((ugrd_3658m)^2+(vgrd_3658m)^2)
inputlat1 = 
inputlong1 = 



% NOTE: inputs and outputs are placeholders





end
