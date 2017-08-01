%% balloon object class
% Julianna Evans
% 06.22.17

%% Define a class where balloon components can be stored
classdef balloonObj
    % balloon object data set class
    properties
        Name;           
        LaunchLat;          % [deg]
        LaunchLon;          % [deg]
        LaunchTime;         % ['DD MMM YYYY HH:MM:SS.SSS']
        
        LensFocalLength;    % [mm]
        FlenMultiplier;     % []
        ImgRatio;           % []
        
        PayloadMass;        % [kg]
        PayloadXdim;        % [m]
        PayloadYdim;        % [m]
        PayloadZdim;        % [m]
        
        BalloonVolInf;      % [m^3]
        BalloonMass;        % [kg]
        
        BalloonGas;         % [g/mol]
        
        FloatAlt;           % [km]
        FloatDur;           % [s]
        MolWeight;          % [g/mol]
        
        
    end
end