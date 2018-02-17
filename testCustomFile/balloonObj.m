%% balloon object class
% Julianna Evans
% 06.22.17
% last rev: 02.08.18

%% Define a class where balloon components can be stored
classdef balloonObj
    % balloon object data set class
    properties
        
        %identifier
        Name;               % ['string']
        
        %launch properties
        LaunchLat;          % [deg]
        LaunchLon;          % [deg]
        LaunchTime;         % ['DD MMM YYYY HH:MM:SS.SSS']
        LaunchAlt;          % [km]
        
        %optics specs
        FOV;                % [deg]
        
    end
end