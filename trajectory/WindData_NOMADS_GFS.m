%% Initialize

%Nctoolbox downloaded from: ('https://github.com/nctoolbox/nctoolbox/releases')

%NOTE: Nctoolbox must be downloaded and included in the same MATLAB
%directory for the "ncgeodataset" function to work. In the final product
%these files will be packaged with the GUI files.

%Add nctoolbox to the path
setup_nctoolbox;

%% Access GrADS Data Server via URL

mydate = '20170710';
url = ['http://nomads.ncep.noaa.gov:9090/dods/gfs_0p25_1hr',mydate,'/gfs_0p25_1hr_00z'];


%% Instantiate the data set
% the data sets used by the code are 'hgtprs', 'ugrdprs' and 'vgrdprs'
    % 'hgtprs':     geopotential height (121, 721, 1440) -- resolutions: (0.041666668, 0.25, 0.25)
    % 'ugrd_3658m':    u-component velocity (121, 721, 1440) -- resolutions: (0.041666668, 0.25, 0.25)
    % 'vgrd_3658m':    v-component velocity (121, 721, 1440) -- resolutions: (0.041666668, 0.25, 0.25)

% NOTE:    
    % The u-component velocity is the northerly wind component
    % The v-component velocity is the easterly wind component


nco = ncgeodataset(url);

geopotentialHeight = double(squeeze(nco{'hgtprs'}(1,:,:,:))); %all data at first time
%geopotentialHeight_time = nco{'hgtprs'}(:,1,1,1); %time array

uComponentVelocity = double(squeeze(nco{'ugrd_3658m'}(1,:,:,:))); %all data at first time

vComponentVelocity = double(squeeze(nco{'vgrd_3658m'}(1,:,:,:))); %all data at first time
