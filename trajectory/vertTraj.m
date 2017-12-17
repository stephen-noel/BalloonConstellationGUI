% Vertical Balloon Dynamics Semi-hardcode (basic function variables,
% hardcoded inputs)

function [altitudeAtTimestep] = vertTraj(timeidx)

%constant rate
rate = 1; %m/s
floatalt = 50000; 

%altitude
altitudeAtTimestep = timeidx*rate;

%if altitude is above float altitude, make it the float altitude
if altitudeAtTimestep > floatalt
    altitudeAtTimestep = floatalt;
end

end