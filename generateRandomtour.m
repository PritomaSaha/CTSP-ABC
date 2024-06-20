function resultArray = generateRandomtour(startvalue,num_cities)
    numCities=num_cities;
    randomTourWithoutStart = setdiff(randperm(numCities+1), startvalue+1);
    randomTourWithoutStart = randomTourWithoutStart(randperm(length(randomTourWithoutStart)));
    %randomTourWithoutStart(randi([2,20]))=[];
    %disp(['Randometourw/ostart' num2str(randomTourWithoutStart)]);
    % Insert startValue at the beginning of the permutation
    randomTour = [startvalue+1, randomTourWithoutStart];

    resultArray=randomTour-1;
    % %display the random tour
    %%disp('Random Tour:');
    %%disp(resultArray); % Adjust for city numbering starting from 0
    for i= 1:length(resultArray)
        if resultArray(i) == 0
            if i < length(resultArray)
                resultArray(i+1) = 0;
            end
        end
    end
end
