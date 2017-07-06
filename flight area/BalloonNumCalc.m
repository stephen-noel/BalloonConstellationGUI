%% BalloonNumCalc
% Julianna Evans
% 06.29.17

% Calculate the number of cameras (balloons) required to cover designated
% area

function [BalloonNumforCalc] = BalloonNumCalc(flen,floatalt2,minLat,minLon,maxLat,maxLon)
% INPUTS: 
    %flen ---------- focal length multiplier
    %floatalt2 ----- float altitude
    %minLat -------- minimum latitude
    %minLon -------- minimum longitude
    %maxLat -------- maximum latitude
    %maxLon -------- maximum longitude
% OUTPUTS:
    %BalloonNumforCalc -- number of balloons needed for area coverage

%%

% Error handling
if (minLat < maxLat && minLon < maxLon)

% Constants
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

%IF-ELSE: choose highest value of balloons needed to cover X or Y regions
if numX > numY
    BalloonNumforCalc = numX;
else
    BalloonNumforCalc = numY;
end


else
    warndlg('Minimum Lat/Lon must be less than maximum Lat/Lon.'); %ELSE from error handling IF-ELSE statement
end
end