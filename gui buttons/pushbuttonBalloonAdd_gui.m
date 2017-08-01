%% pushbuttonBalloonAdd_gui
% Julianna Evans
% 06.22.17

%% Global Variables

global rootEngine;

%% Code assigned to the 'pushbuttonBalloonAdd' pushbutton in the GUI

% Instantiate balloon object
balloon = balloonObj;

%% IF-ELSE NESTED STRUCTURE
% If the radio buttons for Custom and Default balloon/payload inputs are not selected
if (get(handles.radiobuttonCustom,'Value') == 0 && get(handles.radiobuttonDefault,'Value') == 0)
    %user did not select any radio button, display error
    warndlg('Please select Custom or Default balloon/payload specs.');
else
    if (get(handles.radiobuttonCustom,'Value') == 1) %Custom button is pressed
        %use CUSTOM PROPERTIES
        % Get edit-text-box values from GUI using object handles
        balloon_Name = get(handles.editBalloonName,'String');
        balloon_Lat = str2num(get(handles.editBalloonLat,'String'));
        balloon_Lon = str2num(get(handles.editBalloonLon,'String'));
        balloon_Time = str2num(get(handles.editLaunchTime,'String'));
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
        balloon.LaunchTime = balloon_Time;
        balloon.LensFocalLength = balloon_Flen;
        balloon.FlenMultiplier = balloon_FlenMult;
        balloon.ImgRatio = balloon_ImgRatio;
        balloon.PayloadMass = balloon_PayloadMass;
        balloon.PayloadXdim = balloon_PayloadXdim;
        balloon.PayloadYdim = balloon_PayloadYdim;
        balloon.PayloadZdim = balloon_PayloadZdim;
        balloon.BalloonVolInf = balloon_balloonInfVolume;
        balloon.BalloonMass = balloon_balloonMass;
    end
    
    if (get(handles.radiobuttonDefault,'Value') == 1) %Default button is pressed
        %use DEFAULT PROPERTIES
        % Get values from launch names/coords
        balloon_Name = get(handles.editBalloonName,'String');
        balloon_Lat = str2num(get(handles.editBalloonLat,'String'));
        balloon_Lon = str2num(get(handles.editBalloonLon,'String'));
        balloon_Time = get(handles.editLaunchTime,'String');
        
        % Set default values
        balloon_Flen_Default = 50;                %[mm]
        balloon_FlenMult_Default = 1.6;           %[]
        balloon_ImgRatio_Default = 1.5;           %[]
        balloon_PayloadMass_Default = 500;        %[kg]
        balloon_PayloadXdim_Default = 5;          %[m]
        balloon_PayloadYdim_Default = 5;          %[m]
        balloon_PayloadZdim_Default = 5;          %[m]
        balloon_balloonInfVolume_Default = 500;   %[m^3]
        balloon_balloonMass_Default = 100;        %[kg]
        
        % Assign default values into the balloon object
        balloon.Name = balloon_Name;
        balloon.LaunchLat = balloon_Lat;
        balloon.LaunchLon = balloon_Lon;
        balloon.LaunchTime = balloon_Time;
        balloon.LensFocalLength = balloon_Flen_Default;
        balloon.FlenMultiplier = balloon_FlenMult_Default;
        balloon.ImgRatio = balloon_ImgRatio_Default;
        balloon.PayloadMass = balloon_PayloadMass_Default;
        balloon.PayloadXdim = balloon_PayloadXdim_Default;
        balloon.PayloadYdim = balloon_PayloadYdim_Default;
        balloon.PayloadZdim = balloon_PayloadZdim_Default;
        balloon.BalloonVolInf = balloon_balloonInfVolume_Default;
        balloon.BalloonMass = balloon_balloonMass_Default;
        
        % set default values to display
        balloon_Flen = num2str(set(handles.editLensFocalLength,'String',balloon_Flen_Default));
        balloon_FlenMult = num2str(set(handles.editFocalLengthMult,'String',balloon_FlenMult_Default));
        balloon_ImgRatio = num2str(set(handles.editImageRatio,'String',balloon_ImgRatio_Default));
        balloon_PayloadMass = num2str(set(handles.editPayloadMass,'String',balloon_PayloadMass_Default));
        balloon_PayloadXdim = num2str(set(handles.editPayloadXdim,'String',balloon_PayloadXdim_Default));
        balloon_PayloadYdim = num2str(set(handles.editPayloadYdim,'String',balloon_PayloadYdim_Default));
        balloon_PayloadZdim = num2str(set(handles.editPayloadZdim,'String',balloon_PayloadZdim_Default));
        balloon_balloonInfVolume = num2str(set(handles.editBalloonVolume,'String',balloon_balloonInfVolume_Default));
        balloon_balloonMass = num2str(set(handles.editBalloonMass,'String',balloon_balloonMass_Default));
    end
end

% Set up into row data for the GUI table
newRow = {balloon.Name, balloon.LaunchLat, balloon.LaunchLon, balloon.LaunchTime};

%% Data Entry Setup

% Format type for balloon name, lat, and lon
newName = cell2mat(newRow(1));
newLat = cell2mat(newRow(2));
newLon = cell2mat(newRow(3));
newTime = cell2mat(newRow(4));

% Balloon names list
oldData = get(handles.balloonTable,'Data');
newData = [oldData; newRow];
balloonNames = oldData(:,1);

% Copy all data into the Trajectory tab table
balloonDataTraj = set(handles.balloonTableTraj,'Data',newData);


%% Error handling

% Error handling for object name (names cannot repeat)
if  ~any(strcmp(balloonNames,newName))
    
    %Error handling for latitude and longitude string entry
    if newLat >= -90 && newLat <= 90 && newLon >= -180 && newLon <= 180

        % Add placeholder facility object 
        % NOTE: used to signify launch locations, could be deleted or kept in code 
        facility = rootEngine.CurrentScenario.Children.New('eFacility', newName);
        facility.Position.AssignGeodetic(newLat,newLon,0); % AssignGeodetic(lat,lon,alt)
        
        %Set new table data
        set(handles.balloonTable,'Data', newData);
        
    else
        warndlg('Enter a latitude in the range (-90 < x < 90) and longitude in the range (-180 < x < 180).');
    end

else
    warndlg('Balloon names must not repeat.');
end
