%balloonGUI_init
% Julianna Evans
% 06.22.17
% last rev. 02.08.18

%% Initialization for Balloon GUI
% NOTE: This script initializes any Balloon GUI object settings that must be
% changed before utilizing the GUI. Runs through GUI opening function
% (balloonGUI_OpeningFcn).

% Add folder paths
addpath('Atmosphere');
addpath('conversions');
addpath('gui buttons');
addpath('initialize');
addpath('trajectory');

%{
%Set default radio button for the "Custom"/"Default" group on Tab 2
set(handles.uibuttongroup1,'selectedobject',handles.radiobuttonDefault)
%}
%% Set up Nctoolbox, Add to path
setup_nctoolbox;


