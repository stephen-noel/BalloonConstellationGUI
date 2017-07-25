%% WindData.m

%% Nctoolbox
%Nctoolbox downloaded from: ('https://github.com/nctoolbox/nctoolbox/releases')

%NOTE: Nctoolbox must be downloaded and included in the same MATLAB
%directory for the "ncgeodataset" function to work. In the final product
%these files will be packaged with the GUI files.

%% WindData function
function [uvel, vvel] = WindData(NOAAstring, launchLat, launchLon)


%Add nctoolbox to the path
setup_nctoolbox;

%% Access GrADS Data Server via URL

mydate = NOAAstring;
url = ['http://nomads.ncep.noaa.gov:9090/dods/gfs_0p25_1hr/gfs',mydate,'/gfs_0p25_1hr_00z'];


%% Data set indices list
% the data set used by the code is 'ugrdprs' and 'vgrdprs'
    % 'ugrdprs':    u-component velocity (121, 30, 721, 1440) -- resolutions: (0.041666668 day, 33.3 mbar, 0.25 deg, 0.25 deg)
    % 'vgrdprs':    v-component velocity (121, 30, 721, 1440) -- resolutions: (0.041666668 day, 33.3 mbar, 0.25 deg, 0.25 deg)
    
% NOTE:    
    % The u-component velocity is the northerly wind component
    % The v-component velocity is the easterly wind component
    
    
%% Take launchLat and launchLon and get the corresponding NOAA dataset index

% Round latitude and longitude to nearest 0.25 degree
lat_round25 = round(launchLat*4)/4;
lon_round25 = round(launchLon*4)/4;

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
% NOTE:     start at 361 for latitudes, since the latitude range is (-90 < x < 90)
%           start at 0 for longitudes, since the longitude range is (0 < x < 360)
if (lat_round25 > 0)
index_lat = 361 + abs(4*lat25_int) + index_dec_lat;
index_lon = 0 + abs(4*lon25_int) + index_dec_lon;
elseif (lon_round25 < 0)
index_lat = 361 - abs(4*lat25_int) - index_dec_lat;
index_lon = 0 - abs(4*lon25_int) - index_dec_lon;
end

%% Get initial altitude and time vectors

index_time = 1;     %start of time index at 00h UTC on the day of interest
index_alt = 1;      %start of alt index at altitude level 1 mbar (lowest possible)


%% Download dataset and appropriate lat/lon index
% Instantiate ncgeodataset object using url
nco = ncgeodataset(url);

% U Component Velocity
uvel = double(squeeze(nco{'ugrdprs'}(index_time, index_alt, index_lat, index_lon))); %indexed at all parameters
% V Component Velocity
vvel = double(squeeze(nco{'vgrdprs'}(index_time, index_alt, index_lat, index_lon))); %indexed at all parameters


%{
% U Component Velocity
uvel = double(squeeze(nco{'ugrd_3658m'}(1,index_lat,index_lon))); %datapoint at first time, indexed lat/lon
% V Component Velocity
vvel = double(squeeze(nco{'vgrd_3658m'}(1,index_lat,index_lon))); %datapoint at first time, indexed lat/lon
%}

end