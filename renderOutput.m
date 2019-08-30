function out = renderOutput(in)

    s = size(in);
    numTrials = s(2);

    for i = 1:numTrials
        
        trialResult = in(i);
        if (isfield(trialResult, 'response'))
            trialResult = trialResult.response;
        end
        
        
        out(i).trial = i;
        out(i).rewarded = trialResult.rewarded;
        out(i).cs = trialResult.cs.Filename;
        
        out(i).t_respPerTrial = [trialResult.terminal.respPerTrial];
        out(i).t_respPerTrialPerSec = [trialResult.terminal.respPerTrialPerSec];
        
        if isfield(trialResult, 'initial')
            out(i).i_respPerTrial = [trialResult.initial.respPerTrial];
            out(i).i_respPerTrialPerSec = [trialResult.initial.respPerTrialPerSec];
        end
        
        out(i).debug = in(i);
        i = i + 1;
    end

end

