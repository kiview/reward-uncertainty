
%% Grouping of pigeons by number
exp.uncertainGroup = [3 4];
exp.certainGroup = [1 2];

%% Misc
exp.pretraining.itiMin = 1; % 20
exp.pretraining.itiMax = 1; % 80
exp.pretraining.stimulusDuration = 2; % 2

exp.pretraining.initialDuration = 8;
exp.pretraining.terminalDuration = 2;

% TODO: real colors
exp.pretraining.rewardColor = loadImage(['stimuli/' 'red.jpg']);
exp.pretraining.nonRewardColor = loadImage(['stimuli/' 'white.jpg']);
exp.pretraining.initialStimulus1 = loadImage(['stimuli/' 'red.jpg']); % brown
exp.pretraining.initialStimulus2 = loadImage(['stimuli/' 'red.jpg']); % blue
exp.pretraining.terminalStimulus1 = loadImage(['stimuli/' 'red.jpg']); % yellow
exp.pretraining.terminalStimulus2 = loadImage(['stimuli/' 'red.jpg']); % grey


exp.pretraining.phase1Trials = 8; % trials per terminal-link stimulus
exp.pretraining.phase2Trials = 8; % trials per initial-terminal-link pair