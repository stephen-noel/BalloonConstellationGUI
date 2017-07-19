%% convertWind
% Converts NOAA ADDS wind data (.*txt) into MATLAB variables
% inputs are user inputs
% outputs are what x(aka u) y(aka v) wind speeds NOAA gives us

function [windspeed, ugrd_3658m, vgrd_3658m] = convertWind(scenarioStartTime, launchLat, launchLon)

load WindData_NOMADS_GFS;

WindData_NOMADS_GFS = table(ugrd_3658m, vgrd_3658m,'RowNames',XY);
summary(WindData_NOMADS_GFS);
T1 = WindData_NOMADS_GFS(1:2,:)

windspeed = sqrt((ugrd_3658m)^2+(vgrd_3658m)^2) %m/s
direction = atan2(norm(cross(ugrd_3658m,vgrd_3658m)),dot(ugrd_3658m,vgrd_3658m)); %in degrees

%use variables from T1 (ugrd_3658m and vgrd_3658m) and windspeed for trajectory



% NOTE: inputs and outputs are placeholders





end
