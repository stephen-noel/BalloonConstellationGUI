%% Initialize

%Nctoolbox downloaded from: ('https://github.com/nctoolbox/nctoolbox/releases')

%NOTE: Nctoolbox must be downloaded and included in the same MATLAB
%directory for the "ncgeodataset" function to work. In the final product
%these files will be packaged with the GUI files.

%Add nctoolbox to the path
setup_nctoolbox;

%% Access GrADS Data Server via URL

%test values for function (call real values from pushbuttonCalcTraj_gui.m later)
starttime_GUI = '20 Jul 2017 16:00:00.000';
launchlat_GUI = 30.33;
launchlon_GUI = 35.72;

% Call 'guiWindInputs' function to get NOAA-formated datetime string
[NOAAstring, launchLat, launchLon] = guiWindInputs(starttime_GUI, launchlat_GUI, launchlon_GUI);

mydate = NOAAstring;
%mydate = '20170710';
url = ['http://nomads.ncep.noaa.gov:9090/dods/gfs_0p25_1hr/gfs',mydate,'/gfs_0p25_1hr_00z'];


%% Instantiate the data set
% the data sets used by the code are 'ugrdprs' and 'vgrdprs'
    % 'ugrd_3658m':    u-component velocity (121, 721, 1440) -- resolutions: (0.041666668, 0.25, 0.25)
    % 'vgrd_3658m':    v-component velocity (121, 721, 1440) -- resolutions: (0.041666668, 0.25, 0.25)

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
%           start at 721 for latitudes, since the latitude range is (-180 < x < 180)
if (lat_round25 > 0)
index_lat = 361 + abs(4*lat25_int) + index_dec_lat;
index_lon = 721 + abs(4*lon25_int) + index_dec_lon;
elseif (lon_round25 < 0)
index_lat = 361 - abs(4*lat25_int) - index_dec_lat;
index_lon = 721 - abs(4*lon25_int) - index_dec_lon;
end


%% Download dataset and appropriate lat/lon index
% Instantiate ncgeodataset object using url
nco = ncgeodataset(url);

% U Component Velocity
uvel = double(squeeze(nco{'ugrd_3658m'}(1,index_lat,index_lon))); %datapoint at first time, indexed lat/lon
% V Component Velocity
vvel = double(squeeze(nco{'vgrd_3658m'}(1,index_lat,index_lon))); %datapoint at first time, indexed lat/lon

disp(uvel);
disp(vvel);

