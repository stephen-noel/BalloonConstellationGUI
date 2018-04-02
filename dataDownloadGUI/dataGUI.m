function varargout = dataGUI(varargin)
% DATAGUI MATLAB code for dataGUI.fig
%      DATAGUI, by itself, creates a new DATAGUI or raises the existing
%      singleton*.
%
%      H = DATAGUI returns the handle to a new DATAGUI or the handle to
%      the existing singleton*.
%
%      DATAGUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in DATAGUI.M with the given input arguments.
%
%      DATAGUI('Property','Value',...) creates a new DATAGUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before dataGUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to dataGUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help dataGUI

% Last Modified by GUIDE v2.5 01-Apr-2018 18:14:58

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @dataGUI_OpeningFcn, ...
                   'gui_OutputFcn',  @dataGUI_OutputFcn, ...
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


% --- Executes just before dataGUI is made visible.
function dataGUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to dataGUI (see VARARGIN)

% Choose default command line output for dataGUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes dataGUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = dataGUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function ddNOAAstring_Callback(hObject, eventdata, handles)
% hObject    handle to ddNOAAstring (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ddNOAAstring as text
%        str2double(get(hObject,'String')) returns contents of ddNOAAstring as a double


% --- Executes during object creation, after setting all properties.
function ddNOAAstring_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ddNOAAstring (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in ddDownload.
function ddDownload_Callback(hObject, eventdata, handles)
% hObject    handle to ddDownload (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function ddURL_Callback(hObject, eventdata, handles)
% hObject    handle to ddURL (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ddURL as text
%        str2double(get(hObject,'String')) returns contents of ddURL as a double


% --- Executes during object creation, after setting all properties.
function ddURL_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ddURL (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ddNOAAupdate_Callback(hObject, eventdata, handles)
% hObject    handle to ddNOAAupdate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ddNOAAupdate as text
%        str2double(get(hObject,'String')) returns contents of ddNOAAupdate as a double


% --- Executes during object creation, after setting all properties.
function ddNOAAupdate_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ddNOAAupdate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ddMinLat_Callback(hObject, eventdata, handles)
% hObject    handle to ddMinLat (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ddMinLat as text
%        str2double(get(hObject,'String')) returns contents of ddMinLat as a double


% --- Executes during object creation, after setting all properties.
function ddMinLat_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ddMinLat (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ddMaxLat_Callback(hObject, eventdata, handles)
% hObject    handle to ddMaxLat (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ddMaxLat as text
%        str2double(get(hObject,'String')) returns contents of ddMaxLat as a double


% --- Executes during object creation, after setting all properties.
function ddMaxLat_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ddMaxLat (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ddMinLon_Callback(hObject, eventdata, handles)
% hObject    handle to ddMinLon (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ddMinLon as text
%        str2double(get(hObject,'String')) returns contents of ddMinLon as a double


% --- Executes during object creation, after setting all properties.
function ddMinLon_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ddMinLon (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ddMaxLon_Callback(hObject, eventdata, handles)
% hObject    handle to ddMaxLon (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ddMaxLon as text
%        str2double(get(hObject,'String')) returns contents of ddMaxLon as a double


% --- Executes during object creation, after setting all properties.
function ddMaxLon_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ddMaxLon (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
