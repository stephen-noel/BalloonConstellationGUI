%% convertWind.m

% Converts wind velocities and initial lat/lon coords to calculate new
% lat/lon coordinates.

function [newLat, newLon] = convertWind(uvel, vvel, oldLat, oldLon)

%Initialized time stuff
timeint = 1;         % [s]


%% Latitude and Longitude Array Loop

%Find change in distance due to wind, [m]
deltaLat_m = vvel*timeint; 
deltaLon_m = uvel*timeint;

%Input the latitude value and get m-to-deg conversion multipliers
[latlen, longlen] = Lat2metersInLatLon(oldLat);

%calculate the change in distance in degrees (from meters)
deltaLat_deg = deltaLat_m*(1/latlen);    
deltaLon_deg = deltaLon_m*(1/longlen);


% Check wind's sign: U-vel and Latitude
if (uvel > 0)
    windSignLat = 1;
else
    windSignLat = -1;
end

% Check wind's sign: V-vel and Longitude
if (vvel > 0)
    windSignLon = 1;
else
    windSignLon = -1;    
end
    
    
% Calculate new Lat/Lon position
newLat = oldLat + windSignLat*deltaLat_deg;
newLon = oldLon + windSignLon*deltaLon_deg;
    

end