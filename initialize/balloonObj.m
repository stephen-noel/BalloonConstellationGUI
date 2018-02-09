%% balloon object class
% Julianna Evans
% 06.22.17
% last rev: 02.08.18

%% Define a class where balloon components can be stored
classdef balloonObj
    % balloon object data set class
    properties
        Name;           
        LaunchLat;          % [deg]
        LaunchLon;          % [deg]
        LaunchTime;         % ['DD MMM YYYY HH:MM:SS.SSS']
        
        FOV;                % [deg]
        
    end
end