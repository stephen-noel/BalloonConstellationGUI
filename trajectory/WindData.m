%% WindData.m
% Author: Julianna Evans
% Date: 07.21.17
% Last Revision: 04.01.18 

% Retrieves the u- and v- velocities for the next timestep using the
% current time-position data. 

function [uvel, vvel] = WindData(NOAAstring, time_idx, alt_idx, lat_idx, lon_idx)
% Nctoolbox set-up occurs in 'pushbuttomCalcTraj_gui.m' for optimization

%% Access GrADS Data Server via URL
url = ['http://nomads.ncep.noaa.gov:9090/dods/gfs_0p25_1hr/gfs',NOAAstring,'/gfs_0p25_1hr_00z'];

%% Data set indices list
% the data set used by the code is 'ugrdprs' and 'vgrdprs'
    % 'ugrdprs':    u-component velocity (121, 30, 721, 1440) -- resolutions: (0.041666668 day, 33.3 mbar, 0.25 deg, 0.25 deg)
    % 'vgrdprs':    v-component velocity (121, 30, 721, 1440) -- resolutions: (0.041666668 day, 33.3 mbar, 0.25 deg, 0.25 deg)
    
% NOTE:    
    % The u-component velocity is the northerly wind component
    % The v-component velocity is the easterly wind component
    
%% Download dataset and appropriate lat/lon index
% Instantiate ncgeodataset object using url
nco = ncgeodataset(url);

% U Component Velocity
uvel = double(squeeze(nco{'ugrdprs'}(time_idx, alt_idx, lat_idx, lon_idx))); %indexed at all parameters
% V Component Velocity
vvel = double(squeeze(nco{'vgrdprs'}(time_idx, alt_idx, lat_idx, lon_idx))); %indexed at all parameters

end