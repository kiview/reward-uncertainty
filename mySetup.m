function mySetup

% function [] = mySetup()
%
% This function initializes the Biopsy Toolbox and sets all basic parameters
% of the setup in use. This function needs to be stored on each
% experimental computer. All required hardware definitions are stored in
% the global variable SETUP created by this function. Edit this function when
% building a new setup. Description of specific field names and values can
% be found in the function..
%
% INPUTS
%
% INPUTS-OPTIONAL
%
% OUTPUTS
%
% EXAMPLES
%
% Copyright 2007-2010
% CC-GNU GPL by attribution
% Please cite the BioPsychology Toolbox where this function is used.
%       http://sourceforge.net/projects/biopsytoolbox/
%
% See also:  start

% VERSION HISTORY:
% Author:         Tobias Otto, Jonas Rose
% Version:        0.5
% Last Change:    20.04.2010
%
% 17.04.2008: Tobias: release Version
% 24.04.2008: Tobias: added Touchscreen support
% 25.04.2008: Tobias: changes in comments
% 09.06.2008: Tobias: changed name for IO Warrior
% 10.06.2008: Tobias: added new IO device: fbiscience
% 13.06.2008: Tobias: minor changed in comments
% 11.02.2009: Tobias: added entry for manual shaping
% 07.02.2010: Jonas: Changed header look
% 20.04.2010: Tobias: added warrior box as new io device

%% BUGS/ TODO
% - publish in nature

% TODO:
% * double check comments!

global SETUP

%% (1) Please enter path to the BiopsyToolbox folder
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
SETUP.toolboxPath = 'D:\Dokumente\MATLAB\ToolboxB234';

%% (2) Please choose the IO device
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% The BiopsyToolbox provides nativ access to two different IO devices: the
% IO-Warrior 40 and a self made parallel port Interface. Please choose the
% interface you want to use.
% For training purposes the keyboard can be used as well.
% 'iowarrior'   -> Grants access to the IO-Warrior 40
% 'parallel'    -> Grants access to the self made parallel port interface
% 'warriorbox'  -> Grants access to the self made IO-Warrior interface
% 'fbiscience'  -> Grants access to the FBI-Science IO device
% 'keyboard'    -> For testing your program in your office using the keyboard

SETUP.io.interface = 'keyboard';

%% (3) Please specify the OUTPUT devices
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Each device is connected to a separate pin/output at the output device.
% Please specify the pin numbers for the devices used in the setup. Unused
% outputs should contain an empty matrix.
SETUP.io.houseLight  = 1;
SETUP.io.feeder      = 2;
SETUP.io.feederLight = [];
SETUP.io.punishment  = [];
% Add custom outputs here

%% (4) Please specify the number(s) of the INPUT pins
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Each input device (e.g. real switch or pecking key)
% must be specified here. Physicsal switches are connected to a single
% pin/input to the IO device. Please be aware that the first pin number
% corresponds to the first input key (doesn't matter on which input pin the
% key is connected). That means that the first response key could be
% connected to pin 7 and the second response key to pin 3. That would
% result in [7 3].
SETUP.io.inputKeys     = [1 2 3];
% Add custom inputs here

%% (5) Please specify monitor dimensions
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Screen width and hight in centimeters
width               = 20;
height              = 18;

%% (6) Switch/Image positions in centimeters
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Specify the position of the left lower corner of the switch with
% reference to the left lower corner of the screen.
% REMEMBER for the TOUCH SCREEN that the first number entered in the
% following vectors corresponds to index 1 in the keyBuffer output. The
% second value to index 2 and so on. But only for touchscreens!
SETUP.screen.X        = [1, 6, 12];
SETUP.screen.Y        = [12, 12, 12];

%% (7) Width and height of the switches/ images in centimeters
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Specify the width and height of the switches in centimeters
SETUP.screen.width    = [5, 5, 5];
SETUP.screen.height   = [5, 5, 5];

%% (8) EPHYS SETTINGS
% %%%%%%%%%%%%%%%%%%%
% Set this value to one, if you want to do electrophysiology.
SETUP.ephys.on = 0;

% Enter values for white bar. Default should be okay
SETUP.ephys.photodiode = [0.0,0.95,1,0.05];

%% (9) TOUCH SCREEN SETTINGS
% %%%%%%%%%%%%%%%%%%%%%%%%%%
% Set this value to one, if you want to use a touch screen
SETUP.touchScreen.on = 0;

% Set to one to plot a red dot to the recognised touch location
% Not recommended during experiments!
SETUP.touchScreen.display = 1;

% Enter minimum time between two touches (in seconds)
SETUP.touchScreen.deltaT = 0.005;

% Enter minimum distance between two touches (in pixels)
% After call of initWindow the relative value is computed and replaced
SETUP.touchScreen.deltaP = 10;

%% (10) Manual shaping
% %%%%%%%%%%%%%%%%%%%%
% Set this value to one, if you want to manually reward by pressing the 'f'
SETUP.manualShaping.status = 0;

%% (11) Background color
% Change to background color from black to any another color using short
% names (pre defined in MATLAB) or a RGB triplet ranged from 0 to 1
% Short names:
% 'y' --> [1 1 0] --> yellow
% 'm' --> [1 0 1] --> magenta
% 'c' --> [0 1 1] --> cyan
% 'r' --> [1 0 0] --> red
% 'g' --> [0 1 0] --> green
% 'b' --> [0 0 1] --> blue
% 'w' --> [1 1 1] --> white
% 'k' --> [0 0 0] --> black

SETUP.screen.bgColor = 'k';

%% Please don't change anything beyond this line
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% For Monitor dimensions
SETUP.screen.width  = SETUP.screen.width /width;
SETUP.screen.height = SETUP.screen.height/ height;
SETUP.screen.X      = SETUP.screen.X/width;
SETUP.screen.Y      = SETUP.screen.Y/height;

% For touchscreen
SETUP.touchScreen.time              = 0;
SETUP.touchScreen.lastTime          = 0;
SETUP.touchScreen.localValue        = [0 0];
SETUP.touchScreen.lastLocalValue    = [0 0];
SETUP.touchScreen.globalValue       = [0 0];
SETUP.touchScreen.lastGlobalValue   = [0 0];
SETUP.touchScreen.screenIndex       = 0;
SETUP.touchScreen.lastScreenIndex   = 0;
SETUP.touchScreen.found             = 0;
SETUP.touchScreen.offIndex          = -1;
