%% Input variables
pigeonNumber = 1;
sessionNumber = 1;

%% Init toolbox
start;
experimentalConditions;

initWindow(2);


%% Start session
certainGroup = ismember(pigeonNumber, exp.certainGroup);
uncertainGroup = ismember(pigeonNumber, exp.uncertainGroup);

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
    
    save2File(result);
else
    % pre 2
end


%% Shutdown toolbox
closeWindow;