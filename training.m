function out = training(numTrials, minIti, maxIti, initialDuration, ...
    initialStimulus1, initialStimulus2, terminalDuration, terminalStimulus1, ...
    terminalStimulus2, certaintyGroup, ratio, initialDuration2, firstGroup)

experimentalConditions;

originalInitialDuration = initialDuration;

%% Trial mapping
% 1 -> i1 t1
% 2 -> i2 t1
% 3 -> i1 t2
% 4 -> i2 t2

if certaintyGroup
    trials = randomOrder(2, numTrials * 4);
else
    trials = randomOrder(4, numTrials * 4, 'ratio', ratio);
end

out.trials = trials;

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
    switch trial
        case 1
            if initialDuration2 && firstGroup
                initialDuration = initialDuration2;
            end
            
            out(i).response = performInitialTerminalStimulusTrial(initialDuration, initialStimulus1, terminalDuration, terminalStimulus1, 1, exp.feedingTime);
        case 2
            if initialDuration2 && ~firstGroup
                initialDuration = initialDuration2;
            end
            
            out(i).response = performInitialTerminalStimulusTrial(initialDuration, initialStimulus2, terminalDuration, terminalStimulus1, 1, exp.feedingTime);
        case 3
            if initialDuration2 && firstGroup
                initialDuration = initialDuration2;
            end
            
            out(i).response = performInitialTerminalStimulusTrial(initialDuration, initialStimulus1, terminalDuration, terminalStimulus2, 0, exp.feedingTime);
        case 4
            if initialDuration2 && ~firstGroup
                initialDuration = initialDuration2;
            end
            
            out(i).response = performInitialTerminalStimulusTrial(initialDuration, initialStimulus2, terminalDuration, terminalStimulus2, 0, exp.feedingTime);
    end
    initialDuration = originalInitialDuration;
    i = i + 1;
end

showStimuli;

end

function out = performInitialTerminalStimulusTrial(inititalDuration, initialImage, terminalDuration, terminalImage, rewarded, feedingTime)
    showStimuli(initialImage, 2);
    out.initial = keyBuffer(inititalDuration);
    out.initial = calculateResponses(out.initial);
    
    out.csi = initialImage;
    
    showStimuli(terminalImage, 2);
    out.terminal = keyBuffer(terminalDuration);
    out.terminal = calculateResponses(out.terminal);
    
    out.cs = terminalImage;
    
    if rewarded
        feeding(feedingTime);
        out.rewarded = 1;
    else
        out.rewarded = 0;
    end
    

end