function out = pretrainingPhase1(numTrials, minIti, maxIti, stimulusDuration, rewardImage, nonRewardImage, certaintyGroup)

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
        disp("food, yummi"); % TODO: real food plz
        out(i).rewarded = 1;
    else
        %% Terminal Link non reward
        disp("Show TL no reward");
        showStimuli(nonRewardImage, 2);
        out(i).cs = nonRewardImage;
        keyOut = keyBuffer(stimulusDuration);
        out(i).rewarded = 0;
    end
    out(i).respPerTrial = size(keyOut.raw, 1);
    
    responseTimes = keyOut.rawData(:, 1);
    offset = responseTimes(1);
    correctedTimes = responseTimes - offset;
    responsesForSeconds = floor(correctedTimes);
    [respPerSeconds, ~] = hist(responsesForSeconds, unique(responsesForSeconds));
    out(i).respPerTrialPerSec = respPerSeconds;

    i = i + 1;
end

showStimuli;

end

