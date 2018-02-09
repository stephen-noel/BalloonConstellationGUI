%% pushbuttonAddTarget_gui.m
% Julianna Evans
% 02.08.18

% Get inputs from GUI strings
global rootEngine;

%% IF-ELSE STRUCTURE
% If the radio buttons for Ground Area Target are not selected
if (get(handles.radioGATlatlon,'Value') == 0 && get(handles.radioGATradius,'Value') == 0)
    %user did not select any radio button, display error
    warndlg('Please select Ground Area Target method.');
else
    
    %LAT-LON COORDINATE METHOD
    if (get(handles.radioGATlatlon,'Value') == 1) 

        %Get handles from GUI edit-textboxes to store as inputs
        minLat = str2num(get(handles.editGATminlat,'String'));
        minLon = str2num(get(handles.editGATminlon,'String'));
        maxLat = str2num(get(handles.editGATmaxlat,'String'));
        maxLon = str2num(get(handles.editGATmaxlon,'String'));
    
        %set up coordinates based on min/max and lat/lon coords
        point1 = [maxLat minLon];
        point2 = [maxLat maxLon];
        point3 = [minLat maxLon];
        point4 = [minLat minLon];
        
        % Create the AreaTarget on the current scenario central body (Earth)
        areaTarget = rootEngine.CurrentScenario.Children.New('eAreaTarget', 'MyAreaTarget');

        % Draw AreaTarget Pattern using lat/lon coordinates
        rootEngine.BeginUpdate(); %By using the fine grained interfaces, BeginUpdate/EndUpdate prevent intermediate redraws
        areaTarget.AreaType = 'ePattern';
        patterns = areaTarget.AreaTypeData;
        patterns.Add(point1(1), point1(2));
        patterns.Add(point2(1), point2(2));
        patterns.Add(point3(1), point3(2));
        patterns.Add(point4(1), point4(2));
        rootEngine.EndUpdate();
        areaTarget.AutoCentroid = true;
    end
    
       
    %RADIUS GAT METHOD
    if (get(handles.radioGATradius,'Value') == 1)
        %use RADIUS METHOD
       
        %get handles from GUI for the ellipse centroid
        centroidLat = str2num(get(handles.editGATradlat,'String'));
        centroidLon = str2num(get(handles.editGATradlon,'String'));
        ellipseRadius = str2num(get(handles.editGATradius,'String'));
        
        % Create the AreaTarget on the current scenario central body (Earth)
        areaTarget2 = rootEngine.CurrentScenario.Children.New('eAreaTarget', 'MyAreaTarget');

        % Draw AreaTarget Pattern using radius and centroid coordinates
        rootEngine.BeginUpdate(); %By using the fine grained interfaces, BeginUpdate/EndUpdate prevent intermediate redraws
        areaTarget2.AreaType = 'eEllipse';
        ellipse = areaTarget2.AreaTypeData;
        ellipse.SemiMajorAxis = ellipseRadius; % in km (distance dimension)
        ellipse.SemiMinorAxis = ellipseRadius; % in km (distance dimension)
        ellipse.Bearing = 0; % in deg (angle dimension)
        
        % NEED SOMETHING FOR LATITUDE AND LONGITUDE COORDS!!!!!!!!
        
        
        rootEngine.EndUpdate();
       
    end 
end   
        
       