function randomValue = getRandomNeighbour(rangeStart, rangeEnd, excludedNumber)
    while true
        randomValue = randi([rangeStart, rangeEnd]);
        if randomValue ~= excludedNumber
            break;
        end
    end
end
