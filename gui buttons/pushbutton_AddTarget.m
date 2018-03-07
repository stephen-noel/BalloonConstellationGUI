%% pushbuttonAREAtarget_gui.m
% Julianna Evans
% 08.04.17
% last revision: 02.15.18

%% Code to run Number calculation

% Get inputs from GUI strings
global rootEngine;

%% Switch structure to determine which (if any) radio button has been pressed

%Check if a button has been pushed (if not-use error message)
if (get(handles.radioGATlatlon,'Value') == 0 && get(handles.radioGATradius,'Value') == 0)
    %error message

else
    %do this if a user selected a radio button
    switch get(get(handles.uibuttongroupAT,'SelectedObject'),'Tag')
        case 'radioGATlatlon'
            %use rectangular Area Target code
            
            %Get handles from GUI edit-textboxes to store as inputs
            minLat = str2num(get(handles.editGATminlat,'String'));
            minLon = str2num(get(handles.editGATminlon,'String'));
            maxLat = str2num(get(handles.editGATmaxlat,'String'));
            maxLon = str2num(get(handles.editGATmaxlon,'String'));
            
            %Code to add Area Target Object based on inputted Lat/Lon   
            %set up coordinates based on min/max and lat/lon coords
            point1 = [maxLat minLon];
            point2 = [maxLat maxLon];
            point3 = [minLat maxLon];
            point4 = [minLat minLon];
            
            % Create the AreaTarget on the current scenario central body (Earth)
            areaTarget = rootEngine.CurrentScenario.Children.New('eAreaTarget', 'MyAreaTargetRectangle');
            
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
            
            
        case 'radioGATradius'
            %use ellipse (circle) Area Target code
            %get handles from GUI for the ellipse centroid (TEST VALUES HERE)
            centroidLat = str2num(get(handles.editGATradlat,'String'));
            centroidLon = str2num(get(handles.editGATradlon,'String'));
            ellipseRadius = str2num(get(handles.editGATradius,'String'));

            % Create the AreaTarget on the current scenario central body (Earth)
            areaTarget2 = rootEngine.CurrentScenario.Children.New('eAreaTarget', 'MyAreaTargetEllipse');
            
            
            % Draw AreaTarget Pattern using radius and centroid coordinates
            rootEngine.BeginUpdate(); %By using the fine grained interfaces, BeginUpdate/EndUpdate prevent intermediate redraws
            areaTarget2.AreaType = 'eEllipse';
            areaTarget2.Position.AssignGeodetic(centroidLat,centroidLon,10); %assign position in (lat,lon,alt)
            ellipse = areaTarget2.AreaTypeData;
            ellipse.SemiMajorAxis = ellipseRadius; % in km (distance dimension)
            ellipse.SemiMinorAxis = ellipseRadius; % in km (distance dimension)
            ellipse.Bearing = 0; % in deg (angle dimension)
            rootEngine.EndUpdate();   
    end
end