%% datasub.m
% Author: Julianna Evans
% Date: 04.07.18
% Last Revision: 04.12.18

% Converts old time-pos values to uvel and vvel values

function [uvelOLD, vvelOLD] = datasub(epSec, oldAlt, oldLat, oldLon,uvelTIME,vvelTIME,ATdata)

%% Time indexing from the dataIndexing script
[time_idx, alt_idx, lat_idx, lon_idx] = dataIndexing(epSec, oldAlt, oldLat, oldLon);

%get indices of ATdata
[idx_AT_minlat,idx_AT_minlon]= latlonSUBindex(ATdata{1,1},ATdata{1,2});

%convert to datasubset indices, relative to AT
idx_newLat = lat_idx;
idx_newLon = lon_idx;
sub_idxnewLat = idx_newLat-idx_AT_minlat+1;
sub_idxnewLon = idx_newLon-idx_AT_minlon+1;

%set as new lat and lon values
lat_idx = sub_idxnewLat;
lon_idx = sub_idxnewLon;

%get the u/v-vel array at the time index
uvel_atEpSec = uvelTIME{time_idx};
vvel_atEpSec = vvelTIME{time_idx};


%% Get the values from the data subset
%get the data value at the lat/lon/alt
uvelOLD = uvel_atEpSec(lon_idx,lat_idx,alt_idx);
vvelOLD = vvel_atEpSec(lon_idx,lat_idx,alt_idx);

end