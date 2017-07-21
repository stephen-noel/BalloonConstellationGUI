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
launchlat_GUI = 30;
launchlon_GUI = 35;

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

    
% Instantiate ncgeodataset object using url
nco = ncgeodataset(url);

% U Component Velocity
uComponentVelocity = double(squeeze(nco{'ugrd_3658m'}(1,:,:,:))); %all data at first time

% V Component Velocity
vComponentVelocity = double(squeeze(nco{'vgrd_3658m'}(1,:,:,:))); %all data at first time

