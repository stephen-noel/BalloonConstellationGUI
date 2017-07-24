%% convertWind
% Converts NOAA ADDS wind data (.*txt) into MATLAB variables
% inputs are user inputs
% outputs are what x(aka v) y(aka u) wind speeds NOAA gives us

function [time, latitude, longitude] = convertWind(scenarioStartTime, launchLat, launchLon)

load WindData_NOMADS_GFS;

WindData = table(ugrd_3658m, vgrd_3658m,'RowNames',XY);
summary(WindData);
T1 = WindData(1:2,:);

windspeed = sqrt((ugrd_3658m)^2+(vgrd_3658m)^2); %m/s
direction = atan2(norm(cross(ugrd_3658m,vgrd_3658m)),dot(ugrd_3658m,vgrd_3658m)); %in degrees



for time = 0:1:10800 %%in seconds

latitude(t) = launchLat + uvel.*time;
longitude(t) = launchLon + vvel.*time;


end



  

% use variables windspeed with direction for trajectory calculations

% OUTPUTS: TIME, LONGITITUDE, LATITUDE, ALTITUDE ~ global variables




end
