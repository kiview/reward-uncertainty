function out = pretrainingPhase2(numTrials, minIti, maxIti, inititalDuration, ...
    initialStimulus1, initialStimulus2, terminalDuration, terminalStimulus1, ...
    terminalStimulus2, certaintyGroup)

%% Trial mapping
% 1 -> i1 t1
% 2 -> i2 t1
% 3 -> i1 t2
% 4 -> i2 t2

if certaintyGroup
    trials = randomOrder(2, numTrials * 2);
else
    trials = randomOrder(4, numTrials * 4);
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
    switch trial
        case 1
            out(i).response = performInitialTerminalStimulusTrial(inititalDuration, initialStimulus1, terminalDuration, terminalStimulus1, 1);
        case 2
            out(i).response = performInitialTerminalStimulusTrial(inititalDuration, initialStimulus2, terminalDuration, terminalStimulus2, 1);
    end
            
    i = i + 1;
end

showStimuli;

end

function out = performInitialTerminalStimulusTrial(inititalDuration, initialImage, terminalDuration, terminalImage, rewarded)
    showStimuli(initialImage, 2);
    out.initial = keyBuffer(inititalDuration);
    
    showStimuli(terminalImage, 2);
    out.terminal = keyBuffer(terminalDuration);
    
    if rewarded
        disp("food, yummi"); % TODO: real food plz
        out.rewarded = 1;
    else
        out.rewarded = 0;
    end

end