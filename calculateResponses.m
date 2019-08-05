function out = calculateResponses(keyOut)

out.respPerTrial = size(keyOut.raw, 1);

responseTimes = keyOut.rawData(:, 1);
offset = responseTimes(1);
correctedTimes = responseTimes - offset;
responsesForSeconds = floor(correctedTimes);

highestValue = responsesForSeconds(end);
respPerSeconds = zeros(highestValue);
for n = 1:(highestValue + 1)
    respPerSeconds(n) = sum(responsesForSeconds == n-1);
end

out.respPerTrialPerSec = respPerSeconds;

end

