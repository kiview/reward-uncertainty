%% Input variables
pStr = inputdlg("Pigeon number");
pigeonNumber = str2num(pStr{1});

sStr = inputdlg("Session number");
sessionNumber = str2num(sStr{1});

subjectPrefix = join([pigeonNumber sessionNumber], "-");

%% Init toolbox
start;
experimentalConditions;

initWindow(2);


%% Start session
certainGroup = ismember(pigeonNumber, exp.certainGroup);
uncertainGroup = ismember(pigeonNumber, exp.uncertainGroup);
firstHalf = ismember(pigeonNumber, exp.uncertainGroupFirstHalf) || ismember(pigeonNumber, exp.certainGroupFirstHalf);

if certainGroup
    fprintf("Pigeon %i is in certain group\n", pigeonNumber);
elseif uncertainGroup
    fprintf("Pigeon %i is in uncertain group\n", pigeonNumber);
else
    closeWindow;
    error("Unknown pigeon %i", pigeonNumber);
end

if sessionNumber <= 8
    % pre 1
    result = pretrainingPhase1(exp.pretraining.phase1Trials, exp.pretraining.itiMin,...
        exp.pretraining.itiMax, exp.pretraining.stimulusDuration,...
        exp.pretraining.rewardColor, exp.pretraining.nonRewardColor, certainGroup);
elseif sessionNumber <= 12
    % pre 2
    result = pretrainingPhase2(exp.pretraining.phase2Trials, exp.pretraining.itiMin,...
        exp.pretraining.itiMax, exp.pretraining.initialDuration,...
        exp.pretraining.initialStimulus1, exp.pretraining.initialStimulus2,...
        exp.pretraining.terminalDuration, exp.pretraining.terminalStimulus1, exp.pretraining.terminalStimulus2,...
        certainGroup, [1], 0, 0);
elseif sessionNumber <= 24
    % training 1
    result = pretrainingPhase2(exp.training.phase1Trials, exp.pretraining.itiMin,...
        exp.pretraining.itiMax, exp.training.initialDuration,...
        exp.pretraining.initialStimulus1, exp.pretraining.initialStimulus2,...
        exp.training.terminalDuration, exp.pretraining.terminalStimulus1, exp.pretraining.terminalStimulus2,...
        certainGroup, [0.125 0.125 0.375 0.375], 0, 0);
else
    % training 2
    result = pretrainingPhase2(exp.training.phase1Trials, exp.pretraining.itiMin,...
        exp.pretraining.itiMax, exp.training.initialDuration,...
        exp.pretraining.initialStimulus1, exp.pretraining.initialStimulus2,...
        exp.training.terminalDuration, exp.pretraining.terminalStimulus1, exp.pretraining.terminalStimulus2,...
        certainGroup, [0.125 0.125 0.375 0.375], exp.training.initialDurationLong, firstHalf);
end

result = renderOutput(result);
save2File(result, "subject", subjectPrefix);


%% Shutdown toolbox
closeWindow;