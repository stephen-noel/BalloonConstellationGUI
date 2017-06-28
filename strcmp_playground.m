%% Strcmp playground
%{

% Data setup
newData = {'name1', 23, 56; 'name2', 24, 66; 'nameeee3', 36, 75};
balloonNames = newData(:,1);
newName = 'name0';


if ~any(strcmp(balloonNames,newName))
    disp('no match found')
else
    disp('match found')
end
%} 

%% Data Entry Setup

newRow = {'name2', 32 45};
oldData = {'name1', 34, 55; 'name2', 35, 77; 'name3', 66, 78};

% Format type for balloon name, lat, and lon
newName = cell2mat(newRow(1));
newLat = cell2mat(newRow(2));
newLon = cell2mat(newRow(3));

% Balloon names list
newData = [oldData; newRow];
balloonNames = oldData(:,1);

% Display functions
disp(newName);
disp(balloonNames);

%% Error handling
% Error handling for object name
if  ~any(strcmp(balloonNames,newName))
    
    %Error handling for latitude and longitude string entry
    if newLat >= -90 && newLat <= 90 && newLon >= -180 && newLon <= 180

        %Assign facility name and coords (**place aircraft stuff here later**)
        disp('assign facility name and coords here');
        
    else
        warndlg('Enter a latitude in the range (-90 < x < 90) and longitude in the range (-180 < x < 180).');
    end

else
    warndlg('Balloon names must not repeat.');
end
