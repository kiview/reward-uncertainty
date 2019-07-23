% start
%
% Call this script to use all functions of the biopsy Toolbox.
%
% INPUTS
%
% INPUTS-OPTIONAL
%
% OUTPUTS
%
% EXAMPLES
%
% Copyright 2007-2016
% CC-GNU GPL by attribution
% Please cite the BioPsychology Toolbox where this function is used.
%       http://biopsytoolbox.sourceforge.net/
%
% See also: mySetup

% VERSION HISTORY:
% Author:  		Tobias Otto, Jonas Rose
% Version: 		2.4
% Last Change:  24.10.2016

% 31.03.08, Tobias: Release version
% 03.04.08, Tobias: added otherwise in switch case statement
% 04.04.08, Tobias: checking arguments in mySetup
% 18.04.08, Tobias: added support for multiple feeders and remapNames
% 13.05.08, Tobias: cleared variable len after usage
% 09.06.08, Tobias: changed name for IO Warrior
% 10.06.08, Tobias: added support for FBI-Science IO interface
% 12.06.08, Tobias: added toolbox info
% 13.06.08, Tobias: more error handling
% 01.07.08, Tobias: added FBI-Science interface completely. Removed other interfaces from path (minor bugfix due to use with SVN files). Cosmetics
% 23.07.08, Tobias: Deleted variable k in the end -> cosmetics
% 11.02.09, Tobias: Added timer for manual shaping
% 08.07.09, Tobias: Added backwardscompatibility for old mysetup.m files (manual shaping entry in SETUP struct)
% 01.10.09, Tobias: struct entry for new startStopDevice function, cosmetics
% 31.10.10, Tobias: Changed date dialog
% 22.02.10, Tobias: Changed code and seed for different MATLAB versions
% 28.02.10, Tobias: Cosmetics (deleted variables), added backwards compatibility for background color entry in SETUP
% 20.04.10, Tobias: Added new io device WarriorBox
% 21.04.10, Tobias: Added new cmex function for parallel port device
% 22.12.11, Tobias: cosmetics
% 21.05.12, Tobias: added RandStream.setGlobalStream for MATLAB versions newer than 2011
% 04.02.2016, Tobias: added check for feeder power option
% 02.03.2016, Tobias: added network IO device and new random function
% 15.07.2016, Tobias: don't copy pnet to current directory (not needed),  more checks for 64 and 32 bit
% 24.10.2016, Tobias: added new network device (based on the instrument controll toolbox)

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DO NOT edit enything beyond this line
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
year = datestr(now,'yyyy');
clc
disp(' ================================================================');
disp('  The BioPsychology Toolbox - A free, open source Matlab Toolbox ');
disp('                      --- 32 and 64 bit --- ');
disp(' ================================================================');
disp('         Developed at the Ruhr University in Bochum, ');
disp('             Institute of Cognitive Neuroscience');
disp(' ');
disp(' Cite the BioPsychology Toolbox where any of the toolbox-functions');
disp('   are used or results obtained using the toolbox are published.');
disp(' ');
disp(['        Copyright 2007-' year ', CC-GNU GPL by attribution']);
disp('             http://biopsytoolbox.sourceforge.net/');
disp(' ');
disp(' ');
disp('Initializing ...');

%% Add global variables
global SETUP
global WINDOW
WINDOW  = [];
on      = 1;
off     = 0;

%% Set new state for rand !!!
% Check MATLAB version
tmp     = version('-release');
tmp1    = tmp(end);
tmp2    = str2double(tmp(1:end-1));

if(tmp2 < 2012 || strcmpi('2012a', tmp))
    error('This MATLAB version is too old. Please update at least to MATLAB 2012b');
elseif(tmp2 >= 2012 && tmp2 < 2015)
    RandStream.setGlobalStream(RandStream('mt19937ar','Seed',sum(100*clock)));
elseif(tmp2 >= 2015)
    rng('shuffle');
end

% Necessary for subfunctions ... since they use toc
tic

%% Get setup information
if(isempty(dir('mySetup.m')))
    disp(' ================================================================');
    disp(' Sorry, but I can''t find the file mySetup.m')
    disp(' Please copy it into the current working directory');
    disp(' ================================================================');
    error('Please solve problem and try again');
else
    mySetup
end

% Order fields
SETUP = orderfields(SETUP);

