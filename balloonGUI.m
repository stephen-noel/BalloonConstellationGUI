%% Balloon Constellation GUI
% MATLAB GUIDE Sourcecode

% Julianna Evans
% 06.19.17
 
%--------------% RUN THIS FILE TO EXECUTE GUI  %---------------------------


%% -----------------START GUIDE CODE---------------------------------------

function varargout = balloonGUI(varargin)
% BALLOONGUI MATLAB code for balloonGUI.fig
%      BALLOONGUI, by itself, creates a new BALLOONGUI or raises the existing
%      singleton*.
%
%      H = BALLOONGUI returns the handle to a new BALLOONGUI or the handle to
%      the existing singleton*.
%
%      BALLOONGUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in BALLOONGUI.M with the given input arguments.
%
%      BALLOONGUI('Property','Value',...) creates a new BALLOONGUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before balloonGUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to balloonGUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help balloonGUI

% Last Modified by GUIDE v2.5 03-Aug-2017 10:48:06

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @balloonGUI_OpeningFcn, ...
                   'gui_OutputFcn',  @balloonGUI_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT

%% ------------- START OF GUIDE CALLBACKS ---------------------------------

% --- OpeningFcn: Executes just before balloonGUI is made visible.
function balloonGUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to balloonGUI (see VARARGIN)

% Choose default command line output for balloonGUI
handles.output = hObject;

% Initialize Tab Manager Class
handles.tabManager = TabManager( hObject );

% Update handles structure
guidata(hObject, handles);

% Global app and root
global STKXapp;
global rootEngine;

% Obtain a handle to the application, instantiate the STK root object
STKXapp = actxserver('STKX11.Application');
rootEngine = actxserver('AgStkObjects11.AgStkObjectRoot');

%NOTE: must add path to 'initialize' manually since the addpath commands are
%inside this folder
addpath('initialize');
balloonGUI_initMATLAB;

% Grey out buttons until "Initialize Scenario" is pressed
set(handles.editMinLat,'Enable','off');
set(handles.editMinLon,'Enable','off');
set(handles.editMaxLat,'Enable','off');
set(handles.editMaxLon,'Enable','off');
set(handles.editBalloonName,'Enable','off');
set(handles.editBalloonLat,'Enable','off');
set(handles.editBalloonLon,'Enable','off');
set(handles.balloonTable,'Enable','off');
set(handles.pushbuttonBalloonAdd,'Enable','off');
set(handles.pushbuttonBalloonDelete,'Enable','off');
set(handles.editLensFocalLength,'Enable','off');
set(handles.editFocalLengthMult,'Enable','off');
set(handles.editImageRatio,'Enable','off');
set(handles.editPayloadMass,'Enable','off');
set(handles.editPayloadXdim,'Enable','off');
set(handles.editPayloadYdim,'Enable','off');
set(handles.editPayloadZdim,'Enable','off');
set(handles.editBalloonVolume,'Enable','off');
set(handles.editBalloonMass,'Enable','off');
set(handles.radiobuttonDefault,'Enable','off');
set(handles.radiobuttonCustom,'Enable','off');
set(handles.editFloatAlt,'Enable','off');
set(handles.editFloatDur,'Enable','off');
set(handles.popupmenuGasList,'Enable','off');
set(handles.editOtherBalloon,'Enable','off');
set(handles.editFilename,'Enable','off');
set(handles.editLaunchTime,'Enable','off');

