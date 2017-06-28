%% pushbuttonBalloonAdd_gui
% Julianna Evans
% 06.22.17

global rootEngine;

%% Code assigned to the 'pushbuttonBalloonAdd' pushbutton in the GUI

% Instantiate balloon object
balloon = balloonObj;

% Get edit-text-box values using object handles
balloon_Name = get(handles.editBalloonName,'String');
balloon_Lat = str2num(get(handles.editBalloonLat,'String'));
balloon_Lon = str2num(get(handles.editBalloonLon,'String'));
balloon_Flen = str2num(get(handles.editLensFocalLength,'String'));
balloon_FlenMult = str2num(get(handles.editFocalLengthMult,'String'));
balloon_ImgRatio = str2num(get(handles.editImageRatio,'String'));
balloon_PayloadMass = str2num(get(handles.editPayloadMass,'String'));
balloon_PayloadXdim = str2num(get(handles.editPayloadXdim,'String'));
balloon_PayloadYdim = str2num(get(handles.editPayloadYdim,'String'));
balloon_PayloadZdim = str2num(get(handles.editPayloadZdim,'String'));
balloon_balloonInfVolume = str2num(get(handles.editBalloonVolume,'String'));
balloon_balloonMass = str2num(get(handles.editBalloonMass,'String'));

% Assign GUI handle values into the balloon object
balloon.Name = balloon_Name;
balloon.LaunchLat = balloon_Lat;
balloon.LaunchLon = balloon_Lon;
balloon.LensFocalLength = balloon_Flen;
balloon.FlenMultiplier = balloon_FlenMult;
balloon.ImgRatio = balloon_ImgRatio;
balloon.PayloadMass = balloon_PayloadMass;
balloon.PayloadXdim = balloon_PayloadXdim;
balloon.PayloadYdim = balloon_PayloadYdim;
balloon.PayloadZdim = balloon_PayloadZdim;
balloon.BalloonVolInf = balloon_balloonInfVolume;
balloon.BalloonMass = balloon_balloonMass;

% Set up into row data for the GUI table
newRow = {balloon.Name, balloon.LaunchLat, balloon.LaunchLon};

%% Data Entry Setup

% Format type for balloon name, lat, and lon
newName = cell2mat(newRow(1));
newLat = cell2mat(newRow(2));
newLon = cell2mat(newRow(3));

% Balloon names list
oldData = get(handles.balloonTable,'Data');
newData = [oldData; newRow];
balloonNames = oldData(:,1);


%% Error handling

% Error handling for object name
if  ~any(strcmp(balloonNames,newName))
    
    %Error handling for latitude and longitude string entry
    if newLat >= -90 && newLat <= 90 && newLon >= -180 && newLon <= 180

        %Assign facility name and coords (**place aircraft stuff here later**)
        facility = rootEngine.CurrentScenario.Children.New('eFacility', newName);
        facility.Position.AssignGeodetic(newLat,newLon,0); % AssignGeodetic argument: Latitude, Longitude, Altitude
        
        set(handles.balloonTable,'Data', newData);
        
    else
        warndlg('Enter a latitude in the range (-90 < x < 90) and longitude in the range (-180 < x < 180).');
    end

else
    warndlg('Balloon names must not repeat.');
end


%% Create new Aircraft with Waypoints 
% NOTE: Must include a second waypoint in order to be propogated. Using a facility for now to model the launch locations.  

%{

aircraft = rootEngine.CurrentScenario.Children.New('eAircraft', cell2mat(newRow(1))); %cell2mat(newRow(1)) is obj NAME

% Add Waypoints to Aircraft
aircraft.SetRouteType('ePropagatorGreatArc');
route = aircraft.Route;
route.Method = 'eDetermineTimeAccFromVel';
route.SetAltitudeRefType('eWayPtAltRefMSL');

% Add first point
waypoint = route.Waypoints.Add();
waypoint.Latitude = cell2mat(newRow(2));    %cell2mat(newRow(2)) is obj LAT
waypoint.Longitude = cell2mat(newRow(3));   %cell2mat(newRow(3)) is obj LON
waypoint.Altitude = 5;  % km
waypoint.Speed = .1;    % km/sec

% Add second point
waypoint2 = route.Waypoints.Add();
waypoint2.Latitude = 30;
waypoint2.Longitude = 50;   
waypoint2.Altitude = 5; % km
waypoint2.Speed = .1;   % km/sec

% Propagate the route
route.Propagate;

%}