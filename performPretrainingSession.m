function out = performPretrainingSession(numTrials, minIti, maxIti, stimulusDuration, trialTypes)
experimentalConditions;

differentTrialTypes = size(trialTypes, 2);

if differentTrialTypes == 1
    trials = ones(1, numTrials);
else
    trials = randomOrder(differentTrialTypes, numTrials * differentTrialTypes);
end

i = 1;
for trial = trials
    fprintf("No. of Trial: %i \n", i);
    out(i).trial = i; % TODO: preallocate out cell array
    
    %% ITI
    itiTime = randi([minIti, maxIti]);
    fprintf("ITI: %is \n", itiTime);
    
    showStimuli;
    pause(itiTime);
    
    %% TL
    currentType = trialTypes(trial);
    showStimuli(currentType.color, 2);
    out(i).cs = currentType.color;
    keyOut = keyBuffer(currentType.stimulusDuration);
    
    if currentType.reward
        feeding(exp.feedingTime);
        out(i).rewarded = 1;
    else
        out(i).rewarded = 0;
    end

    out(i).terminal = calculateResponses(keyOut);

    i = i + 1;
end

showStimuli;

end

