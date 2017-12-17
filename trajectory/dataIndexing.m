%% dataIndexing.m
% Julianna Evans
% 07.26.17

function [time_idx, alt_idx, lat_idx, lon_idx] = dataIndexing(epSec, newAlt, newLat, newLon)

%% Take epSec and put into terms of NOAA indexing
% The 'ugrdprs' and 'vgrdprs' datasets have a time index of 1:121 (0-120
% values) with a resolution of 0.041666668 days / 3600.00115 seconds.

%time index resolution
res_sec = 3600.00115; %[s]

%create vector of epSec per index (add 3600.00115 sec for each increased timestep)
for timeIndex = 2:121
epSecVec(timeIndex) = (timeIndex-1)*res_sec;
end

%get closest value and corresponding index
% NOTE: do this by subtracting the given value by all of the vector
% elements, get the index of the minimum value found, and then find the
% closest vector value using that index. 
amt_diff = abs(epSec - epSecVec);
[idx idx] = min(amt_diff);
%closestEpSecVal = epSecVec(idx);
time_idx = idx;


%% Take newAlt value and put into terms of NOAA indexing
% The 'ugrdprs' and 'vgrdprs' datasets have an altitude index of 1:31 (0-30
% values) with a resolution of 33.3 mbars. The data goes from a min
% pressure of 1000 mbar to max pressure of 1 mbar.

res_mbar = 33.3; % [mbar]

%change altitude at timestep into a pressure by calling 'pressurealt' script
[newPressure] = pressurealt(newAlt);

%create vector of pressure per index (add xxx mbar for each increased timestep)
for paltIndex = 2:31
pressureVec(paltIndex) = 1000-(paltIndex-1)*res_mbar;
end

%get closest value and corresponding index
% NOTE: do this by subtracting the given value by all of the vector
% elements, get the index of the minimum value found, and then find the
% closest vector value using that index. 

amt_diff = abs(newPressure - pressureVec);
[idx idx] = min(amt_diff);
pressure_idx = idx;

%NOAA dataset index
alt_idx = pressure_idx;


%% Take newLat and newLon and get the corresponding NOAA dataset index
% The 'ugrdprs' and 'vgrdprs' datasets have lat/lon indices of 1:721 (720
% values) and 1:1441 (1440 values), respectively. They both have a
% resolution of 0.25 deg.

% Round user-inputed latitude and longitude to nearest 0.25 degree
lat_round25 = round(newLat*4)/4;
lon_round25 = round(newLon*4)/4;

% Get integers of the lat/lon values
% NOTE: if lat/lon is positive, take the floor of the number.
%       if lat/lon is negative, take the ceiling of the number.
if (lat_round25 > 0)
    lat25_int = floor(lat_round25);
else
    lat25_int = ceil(lat_round25);   
end

if (lon_round25 > 0)
    lon25_int = floor(lon_round25);
else
    lon25_int = ceil(lon_round25);
end


% Get decimal of the lat/lon values
lat25_dec = abs(lat_round25 - lat25_int);
lon25_dec = abs(lon_round25 - lon25_int);

%Convert decimal from double to str for switch-case statement
lat25_dec_str = num2str(lat25_dec);
lon25_dec_str = num2str(lon25_dec);

%Switch statement for latitude decimal index
switch lat25_dec_str
    case '0.25'
        %add +1 to index
        index_dec_lat = 1;
    case '0.50'
        %add +2 to index
        index_dec_lat = 2;
    case '0.75'
        %add +3 to index
        index_dec_lat = 3;
    otherwise
        %add +0 to index
        index_dec_lat = 0;
end

%Switch statement for longitude decimal index
switch lon25_dec_str
    case '0.25'
        %add +1 to index
        index_dec_lon = 1;
    case '0.50'
        %add +2 to index
        index_dec_lon = 2;
    case '0.75'
        %add +3 to index
        index_dec_lon = 3;
    otherwise
        %add +0 to index
        index_dec_lon = 0;
end

%Indices for latitude and longitude for NOAA databases
% NOTE:  start at 361 for latitudes, since the latitude range is (-90 < x < 90)
%        start at 0 for longitudes, since the longitude range is (0 < x < 360)
if (lat_round25 > 0)
index_lat = 361 + abs(4*lat25_int) + index_dec_lat;
index_lon = 0 + abs(4*lon25_int) + index_dec_lon;
elseif (lon_round25 < 0)
index_lat = 361 - abs(4*lat25_int) - index_dec_lat;
index_lon = 0 - abs(4*lon25_int) - index_dec_lon;
end

%store into function outputs
lat_idx = index_lat;
lon_idx = index_lon;

end
