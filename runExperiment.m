%% Input variables
pStr = inputdlg("Pigeon number");
pigeonNumber = str2num(pStr{1});

sStr = inputdlg("Session number");
sessionNumber = str2num(sStr{1});

subjectPrefix = char(join([pStr sStr], "-"));

%% Init toolbox
start;
experimentalConditions;

initWindow(2);
d = msgbox('Place window ^__^');
waitfor(d);


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
    trialTypes(1).color = exp.pretraining.rewardColor; 
    trialTypes(1).reward = 1;
    trialTypes(1).stimulusDuration = exp.pretraining.stimulusDuration;
    if uncertainGroup
        trialTypes(2).color = exp.pretraining.nonRewardColor; 
        trialTypes(2).reward = 0;
        trialTypes(2).stimulusDuration = exp.pretraining.stimulusDuration;
    end

    result = performPretrainingSession(exp.pretraining.phase1Trials, exp.pretraining.itiMin,...
        exp.pretraining.itiMax, exp.pretraining.stimulusDuration,...
        trialTypes);
elseif sessionNumber <= 12
    % pre 2

    % define trial types (meaning color/reward combinations) for this session
    trialTypes(1).color = exp.pretraining.rewardColor; 
    trialTypes(1).reward = 1;
    trialTypes(1).stimulusDuration = exp.pretraining.stimulusDuration;
    
    trialTypes(2).color = exp.pretraining.initialStimulus1; 
    trialTypes(2).reward = 0;
    trialTypes(2).stimulusDuration = exp.pretraining.initialDuration;
    
    trialTypes(3).color = exp.pretraining.initialStimulus2; 
    trialTypes(3).reward = 0;
    trialTypes(3).stimulusDuration = exp.pretraining.initialDuration;
    
    if uncertainGroup
        trialTypes(4).color = exp.pretraining.nonRewardColor; 
        trialTypes(4).reward = 0;
        trialTypes(4).stimulusDuration = exp.pretraining.stimulusDuration;
    end

    result = performPretrainingSession(exp.pretraining.phase2Trials, exp.pretraining.itiMin,...
        exp.pretraining.itiMax, exp.pretraining.stimulusDuration,...
        trialTypes);
elseif sessionNumber <= 24
    % training 1
    %% Trial mapping
    % 1 -> i1 t1
    % 2 -> i2 t1
    % 3 -> i1 t2
    % 4 -> i2 t2
    result = training(exp.training.phase1Trials, exp.pretraining.itiMin,...
        exp.pretraining.itiMax, exp.training.initialDuration,...
        exp.pretraining.initialStimulus1, exp.pretraining.initialStimulus2,...
        exp.training.terminalDuration, exp.pretraining.terminalStimulus1, exp.pretraining.terminalStimulus2,...
        certainGroup, [0.125 0.125 0.375 0.375], 0, 0);
else
    % training 2
    result = training(exp.training.phase1Trials, exp.pretraining.itiMin,...
        exp.pretraining.itiMax, exp.training.initialDuration,...
        exp.pretraining.initialStimulus1, exp.pretraining.initialStimulus2,...
        exp.training.terminalDuration, exp.pretraining.terminalStimulus1, exp.pretraining.terminalStimulus2,...
        certainGroup, [0.125 0.125 0.375 0.375], exp.training.initialDurationLong, firstHalf);
end

result = renderOutput(result);
save2File(result, "subject", subjectPrefix);


%% Shutdown toolbox
closeWindow;