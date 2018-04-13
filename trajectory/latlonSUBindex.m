%% latlonSUBindex.m
% Author: Julianna Evans 
% Data: 04.12.18
% Last Revision: 04.12.18

% Just a function to clean up 'dataIndexing' since there's a lot of math-y
% stuff for the lat/lon calculations. 

function [latindex,lonindex]= latlonSUBindex(latval,lonval)

global minLat; global minLon; global maxLat; global maxLon; 

%% Take newLat and newLon and get the corresponding NOAA dataset index
% The 'ugrdprs' and 'vgrdprs' datasets have lat/lon indices of 1:721 (720
% values) and 1:1441 (1440 values), respectively. They both have a
% resolution of 0.25 deg.

newLat = latval;
newLon = lonval;

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
% NOTE:  we have to start at 361 for the lat because there are 720 total
% indexes, and we start at the middle, which is zero.
if (lat_round25 > 0)
index_lat = 361 + abs(4*lat25_int) + index_dec_lat;
index_lon = 0 + abs(4*lon25_int) + index_dec_lon;
elseif (lon_round25 < 0)
index_lat = 361 - abs(4*lat25_int) - index_dec_lat;
index_lon = 0 - abs(4*lon25_int) - index_dec_lon;
end

%set output
latindex = index_lat;
lonindex = index_lon;
end
