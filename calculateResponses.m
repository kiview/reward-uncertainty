function out = calculateResponses(keyOut)

out.debug = keyOut;

if keyOut.raw(1) == 0
    out.respPerTrial = 0;
    out.respPerTrialPerSec = 0;
    return;
end

duration = floor(keyOut.stop - keyOut.start);

out.respPerTrial = size(keyOut.raw, 1);

responseTimes = keyOut.rawData(:, 1);
offset = responseTimes(1);
correctedTimes = responseTimes - offset;
responsesForSeconds = floor(correctedTimes);

highestValue = responsesForSeconds(end);
respPerSeconds = zeros(highestValue + 1, 1);
for n = 0:(duration - 1)
    respPerSeconds(n + 1) = sum(responsesForSeconds == n);
end

out.respPerTrialPerSec = respPerSeconds;

end

