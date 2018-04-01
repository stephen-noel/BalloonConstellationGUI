%% downloadWind.m
% Author: Julianna M. Evans
% Date: 03.29.18
% Last Revision: 03.29.18

% This code will download the data from the NOAA GFS database based on the
% user's input of the rectangular lat/lon area target.

%% Global variables and Inputs
global minLat; global minLon; global maxLat; global maxLon;

%get NOAA datestring
NOAAstring = '20180326'; %testval

%% Nctoolbox
%Nctoolbox downloaded from: ('https://github.com/nctoolbox/nctoolbox/releases')

%NOTE: Nctoolbox must be downloaded and included in the same MATLAB
%directory for the "ncgeodataset" function to work. In the final product
%these files would be packaged with the GUI files (need professional matlab
%license to do this, so not really possible at the moment). 

%NOTE: Nctoolbox set-up occurs in 'pushbuttomCalcTraj_gui.m' for optimization
setup_nctoolbox; %just do for testing
%% Calculate the boundaries of the data download

%set and store lat/lon variables
% minLat1 = minLat;
% minLon1 = minLon;
% maxLat1 = maxLat;
% maxLon1 = maxLon;

%testvals
minLat1 = 30;
minLon1 = 20;
maxLat1 = 32;
maxLon1 = 22;


%get the indices of the lats and lons
epSec = 3600;newAlt = 30; %set as random defaults--we don't need these
[~, ~, minlat_idx, minlon_idx] = dataIndexing(epSec, newAlt, minLat1, minLon1);
[~, ~, maxlat_idx, maxlon_idx] = dataIndexing(epSec, newAlt, maxLat1, maxLon1);


%% Access GrADS Data Server via URL and download dataset

% Dataset Indices
% We want to use 'ugrdprs' and 'vgrdprs' for the u- and v- velocities, respectively.
% NOTE: uvel is northerly wind component and vvel is easterly windcomponent
tic;
url = ['http://nomads.ncep.noaa.gov:9090/dods/gfs_0p25_1hr/gfs',NOAAstring,'/gfs_0p25_1hr_00z'];
nco = ncgeodataset(url);

%download based on parameters
uvelMAT = double(squeeze(nco{'ugrdprs'}(:, :, minlat_idx:maxlat_idx, minlon_idx:maxlon_idx))); %indexed at all parameters
vvelMAT = double(squeeze(nco{'vgrdprs'}(:, :, minlat_idx:maxlat_idx, minlon_idx:maxlon_idx))); %indexed at all parameters

toc;


