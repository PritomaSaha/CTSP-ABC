function outputPath = generateCitiesAndDistances(numCities, areaSize, outputFolder)
    % Input:
    %   - numCities: Number of cities
    %   - areaSize: Size of the square area
    %   - outputFolder: Folder where the CSV file will be stored
    
    % Generate random coordinates for the cities within the square area
    cityCoordinates = rand(numCities, 2) * areaSize;

    % Calculate Euclidean distance between each pair of cities (vectorized)
    xDiff = cityCoordinates(:, 1) - cityCoordinates(:, 1)';
    yDiff = cityCoordinates(:, 2) - cityCoordinates(:, 2)';
    distances = sqrt(xDiff.^2 + yDiff.^2);

    % Round distances to the nearest integer
    distances = round(distances);

    % Create a unique filename based on the current timestamp
    timestamp = datestr(now, '16');
    filename = sprintf('distance_matrix_%s.csv', timestamp);
    
    % Construct the full output path
    outputPath = fullfile(outputFolder, filename);

    % Save the distances matrix to a CSV file
    csvwrite(outputPath, distances);

    % Display the generated coordinates and distances
    disp('City Coordinates:');
    disp(cityCoordinates);
    disp('Euclidean Distances (as integers):');
    disp(distances);

    % Plot the cities on a scatter plot
    figure;
    scatter(cityCoordinates(:, 1), cityCoordinates(:, 2), 'filled');
    title('City Locations');
    xlabel('X-coordinate');
    ylabel('Y-coordinate');
    axis([0 areaSize 0 areaSize]);
    grid on;
end
