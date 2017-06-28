%% Balloon GUI: STK Scenario Initialization
%  Julianna Evans
%  06.19.17

%% STK External Scenario Initialization File

global rootEngine;

%% Scenario Time Interval
% Set Scenario Time Intervals
rootEngine.CurrentScenario.SetTimePeriod('01 Sep 2019 16:00:00.000', '10 Sep 2019 16:00:00.000');
rootEngine.CurrentScenario.Epoch = '01 Sep 2019 16:00:00.000';
rootEngine.Rewind;



%% Test Objects
%  NOTE: Everything below is just to test functionality, and will be
%  modified for the actual scenario

% Create New Facility (Default)
facility = rootEngine.CurrentScenario.Children.New('eFacility', 'MyFacility');
facility.Position.AssignGeodetic(33.3943, -104.5230, 0); % Argument: Latitude, Longitude, Altitude

