%% convertWind.m

% Calculates lat and lon arrays as functions of time with given wind data
% points (u-vel and v-vel) at launch. Dynamic indexing of wind datasets to
% be implemented in the future. 

function [newLat, newLon] = convertWind(uvel, vvel, launchLat, launchLon)

%Initialized time/timestep stuff
timespan = 3*60*60;  % 3hrs in [s]
timestep = 1;       % [s]

%% Vector Instantiation
%Instantiate old values (to be iterated on in loop)
oldLat = launchLat;
oldLon = launchLon;

%set first value of arrays as initial Lat/Lon
newLat(1) = oldLat;
newLon(1) = oldLon;

%% Latitude and Longitude Array Loop
for t = 2:timespan  %starts at t = 2, t=1 is the initial point

%Find change in distance due to wind, [m]
deltaLat_m = vvel*timestep; 
deltaLon_m = uvel*timestep;


%Input the latitude value and get m-to-deg conversion multipliers
[latlen, longlen] = ConversionsLatLon(oldLat);

%calculate the change in distance [deg]
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
newLat(t) = oldLat + windSignLat*deltaLat_deg;
newLon(t) = oldLon + windSignLon*deltaLon_deg;
    
% Set current Lat/Lon as next iterations' oldLat and oldLon
oldLat = newLat(t);
oldLon = newLon(t);

end