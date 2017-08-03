%% Balloon GUI: STK Scenario Initialization
%  Julianna Evans
%  06.19.17

% NOTE: This script initializes the STK scenario time period and test objects.
% Runs through GUI opening function (pushbuttonInit_Callback).


%% STK External Scenario Initialization File
global rootEngine;
global STKstarttime;
global STKstoptime;
global STKtimestep;

%% Scenario Time Interval
% Set Scenario Time Intervals

% Set date units to UTCG
rootEngine.UnitPreferences.Item('DateFormat').SetCurrentUnit('UTCG');

% Scenario start time, stop time, time interval
STKstarttime = get(handles.editSTKstarttime,'String');
STKstoptime = get(handles.editSTKstoptime,'String');
STKtimestep = str2num(get(handles.editSTKtimestep,'String'));

% STK default datetime string format 
%[elapsedSecs,sameday00z] = str2sameday00z(STKstarttime);
STKdatetime = STKstarttime;

% Set time period, epoch, rewind
rootEngine.CurrentScenario.SetTimePeriod(STKstarttime,STKstoptime);
rootEngine.CurrentScenario.Epoch = STKstarttime;
rootEngine.Rewind;


%% STK Test Objects
%  NOTE: Everything below is just to test functionality, and will be
%  modified for the actual scenario

% Create New Default Facility in Roswell, NM
facility = rootEngine.CurrentScenario.Children.New('eFacility', 'RoswellNM');
facility.Position.AssignGeodetic(33.3943, -104.5230, 0); % Argument: Latitude, Longitude, Altitude
