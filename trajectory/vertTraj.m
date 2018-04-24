%% vertTraj.m
% Author: Julianna Evans
% Date: 07.24.17
% Last Revision: 12.16.17

% Calculates a basic vertical balloon dynamics model with a 
% linear-ascent-and-float trajectory. Includes some hardcoded 
% inputs (semi-hardcode).

function [altitudeAtTimestep] = vertTraj(timeidx)

%constant rate
rate = 1/3600; %m/s
floatalt = 50; %m

%altitude
altitudeAtTimestep = timeidx*rate;

%if altitude is above float altitude, make it the float altitude
if altitudeAtTimestep > floatalt
    altitudeAtTimestep = floatalt;
end

end