%% Check backwards compatibility if old mysetup.m files are used
% Do we have the manual shaping entry
if(~isfield(SETUP,'manualShaping'))
    disp(' ================================================================');
    disp(' --> Adding entry for manual shaping to SETUP struct.');
    disp(' This message appears, because you are using an old mysetup.m file.');
    disp(' You don''t have to change anything until you want to use the new');
    disp(' implemented manual shaping feature. See the manual for help');
    disp(' ================================================================');
    SETUP.manualShaping.status = 0;
end

% Do we have a background color entry
if(~isfield(SETUP.screen,'bgColor'))
    disp(' ================================================================');
    disp(' --> Adding entry for background color to SETUP struct.');
    disp(' This message appears, because you are using an old mysetup.m file.');
    disp(' You don''t have to change anything until you want to change');
    disp(' the background color of your stimulus monitor. ');
    disp(' See the manual for help');
    disp(' ================================================================');
    SETUP.screen.bgColor = 'k';
end

% Check for the feeder power option
% Do we have a background color entry
if(~isfield(SETUP.io,'feederPower'))
    disp(' ================================================================');
    disp(' --> Adding entry for feederPower to SETUP struct.');
    disp(' This message appears, because you are using an old mysetup.m file.');
    disp(' You don''t have to change anything until you want to use');
    disp(' a feeder that needs an external power supply. ');
    disp(' See the manual for help');
    disp(' ================================================================');
    SETUP.io.feederPower = [];
end

%% Check inputs in mySetup
% %%%%%%%%%%%%%%%%%%%%%%%%
if(any(SETUP.screen.X > 1))
    disp(' ================================================================');
    disp(' Check entries in mySetup.m! ');
    disp(' At least one entry of the left lower corner in X direction is ');
    disp(' bigger than the screen width itself.');
    disp(' Check entris in section 5 or 6');
    disp(' ================================================================');
    error('Please solve problem and try again');
end

if(any(SETUP.screen.Y > 1))
    disp(' ================================================================');
    disp(' Check entries in mySetup.m! ');
    disp(' At least one entry of the left lower corner in Y direction is ');
    disp(' bigger than the screen height itself.');
    disp(' Check entris in section 5 or 6');
    disp(' ================================================================');
    error('Please solve problem and try again');
end

if(length(SETUP.screen.X) ~= length(SETUP.screen.Y))
    disp(' ================================================================');
    disp(' Check entries in mySetup.m! ');
    disp(' The number of switch positions in X and Y direction aren''t equal');
    disp(' Correct this problem in section 6');
    disp(' ================================================================');
    error('Please solve problem and try again');
end

if(length(SETUP.screen.X)+length(SETUP.screen.Y) ~= ...
        length(SETUP.screen.width)+length(SETUP.screen.height))
    disp(' ================================================================');
    disp(' Check entries in mySetup.m! ');
    disp(' The number of entries of switch positions aren''t equal to the');
    disp(' entries in switch width and height. Correct this problem in ');
    disp(' section 6 or 7.');
    disp(' ================================================================');
    error('Please solve problem and try again');
end

%% Add path, but check which interface is used
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
bioPath = genpath(SETUP.toolboxPath);

switch lower(SETUP.io.interface)
    case 'iowarrior'
        interface = 1;
    case 'parallel'
        interface = 2;
    case 'keyboard'
        interface = 3;
    case 'fbiscience'
        interface = 4;
    case 'warriorbox'
        interface = 5;
    case 'networkbox'
        interface = 7;
    case 'networkboxmatlab'
        interface = 8;
    otherwise
        disp(' ================================================================');
        disp(' Check entries in mySetup.m! ');
        disp(' Please specify correct IO interface in mySetup. Correct this')
        disp(' problem in section 2')
        disp(' ================================================================');
        error('Please solve problem and try again');
end

%% Remove needless path entries to interface dlls
needless = 1:7;
needless(needless==interface) = [];

for i=1:length(needless)
    k=1;
    while(1)
        pos = strfind(bioPath,['Interface' num2str(needless(i))]);
        if(~isempty(pos))
            % Find start of needless entry
            startPos = find(bioPath==';');
            j=1;
            while(startPos(j)<pos(1) && startPos(j+1)<pos(1))
                j=j+1;
            end
            bioPath(startPos(j)+1:startPos(j+1)) = [];
        else
            break;
        end
    end
end
addpath(bioPath);

%% Copy necessary dlls into working directory
% Check for Windows version, because some devices only work with 32 bit
% Windows and MATLAB
pc = computer('arch');
pc = str2double(pc(end-1:end));

