%% BalloonNumCalc
% Julianna Evans
% 06.29.17

% Calculate the number of cameras (balloons) required to cover designated
% area

function [BalloonNumforCalc] = BalloonNumCalc(flen,floatalt2,minLat,minLon,maxLat,maxLon)
%% FOVcoverage
xsensor = 36;       % Width of sensor, [mm]
ysensor = 24;       % Height of sensor, [mm]

% Degrees of Field of View
fov_wide = 2*atand( xsensor/(2*flen) );  % [deg]
fov_tall = 2*atand( ysensor/(2*flen) );  % [deg]

% Distances from camera to the four corners of the ground frame
dist_bottom = floatalt2*tand(-0.5*fov_wide);  % [m]   
dist_top = floatalt2*tand(0.5*fov_wide);      % [m]
dist_left = floatalt2*tand(-0.5*fov_tall);    % [m]
dist_right = floatalt2*tand(0.5*fov_tall);    % [m]

% Ground distance along height and width
xrange = dist_right - dist_left;   % [m]
yrange = dist_top - dist_bottom;   % [m]


%% Calculations
totalXrange = maxLat - minLat;
totalYrange = maxLon - minLon;

numX = totalXrange/xrange;
numY = totalYrange/yrange;

if numX < numY
    BalloonNumforCalc = numX;
else
    BalloonNumforCalc = numY;
end

end