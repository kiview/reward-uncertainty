function out = pretrainingPhase1(numTrials, minIti, maxIti, stimulusDuration, rewardImage, nonRewardImage, certaintyGroup)
experimentalConditions;

if certaintyGroup
    trials = ones(1, numTrials);
else
    trials = randomOrder(2, numTrials * 2, 'boolean');
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
    if trial % truethiness based on randomOrder generating booleans
        %% Reward
        disp("Show TL reward");
        showStimuli(rewardImage, 2);
        out(i).cs = rewardImage;
        keyOut = keyBuffer(stimulusDuration);
        feeding(exp.feedingTime);
        out(i).rewarded = 1;
    else
        %% Terminal Link non reward
        disp("Show TL no reward");
        showStimuli(nonRewardImage, 2);
        out(i).cs = nonRewardImage;
        keyOut = keyBuffer(stimulusDuration);
        out(i).rewarded = 0;
    end

    out(i).terminal = calculateResponses(keyOut);

    i = i + 1;
end

showStimuli;

end

