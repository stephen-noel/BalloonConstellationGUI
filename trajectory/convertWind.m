%% convertWind
% Converts NOAA ADDS wind data (.*txt) into MATLAB variables
% inputs are user inputs
% outputs are what x(aka v) y(aka u) wind speeds NOAA gives us

function [time, latitude, longitude] = convertWind(scenarioStartTime, launchLat, launchLon)

load WindData_NOMADS_GFS;

WindData_NOMADS_GFS = table(ugrd_3658m, vgrd_3658m,'RowNames',XY);
summary(WindData_NOMADS_GFS);
T1 = WindData_NOMADS_GFS(1:2,:);

windspeed = sqrt((ugrd_3658m)^2+(vgrd_3658m)^2); %m/s
direction = atan2(norm(cross(ugrd_3658m,vgrd_3658m)),dot(ugrd_3658m,vgrd_3658m)); %in degrees



for time = 0:1:10800
  latitude = vgrd_3658m * time;
  longitude = ugrd_3658m * time;
end


  

% use variables windspeed with direction for trajectory calculations

% OUTPUTS: TIME, LONGITITUDE, LATITUDE, ALTITUDE ~ global variables




end
