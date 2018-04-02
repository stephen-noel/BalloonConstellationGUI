%% ddDownload_pushbutton.m
% Author: Julianna Evans
% Date: 04.01.18
% Last Revision: 04.01.18

% This script executes upon the "Download" button being pushed in the
% sub-GUI

%% Global Variables


%% Get the NOAA string value
ddNOAAstring = get(handles.ddNOAAstring,'String');


%% Access GrADS Data Server via URL
url = ['http://nomads.ncep.noaa.gov:9090/dods/gfs_0p25_1hr/gfs',ddNOAAstring,'/gfs_0p25_1hr_00z'];


%% Get the latitude and longitude bounds 

minLat1 = str2num(get(handles.ddMinLat,'String'));
minLon1 = str2num(get(handles.ddMinLon,'String'));
maxLat1 = str2num(get(handles.ddMaxLat,'String'));
maxLon1 = str2num(get(handles.ddMaxLon,'String'));


%get the indices of the lats and lons
epSec = 3600;newAlt = 30; %set as random defaults--we don't need these
[~, ~, minlat_idx, minlon_idx] = dataIndexing(epSec, newAlt, minLat1, minLon1);
[~, ~, maxlat_idx, maxlon_idx] = dataIndexing(epSec, newAlt, maxLat1, maxLon1);

%% Get the wind data using 'ncread' method
% Loops through all of the time vectors and stores the data in cells since
% the server won't allow download of the actual 4D arrays. 


%uvel
for i = 1:10
uvelTIME{i} = ncread(url,'ugrdprs', [minlon_idx minlat_idx 1 i], [lonidx_length latidx_length 31 1]);
size(uvelTIME)
end

%vvel
for i = 1:10
vvelTIME{i} = ncread(url,'vgrdprs', [minlon_idx minlat_idx 1 i], [lonidx_length latidx_length 31 1]);
size(vvelTIME)
end

