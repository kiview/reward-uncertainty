function out = pretrainingPhase1(numTrials, minIti, maxIti, stimulusDuration, rewardImage, nonRewardImage, certaintyGroup)

if certaintyGroup
    trials = ones(1, numTrials);
else
    trials = randomOrder(2, numTrials * 2, 'boolean');
end

out = zeros(size(trials, 2), 5);

i = 1;
for trial = trials
    fprintf("No. of Trial: %i \n", i);
    resultRow = out(i, :); % TODO: how to get reference instead of value?
    resultRow(1) = i;
    
    %% ITI
    itiTime = randi([minIti, maxIti]);
    fprintf("ITI: %is \n", itiTime);
    
    showStimuli;
    pause(itiTime);
    
    %% TL
    if trial % truethiness based on randomOrder generating booleans
        %% Reward
        disp("Show TL reward    ");
        showStimuli(rewardImage, 2);
        %resultRow(2) = rewardImage; FIXME
        keyOut = keyBuffer(stimulusDuration);
        disp(keyOut);
        disp("food, yummi"); % TODO: real food plz
        resultRow(4) = 1;
    else
        %% Terminal Link non reward
        disp("Show TL no reward");
        showStimuli(nonRewardImage, 2);
        %resultRow(2) = nonRewardImage; FIXME
        keyOut = keyBuffer(stimulusDuration);
        resultRow(4) = 0;
    end
    resultRow(3) = size(keyOut.raw, 1);
    % TODO: resultRow(5) = somesupercomplexcalctoget responses/seconds

    out(i, :) = resultRow; % override the row because I'm stupid 
    i = i + 1;
end

showStimuli;

end

