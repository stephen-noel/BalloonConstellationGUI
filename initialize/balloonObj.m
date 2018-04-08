%% balloonObj.m
% Author: Julianna Evans
% Date: 06.22.17
% Last Revision: 04.06.18

%% Define a class where balloon components can be stored
classdef balloonObj
    % balloon object data set class
    properties
        Name;           
        LaunchLat;          % [deg]
        LaunchLon;          % [deg]
        LaunchTime;         % ['DD MMM YYYY HH:MM:SS.SSS']
        LaunchAlt;          % [km] possibly [m]
        
        FOV;                % [deg]
        
    end
end