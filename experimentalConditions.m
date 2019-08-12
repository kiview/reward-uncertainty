
%% Grouping of pigeons by number
exp.uncertainGroup = [3 4];
exp.uncertainGroupFirstHalf = [3];

exp.certainGroup = [1 2];
exp.certainGroupFirstHalf = [1];

%% Misc
exp.feedingTime = 4;

exp.pretraining.itiMin = 1; % 20
exp.pretraining.itiMax = 1; % 80
exp.pretraining.stimulusDuration = 2; % 2

exp.pretraining.initialDuration = 8;
exp.pretraining.terminalDuration = 2;

exp.pretraining.rewardColor = loadImage(['stimuli/' 'yellow.jpg']);
exp.pretraining.nonRewardColor = loadImage(['stimuli/' 'grey.jpg']);
exp.pretraining.initialStimulus1 = loadImage(['stimuli/' 'brown.jpg']); % brown
exp.pretraining.initialStimulus2 = loadImage(['stimuli/' 'blue.jpg']); % blue
exp.pretraining.terminalStimulus1 = loadImage(['stimuli/' 'yellow.jpg']); % yellow
exp.pretraining.terminalStimulus2 = loadImage(['stimuli/' 'grey.jpg']); % grey


exp.pretraining.phase1Trials = 8; % trials per terminal-link stimulus
exp.pretraining.phase2Trials = 8; % trials per initial-terminal-link pair

exp.training.phase1Trials = 8; % trials per initial-terminal-link pair
exp.training.initialDuration = 8;
exp.training.terminalDuration = 2;
exp.training.initialDurationLong = 24; % long 