%% convertWind.m

% Converts wind velocities and initial lat/lon coords to calculate new
% lat/lon coordinates.

function [newLat, newLon] = convertWind(uvel, vvel, oldLat, oldLon)

%Initialized time stuff
global time_interval;


%% Latitude and Longitude Array Loop

%Find the magnitude of the velocity vector and the direction
windvec = time_interval*sqrt((uvel)^2+(vvel)^2);
windtheta = atand(vvel/uvel); %in radians

dlat_m = windvec*sind(windtheta);
dlon_m = windvec*cosd(windtheta);

%Input the latitude value and get m-to-deg conversion multipliers
[latlen, longlen] = Lat2metersInLatLon(oldLat);

dlat_deg = dlat_m*(1/latlen);
dlon_deg = dlon_m*(1/longlen);


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
newLat = oldLat + windSignLat*dlat_deg;
newLon = oldLon + windSignLon*dlon_deg;

end