%% AreaCalc
% Julianna Evans
% 06.29.17

% Area that can be covered with N balloons at a given altitude

function [totalXArea,totalYArea] = AreaCalc(flen,floatalt1,nballoons)
% INPUTS: 
    %flen ---------- focal length multiplier
    %floatalt1 ----- float altitude
    %nballoons ----- minimum latitude
% OUTPUTS:
    %totalXArea ---- range of X area that can be covered 
    %totalYArea ---- range of Y area that can be covered
    
%%

% Camera Sensor 
xsensor = 36;       % Width of sensor, [mm]
ysensor = 24;       % Height of sensor, [mm]

% Degrees of Field of View
fov_wide = 2*atand( xsensor/(2*flen) );  % [deg]
fov_tall = 2*atand( ysensor/(2*flen) );  % [deg]

% Distances from camera to the four corners of the ground frame
dist_bottom = floatalt1*tand(-0.5*fov_wide);  % [m]   
dist_top = floatalt1*tand(0.5*fov_wide);      % [m]
dist_left = floatalt1*tand(-0.5*fov_tall);    % [m]
dist_right = floatalt1*tand(0.5*fov_tall);    % [m]

% Ground distance along height and width
xrange = dist_right - dist_left;   % [m]
yrange = dist_top - dist_bottom;   % [m]


%% Calculations
totalXArea = xrange*nballoons;
totalYArea = yrange*nballoons;

end

