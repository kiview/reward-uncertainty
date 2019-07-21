
%% Grouping of pigeons by number
exp.uncertainGroup = [3 4];
exp.certainGroup = [1 2];

%% Misc
exp.pretraining.itiMin = 1; % 20
exp.pretraining.itiMax = 1; % 80
exp.pretraining.stimulusDuration = 0.1; % 2
exp.pretraining.rewardColor = loadImage(['stimuli/' 'red.jpg']);
exp.pretraining.nonRewardColor = loadImage(['stimuli/' 'white.jpg']);

exp.pretraining.phase1Trials = 8; % trials per terminal-link stimulus
