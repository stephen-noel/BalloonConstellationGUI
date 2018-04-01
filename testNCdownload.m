%% testNCdownload
% For this script we just want to download all of the NOAA GFS data for
% 'ugrdprs' and 'vgrdprs' so we will be able to store it later.


%setup
clc;clear;

%NOAA datestring
NOAAstring = '20180326'; 

%coordinates
minlat = 30;
maxlat = 32;
minlon = 20;
maxlon = 22;

%indices
minlat_idx = 481; 
maxlat_idx = 489;
minlon_idx = 80;
maxlon_idx = 88;

%index lengths
latidx_length = maxlat_idx-minlat_idx+1;
lonidx_length = maxlon_idx-minlon_idx+1;

tic;
for i = 1:121
dataTIME{i} = ncread('http://nomads.ncep.noaa.gov:9090/dods/gfs_0p25_1hr/gfs20180329/gfs_0p25_1hr_00z','ugrdprs', [minlon_idx minlat_idx 1 i], [lonidx_length latidx_length 31 1]);
size(dataTIME)
end
toc;







