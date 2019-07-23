



function out = pretrainingPhase1(numTrials, minIti, maxIti, stimulusDuration, rewardImage, nonRewardImage, shouldReward)
%PRETRAININGPHASE1 Summary of this function goes here
%   Detailed explanation goes here

if shouldReward
    trials = one(1, numTrials);
else
    trials = randomOrder(2, numTrials * 2, 'boolean');
end

i = 1;
for trial = trials
    fprintf("No. of Trial: %i \n", i);
    
    %% ITI
    itiTime = randi([minIti, maxIti]);
    fprintf("ITI: %is \n", itiTime);
    
    showStimuli;
    pause(minIti);
    
    %% Reward
    if trial
        %% Terminal Link reward
        disp("Show terminal link");
        showStimuli(rewardImage, 2);
        keyOut = keyBuffer(stimulusDuration);
        disp(keyOut);
        disp("food, yummi");
    else
        %% Terminal Link non reward
        disp("Show terminal link on reward");
        showStimuli(nonRewardImage, 2);
        keyOut = keyBuffer(stimulusDuration);
    end
   
    i = i + 1;
end

showStimuli;

end