%Set scenario start and stop time fields as default values (not inputted
%into scenario until "Initialize" button is pressed
global STKstarttimeINIT
STKstarttimeINIT = '10 Dec 2017 16:00:00.000'; 
STKstoptimeINIT = '11 Dec 2017 16:00:00.000'; 
set(handles.editSTKstarttime,'String',STKstarttimeINIT);
set(handles.editSTKstoptime,'String',STKstoptimeINIT);



% --- OutputFcn: Outputs from this function are returned to the command line.
function varargout = balloonGUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- CloseRequestFcn: Executes when user attempts to close figure1.
function figure1_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%unload scenario using invoke method
invoke(handles.activex1.Application,'ExecuteCommand','Unload / *'); 

global STKXapp;
release(STKXapp);
STKXapp = 0; 

% Hint: delete(hObject) closes the figure
delete(hObject);


% --- Executes on button press in pushbuttonInit.
function pushbuttonInit_Callback(hObject, eventdata, handles)
% hObject    handle to pushbuttonInit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global rootEngine

% Un-grey out buttons when "Initialize Scenario" is pressed
set(handles.editMinLat,'Enable','on');
set(handles.editMinLon,'Enable','on');
set(handles.editMaxLat,'Enable','on');
set(handles.editMaxLon,'Enable','on');
set(handles.editBalloonName,'Enable','on');
set(handles.editBalloonLat,'Enable','on');
set(handles.editBalloonLon,'Enable','on');
set(handles.balloonTable,'Enable','on');
set(handles.pushbuttonBalloonAdd,'Enable','on');
set(handles.pushbuttonBalloonDelete,'Enable','on');
set(handles.editLensFocalLength,'Enable','on');
set(handles.editFocalLengthMult,'Enable','on');
set(handles.editImageRatio,'Enable','on');
set(handles.editPayloadMass,'Enable','on');
set(handles.editPayloadXdim,'Enable','on');
set(handles.editPayloadYdim,'Enable','on');
set(handles.editPayloadZdim,'Enable','on');
set(handles.editBalloonVolume,'Enable','on');
set(handles.editBalloonMass,'Enable','on');
set(handles.radiobuttonDefault,'Enable','on');
set(handles.radiobuttonCustom,'Enable','on');
set(handles.editFloatAlt,'Enable','on');
set(handles.editFloatDur,'Enable','on');
set(handles.popupmenuGasList,'Enable','on');
set(handles.editFilename,'Enable','on');
set(handles.editLaunchTime,'Enable','on');

% Create New Scenario
rootEngine.NewScenario('balloonGUIscn');

% Execute external STK scenario initialization
balloonGUI_initSTK;

%Set launch textbox as scenario start time in STK format
global STKstarttime
set(handles.editLaunchTime,'String',STKstarttime);


% --- Executes on button press in pushbuttonPlayForw.
function pushbuttonPlayForw_Callback(hObject, eventdata, handles)
% hObject    handle to pushbuttonPlayForw (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global rootEngine;
rootEngine.PlayForward();

% --- Executes on button press in pushbuttonPause.
function pushbuttonPause_Callback(hObject, eventdata, handles)
% hObject    handle to pushbuttonPause (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global rootEngine;
rootEngine.Pause();

% --- Executes on button press in pushbuttonPlayBackw.
function pushbuttonPlayBackw_Callback(hObject, eventdata, handles)
% hObject    handle to pushbuttonPlayBackw (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global rootEngine;
rootEngine.PlayBackward();

% --- Executes on button press in pushbuttonDecTimestep.
function pushbuttonDecTimestep_Callback(hObject, eventdata, handles)
% hObject    handle to pushbuttonDecTimestep (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global rootEngine;
rootEngine.Slower();

% --- Executes on button press in pushbuttonReset.
function pushbuttonReset_Callback(hObject, eventdata, handles)
% hObject    handle to pushbuttonReset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global rootEngine;
rootEngine.Rewind();

% --- Executes on button press in pushbuttonIncTimestep.
function pushbuttonIncTimestep_Callback(hObject, eventdata, handles)
% hObject    handle to pushbuttonIncTimestep (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global rootEngine;
rootEngine.Faster();


function editNumBalloons_Callback(hObject, eventdata, handles)
% hObject    handle to editNumBalloons (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editNumBalloons as text
%        str2double(get(hObject,'String')) returns contents of editNumBalloons as a double


% --- Executes during object creation, after setting all properties.
function editNumBalloons_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editNumBalloons (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editMinLat_Callback(hObject, eventdata, handles)
% hObject    handle to editMinLat (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editMinLat as text
%        str2double(get(hObject,'String')) returns contents of editMinLat as a double


% --- Executes during object creation, after setting all properties.
function editMinLat_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editMinLat (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editMaxLat_Callback(hObject, eventdata, handles)
% hObject    handle to editMaxLat (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editMaxLat as text
%        str2double(get(hObject,'String')) returns contents of editMaxLat as a double


% --- Executes during object creation, after setting all properties.
function editMaxLat_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editMaxLat (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editMinLon_Callback(hObject, eventdata, handles)
% hObject    handle to editMinLon (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editMinLon as text
%        str2double(get(hObject,'String')) returns contents of editMinLon as a double


% --- Executes during object creation, after setting all properties.
function editMinLon_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editMinLon (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editMaxLon_Callback(hObject, eventdata, handles)
% hObject    handle to editMaxLon (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editMaxLon as text
%        str2double(get(hObject,'String')) returns contents of editMaxLon as a double


% --- Executes during object creation, after setting all properties.
function editMaxLon_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editMaxLon (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editBalloonName_Callback(hObject, eventdata, handles)
% hObject    handle to editBalloonName (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editBalloonName as text
%        str2double(get(hObject,'String')) returns contents of editBalloonName as a double


% --- Executes during object creation, after setting all properties.
function editBalloonName_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editBalloonName (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editBalloonLat_Callback(hObject, eventdata, handles)
% hObject    handle to editBalloonLat (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editBalloonLat as text
%        str2double(get(hObject,'String')) returns contents of editBalloonLat as a double


% --- Executes during object creation, after setting all properties.
function editBalloonLat_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editBalloonLat (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editBalloonLon_Callback(hObject, eventdata, handles)
% hObject    handle to editBalloonLon (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editBalloonLon as text
%        str2double(get(hObject,'String')) returns contents of editBalloonLon as a double


% --- Executes during object creation, after setting all properties.
function editBalloonLon_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editBalloonLon (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editLensFocalLength_Callback(hObject, eventdata, handles)
% hObject    handle to editLensFocalLength (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editLensFocalLength as text
%        str2double(get(hObject,'String')) returns contents of editLensFocalLength as a double


% --- Executes during object creation, after setting all properties.
function editLensFocalLength_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editLensFocalLength (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editFocalLengthMult_Callback(hObject, eventdata, handles)
% hObject    handle to editFocalLengthMult (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editFocalLengthMult as text
%        str2double(get(hObject,'String')) returns contents of editFocalLengthMult as a double


% --- Executes during object creation, after setting all properties.
function editFocalLengthMult_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editFocalLengthMult (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editImageRatio_Callback(hObject, eventdata, handles)
% hObject    handle to editImageRatio (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editImageRatio as text
%        str2double(get(hObject,'String')) returns contents of editImageRatio as a double


% --- Executes during object creation, after setting all properties.
function editImageRatio_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editImageRatio (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editPayloadMass_Callback(hObject, eventdata, handles)
% hObject    handle to editPayloadMass (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editPayloadMass as text
%        str2double(get(hObject,'String')) returns contents of editPayloadMass as a double


% --- Executes during object creation, after setting all properties.
function editPayloadMass_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editPayloadMass (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editPayloadXdim_Callback(hObject, eventdata, handles)
% hObject    handle to editPayloadXdim (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editPayloadXdim as text
%        str2double(get(hObject,'String')) returns contents of editPayloadXdim as a double


% --- Executes during object creation, after setting all properties.
function editPayloadXdim_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editPayloadXdim (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editPayloadYdim_Callback(hObject, eventdata, handles)
% hObject    handle to editPayloadYdim (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editPayloadYdim as text
%        str2double(get(hObject,'String')) returns contents of editPayloadYdim as a double


% --- Executes during object creation, after setting all properties.
function editPayloadYdim_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editPayloadYdim (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editPayloadZdim_Callback(hObject, eventdata, handles)
% hObject    handle to editPayloadZdim (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editPayloadZdim as text
%        str2double(get(hObject,'String')) returns contents of editPayloadZdim as a double


% --- Executes during object creation, after setting all properties.
function editPayloadZdim_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editPayloadZdim (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editBalloonVolume_Callback(hObject, eventdata, handles)
% hObject    handle to editBalloonVolume (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editBalloonVolume as text
%        str2double(get(hObject,'String')) returns contents of editBalloonVolume as a double


% --- Executes during object creation, after setting all properties.
function editBalloonVolume_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editBalloonVolume (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editBalloonMass_Callback(hObject, eventdata, handles)
% hObject    handle to editBalloonMass (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editBalloonMass as text
%        str2double(get(hObject,'String')) returns contents of editBalloonMass as a double


% --- Executes during object creation, after setting all properties.
function editBalloonMass_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editBalloonMass (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbuttonBalloonAdd.
function pushbuttonBalloonAdd_Callback(hObject, eventdata, handles)
% hObject    handle to pushbuttonBalloonAdd (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

pushbuttonBalloonAdd_gui;

% --- Executes on button press in pushbuttonBalloonDelete.
function pushbuttonBalloonDelete_Callback(hObject, eventdata, handles)
% hObject    handle to pushbuttonBalloonDelete (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
pushbuttonBalloonDelete_gui;

% --- Executes during object creation, after setting all properties.
function balloonTable_CreateFcn(hObject, eventdata, handles)
% hObject    handle to balloonTable (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes when selected cell(s) is changed in balloonTable.
function balloonTable_CellSelectionCallback(hObject, eventdata, handles)
% hObject    handle to balloonTable (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.TABLE)
%	Indices: row and column indices of the cell(s) currently selecteds
% handles    structure with handles and user data (see GUIDATA)

global selected_cells;
selected_cells = eventdata.Indices;



function editNumBalloonOutput_Callback(hObject, eventdata, handles)
% hObject    handle to editNumBalloonOutput (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editNumBalloonOutput as text
%        str2double(get(hObject,'String')) returns contents of editNumBalloonOutput as a double


% --- Executes during object creation, after setting all properties.
function editNumBalloonOutput_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editNumBalloonOutput (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editLatCovg_Callback(hObject, eventdata, handles)
% hObject    handle to editLatCovg (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editLatCovg as text
%        str2double(get(hObject,'String')) returns contents of editLatCovg as a double


% --- Executes during object creation, after setting all properties.
function editLatCovg_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editLatCovg (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editLonCovg_Callback(hObject, eventdata, handles)
% hObject    handle to editLonCovg (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editLonCovg as text
%        str2double(get(hObject,'String')) returns contents of editLonCovg as a double


% --- Executes during object creation, after setting all properties.
function editLonCovg_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editLonCovg (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbuttonCOVGcalc.
function pushbuttonCOVGcalc_Callback(hObject, eventdata, handles)
% hObject    handle to pushbuttonCOVGcalc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Execute coverage calculation by pressing "calculate" button
pushbuttonAREA_gui;

% --- Executes on button press in pushbuttonNUMcalc.
function pushbuttonNUMcalc_Callback(hObject, eventdata, handles)
% hObject    handle to pushbuttonNUMcalc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Execute area target script by pressing button
pushbuttonAREAtarget_gui;


function editFloatAlt2_Callback(hObject, eventdata, handles)
% hObject    handle to editFloatAlt2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editFloatAlt2 as text
%        str2double(get(hObject,'String')) returns contents of editFloatAlt2 as a double


% --- Executes during object creation, after setting all properties.
function editFloatAlt2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editFloatAlt2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editFloatAlt1_Callback(hObject, eventdata, handles)
% hObject    handle to editFloatAlt1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editFloatAlt1 as text
%        str2double(get(hObject,'String')) returns contents of editFloatAlt1 as a double


% --- Executes during object creation, after setting all properties.
function editFloatAlt1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editFloatAlt1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in checkboxDefault.
function checkboxDefault_Callback(hObject, eventdata, handles)
% hObject    handle to checkboxDefault (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkboxDefault


% --- Executes on button press in checkboxCustom.
function checkboxCustom_Callback(hObject, eventdata, handles)
% hObject    handle to checkboxCustom (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkboxCustom


% --- Executes on button press in radiobuttonDefault.
function radiobuttonDefault_Callback(hObject, eventdata, handles)
% hObject    handle to radiobuttonDefault (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobuttonDefault


% --- Executes on button press in radiobuttonCustom.
function radiobuttonCustom_Callback(hObject, eventdata, handles)
% hObject    handle to radiobuttonCustom (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobuttonCustom



function editFloatAlt_Callback(hObject, eventdata, handles)
% hObject    handle to editFloatAlt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editFloatAlt as text
%        str2double(get(hObject,'String')) returns contents of editFloatAlt as a double


% --- Executes during object creation, after setting all properties.
function editFloatAlt_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editFloatAlt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editFloatDur_Callback(hObject, eventdata, handles)
% hObject    handle to editFloatDur (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editFloatDur as text
%        str2double(get(hObject,'String')) returns contents of editFloatDur as a double


% --- Executes during object creation, after setting all properties.
function editFloatDur_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editFloatDur (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenuGasList.
function popupmenuGasList_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenuGasList (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenuGasList contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenuGasList


% --- Executes during object creation, after setting all properties.
function popupmenuGasList_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenuGasList (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editOtherBalloon_Callback(hObject, eventdata, handles)
% hObject    handle to editOtherBalloon (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editOtherBalloon as text
%        str2double(get(hObject,'String')) returns contents of editOtherBalloon as a double


% --- Executes during object creation, after setting all properties.
function editOtherBalloon_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editOtherBalloon (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbuttonCalcTraj.
function pushbuttonCalcTraj_Callback(hObject, eventdata, handles)
% hObject    handle to pushbuttonCalcTraj (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
pushbuttonCalcTraj_gui;


function editFilename_Callback(hObject, eventdata, handles)
% hObject    handle to editFilename (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editFilename as text
%        str2double(get(hObject,'String')) returns contents of editFilename as a double


% --- Executes during object creation, after setting all properties.
function editFilename_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editFilename (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes when selected cell(s) is changed in balloonTableTraj.
function balloonTableTraj_CellSelectionCallback(hObject, eventdata, handles)
% hObject    handle to balloonTableTraj (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.TABLE)
%	Indices: row and column indices of the cell(s) currently selecteds
% handles    structure with handles and user data (see GUIDATA)

global selected_cells_traj;
selected_cells_traj = eventdata.Indices;



function editLaunchTime_Callback(hObject, eventdata, handles)
% hObject    handle to staticLaunchTime (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of staticLaunchTime as text
%        str2double(get(hObject,'String')) returns contents of staticLaunchTime as a double


% --- Executes during object creation, after setting all properties.
function staticLaunchTime_CreateFcn(hObject, eventdata, handles)
% hObject    handle to staticLaunchTime (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function editLaunchTime_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editLaunchTime (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editSTKstarttime_Callback(hObject, eventdata, handles)
% hObject    handle to editSTKstarttime (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editSTKstarttime as text
%        str2double(get(hObject,'String')) returns contents of editSTKstarttime as a double


% --- Executes during object creation, after setting all properties.
function editSTKstarttime_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editSTKstarttime (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editSTKstoptime_Callback(hObject, eventdata, handles)
% hObject    handle to editSTKstoptime (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editSTKstoptime as text
%        str2double(get(hObject,'String')) returns contents of editSTKstoptime as a double


% --- Executes during object creation, after setting all properties.
function editSTKstoptime_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editSTKstoptime (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editSTKtimestep_Callback(hObject, eventdata, handles)
% hObject    handle to editSTKtimestep (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editSTKtimestep as text
%        str2double(get(hObject,'String')) returns contents of editSTKtimestep as a double


% --- Executes during object creation, after setting all properties.
function editSTKtimestep_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editSTKtimestep (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
