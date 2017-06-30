%% FOVcoverage
% Julianna Evans
% 06.29.17

% Calculate the rectangular region of ground covered by one camera pointing directly down

function [xrange, yrange] = FOVcoverage(flen,flenmult,imgrat,alt)
% NOTE: inputs and outputs are placeholders

% modified from: 'https://photo.stackexchange.com/questions/56596/how-do-i-calculate-the-ground-footprint-of-an-aerial-camera'

%% Variables
xsensor = 36;       % Width of sensor, [mm]
ysensor = 24;       % Height of sensor, [mm]
flen = 20;          % Focal length of lens, [mm]
alt = 100;          % Altitude, [m]
xgimbal = 0;       % X-gimbal angle, [deg]
ygimbal = 0;       % Y-gimbal angle, [deg]


%% Calculations

% Degrees of Field of View
fov_wide = 2*atand( xsensor/(2*flen) );  % [deg]
fov_tall = 2*atand( ysensor/(2*flen) );  % [deg]

% Distances from drone to the four corners of the ground frame
dist_bottom = alt*tand(-0.5*fov_wide);  % [m]   
dist_top = alt*tand(0.5*fov_wide);      % [m]
dist_left = alt*tand(-0.5*fov_tall);    % [m]
dist_right = alt*tand(0.5*fov_tall);    % [m]

% Ground distance along height and width
xrange = dist_right - dist_left;   % [m]
yrange = dist_top - dist_bottom;   % [m]

end