if(interface ~= 3)
    curDir = cd;
    switch interface
        case 1
            if(pc == 32)
                if(isempty(dir('iowkit.dll')))
                    copyfile([SETUP.toolboxPath '\IO\Interface' num2str(interface) '\iowkit.dll'] , curDir);
                    disp('Copied iowkit.dll (IO-WARRIOR 40) into the current working directory');
                end
            else
                disp('-------------------------------------------------------------------');
                disp(' The IO Warrior 40 is only supported on Windows 32 bit platforms');
                disp('  Please choose another IO interface');
                disp('-------------------------------------------------------------------');
                error('  I give up! Please solve problem and try again!');
            end
        case 2
            if(pc == 32 && isempty(dir('inpout32.dll')))
                copyfile([SETUP.toolboxPath '\IO\Interface' num2str(interface) '\inpout32.dll'] , curDir);
                disp('Copied inpout32.dll (InpOut32Drv Driver Interface DLL) into the current working directory');
            elseif(pc == 64 && isempty(dir('inpoutx64.dll')))
                copyfile([SETUP.toolboxPath '\IO\Interface' num2str(interface) '\inpoutx64.dll'] , curDir);
                disp('Copied inpoutx64.dll (InpOut32Drv Driver Interface DLL) into the current working directory');
            end
            disp('See http://www.highrez.co.uk/Downloads/InpOut32 or the Highrez Forums (http://forums.highrez.co.uk) for information.');
        case 4
            disp('---------------------------------------------------------');
            disp('  The FBI Science interface isn''t supported anymore!')
            disp('  Please choose another IO interface');
            disp('---------------------------------------------------------');
            error('  I give up! Please solve problem and try again!');
        case 5
            if(pc == 32)
                if(isempty(dir('iowkit.dll')))
                    copyfile([SETUP.toolboxPath '\IO\Interface' num2str(interface) '\iowkit.dll'] , curDir);
                    disp('Copied iowkit.dll (WARRIOR-IO-BOX) into the current working directory');
                end
            else
                disp('-------------------------------------------------------------------');
                disp(' The IO Warrior Box is only supported on Windows 32 bit platforms');
                disp('  Please choose another IO interface');
                disp('-------------------------------------------------------------------');
                error('  I give up! Please solve problem and try again!');
            end
        case 7
            SETUP.networkDIO.initDone   = 0;
        case 8
            SETUP.networkDIO.initDone   = 0;
    end
end

%% Remap pin numbers to names for keyboard use during programming
SETUP.io.remapNames = []; % Struct where the names are stored
% Copy field names and delete unnecessary names
names = fieldnames(SETUP.io);
names(strcmpi(names,'inputKeys')) = [];
names(strcmpi(names,'remapNames')) = [];
names(strcmpi(names,'interface')) = [];
counter = 1;
for i=1:length(names)
    if(~isempty(SETUP.io.(names{i})) && ~ischar(SETUP.io.(names{i})))
        len = length(SETUP.io.(names{i}));
        for j=1:len
            if(SETUP.io.(names{i}) > 0)
                SETUP.io.remapNames{1,SETUP.io.(names{i})(j)} = names{i};
                counter = counter + 1;
            else
                disp(' ================================================================');
                disp([' The value entered in SETUP.io.' names{i} ' is not valid !!!']);
                disp(' Please enter values bigger than zero or an empty matrix []');
                disp(' if no device is attached. See mySetup.m for details');
                disp(' ================================================================');
                error('Please solve problem and try again');
            end
        end
    end
end

%% Init timer for manual shaping
if(SETUP.manualShaping.status == 1)
    disp(' ================================================================');
    disp(' ');
    disp('                 !!! Manual shaping mode is used !!!');
    disp(' ');
    disp(' Please call closeWindow to stop manual shaping.');
    disp(' ================================================================');
    
    SETUP.manualShaping.reward = 0;
    SETUP.manualShaping.timer = timer('TimerFcn','manShap', ...
        'BusyMode','Queue', ...
        'Period',0.05 , ...
        'ExecutionMode','fixedSpacing');
    start(SETUP.manualShaping.timer)
end

%% Add entry in struct for startStopDevice timers
% Let's start with 32 entries. If someone needs more it's added
% automatically. This is done here only for performance reasons
SETUP.startStop.startStopTimer         = [];
SETUP.startStop.startStopTimerIndex    = zeros(1,32);

%% Clear needless variables
clear names counter bioPath i j needless pos startPos interface curDir len
clear tmp k ans year tmp2 tmp1 pc

%% Done
disp('                 ... done');
