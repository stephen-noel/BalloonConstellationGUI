%% latlonArray.m
% Julianna Evans
% 07.24.17

% Calls all of the wind stuff and puts all of the outputs (lat,lon and alt
% vectors as functions of time) into a matrix.


%% Function calls

% Call 'guiWindInputs'
[NOAAstring, launchLat, launchLon] = guiWindInputs(starttime_GUI, launchlat_GUI, launchlon_GUI);

% Call 'WindData'
[uvel, vvel] = WindData(starttime_GUI,launchlat_GUI,launchlon_GUI);


% Now we have initial launch lat (launchLat), initial launch lon
% (launchLon), and u-vel and v-vel at the initial time (NOAAstring)

%Call 'convertWind'
%[] = convertWind();

%% Data matrix formatting

% ...
