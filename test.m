clear
clc
clearvars
format longG

num_cities = input('Enter the number of cities: ');
%areaSize = input('Enter the Distance Matrix Coordinate: ');
%outputFolder = 'C:\Users\Pritoma Saha\Desktop\dataset';

%filePath = generateCitiesAndDistances(num_cities, areaSize, outputFolder);

%disp(['CSV file saved at: ' filePath]);
filePath = "C:\Users\Pritoma Saha\Desktop\dataset\sir_dataset";
dataset_number=1;

% Read the numeric data from the CSV file
distanceMatrix = readmatrix(filePath);

% Display the read data
%disp('Euclidean Distances:');
%disp(distances);
[rows, cols] = size(distanceMatrix);
%disp(num2str(rows))
profits = 150 * ones(1, rows);
disp(profits)
output_path = 'C:\Users\Pritoma Saha\Desktop\dataset\';
output_path = [output_path,num2str(dataset_number),'output.csv'];
fileID = fopen(output_path, 'w');
if fileID == -1
    error('Could not open the file for writing.');
end
%fprintf(fileID,'CityA,CityB,Path_A,TimeA,Path_B,TimeB,Path_Union,Benefit_A,Benefit_B,Cost_A,Cost_B,Payoff_A,Payoff_B,Total_Payoff,Average_Payoff\n');
fprintf(fileID, 'start_city1,max_benefit_agent_1,min_benefit_agent_1,avg_ben_a_1,max_cost_agent_1,min_cost_agent_1,avg_cost_a_1,start_city2,max_benefit_agent_2,min_benefit_agent_2,avg_ben_a_2,max_cost_agent_2,min_cost_agent_2,avg_cost_a_2,avg_time,std_deviation\n');
num_employed_bees = 20;
num_onlooker_bees = 20;
max_iterations = 100;
scout_limit = 25;
 
for ii = 1:num_cities
    for jj = 1:num_cities
        %setup data structures
        benefit_data_1=zeros(1,10);
        cost_data_1=zeros(1,10);
        benefit_data_2=zeros(1,10);
        cost_data_2=zeros(1,10);
        time_data_1=zeros(1,10);
        time_data_2=zeros(1,10);
        for abhi=1:10
            start_city1 = ii;
            start_city2 = jj;      
            if ii ~= jj
                population = cell(num_employed_bees,2,num_cities);
                %disp('Initial population')
                for i = 1:num_employed_bees
                % Create a random permutation of cities as a tour
                    population{i}{1} = generateRandomtour(start_city1,num_cities);
                    population{i}{2} = generateRandomtour(start_city2,num_cities);
                %disp([num2str(i) 'th solution']);
                %disp(population{i})
                end
                %disp(population{1});
                fitness=cell(num_employed_bees,1);
                benefit=cell(num_employed_bees,1);
                trials=zeros(num_employed_bees,1);
                probabilities = cell(1,100);
                best5_solution=cell(2,100);
                best_fitness=1000;
            %best_benefit=0;
                for i=1:num_employed_bees
                [fitness{i},benefit{i}]=generatefitness2(population{i},distanceMatrix,profits,num_cities); 
                end
            %disp('initial fitness and benefit')
            %disp(fitness)
            %disp(benefit)
                for iteration = 1:max_iterations
                %Employed bees phase
                for i=1:num_employed_bees
                    random_partner=getRandomNeighbour(1,num_cities,i);
                    newest_value=generateNeighbourRandomtour(population{i},population{random_partner},num_cities);
                    [fitness_new,benefit_new]=generatefitness2(newest_value,distanceMatrix,profits,num_cities);
                    if fitness_new<fitness{i}
                        population{i}=newest_value;
                        fitness{i}=fitness_new;
                        benefit{i}=benefit_new;
                        %disp([num2str(i) 'th solution change in employeed bees phase']);
                        %disp(population{i})
                    else
                        trials(i)=trials(i)+1;
                    end
                end
                %disp('trials after employed phase')
                %disp(trials)
   
                % Calculate probabilities
    

                max_benefit = max(cellfun(@max, benefit));

                for i = 1:numel(fitness)
                    value = 0.9 * (benefit{i}) / (max_benefit) + 0.1;
                    probabilities{i} = value;
                    %disp(value);
                end
                %Onlooker bees phase
                m=0;
                i=1;
                while m<=num_cities
                    r=rand;
                    if r<probabilities{i}
                        random_partner=getRandomNeighbour(1,num_cities,i);
                        newest_value=generateNeighbourRandomtour(population{i},population{random_partner},num_cities);
                        [fitness_new,benefit_new]=generatefitness2(newest_value,distanceMatrix,profits,num_cities);
                        if fitness_new<fitness{i}
                            population{i}=newest_value;
                            fitness{i}=fitness_new;
                            benefit{i}=benefit_new;
                            %disp([num2str(i) 'th solution change in onlooker phase'])
                            %disp(population{i})
                        else
                            trials(i)=trials(i)+1;
                        end
                        m=m+1;
                    end
                    i=i+1;
                    if i>num_cities
                        i=1; 
                    end
                end
                fitnessValues = cellfun(@double, fitness);  % Convert cell array to numeric array

                [minValue, index] = min(fitnessValues);
                if minValue < best_fitness
                    %disp(index);
                    best_solution=population{index};
                    best_fitness=fitness{index};
                    %best_benefit=benefit{index};
                end
   
                %Scout bees phase
                %trialvalues = cellfun(@double, trials);
                [maxValue, index] = max(trials);
                if maxValue >= scout_limit
                    %disp('Scouting...')
                    population{index}{1}=generateRandomtour(start_city1,num_cities);
                    population{index}{2}=generateRandomtour(start_city2,num_cities);
                    %disp([num2str(index) 'th solution change in scout phase'])
                    %disp(population{index})
                    [fitness{index},benefit{index}]=generatefitness2(population{index},distanceMatrix,profits,num_cities);
                end
   
                end
                disp('Final Solution')
                disp(best_solution)
                disp('Its Fitness')
                disp(best_fitness)
            %num_cities=20;
                num_city=num_cities;
                cost=[0,0];
                prof=[0,0];
                speed=50;
                visited = zeros(1, num_city);
                timex = zeros(1,num_city);
                %disp('population 1')
            %disp(best_solution{1}(1))
            %disp('population 2')
            %disp(best_solution{2}(1))
            %visited array will have code based system, 
            %if visit(i)=1, then 1st competitor first visited
            %if visit(i)=2, then 2nd competitor first visited
            %if visit(i)=3, then both competitor visited together
                visited(best_solution{1}(1))=1;
                timex(best_solution{1}(1))=0.0;
                timex(best_solution{2}(1))=0.0;
                visited(best_solution{2}(1))=2;
                pop_1=best_solution{1}(best_solution{1}~=0);
                pop_2=best_solution{2}(best_solution{2}~=0);
                len_1=length(pop_1);
                len_2=length(pop_2);
                time1=zeros(1,len_1+1);
                time2=zeros(1,len_2+1);
                for i=2:len_1
                city1=best_solution{1}(i);
                time1(i)=time1(i-1)+(double(distanceMatrix(pop_1(i-1), city1)) / double(speed));
                visited(city1)=1;
                timex(city1)=time1(i);
                end
                time1(len_1+1)=time1(len_1)+(double(distanceMatrix(pop_1(len_1),pop_1(1)))/double(speed));
                for i=2:len_2
                city2=best_solution{2}(i);
                time2(i)=time2(i-1)+(double(distanceMatrix(pop_2(i-1),city2))/double(speed));
                if timex(city2)==0
                    visited(city2)=2;
                elseif timex(city2) > time2(i)
                    visited(city2)=2;
                elseif timex(city2)== time2(i)
                    visited(city2)=3;
                end
                end
                time2(len_2+1)=time2(len_2)+(double(distanceMatrix(pop_2(len_2),pop_1(1)))/double(speed));
                for i= 2:num_city
                from=best_solution{1}(i-1);
                to=best_solution{1}(i);
                if to~=0
                    cost(1)=cost(1)+(0.2)*distanceMatrix(from,to);
                else
                    cost(1)=cost(1)+(0.2)*distanceMatrix(from,best_solution{1}(1));
                    break;
                end
                end
                to=best_solution{1}(num_cities);
                if to~=0
                    cost(1)=cost(1)+ (0.2)*distanceMatrix(to,best_solution{1}(1));
                end
                for i= 2:num_city
                from=best_solution{2}(i-1);
                to=best_solution{2}(i);
                if to~=0
                    cost(2)=cost(2)+(0.2)*distanceMatrix(from,to);
                else
                    cost(2)=cost(2)+(0.2)*distanceMatrix(from,best_solution{2}(1));
                    break;
                end
                end
                to=best_solution{2}(num_cities);
                if to~=0
                    cost(2)=cost(2)+(0.2)*distanceMatrix(to,best_solution{2}(1));
                end
    
    
                for i=1:num_city
                if visited(i)==1
                    prof(1)=prof(1)+profits(i);
                end
                if visited(i)==2
                    prof(2)=prof(2)+profits(i);
                end
                if visited(i)==3
                    prof(1)=prof(1)+(profits(i)/2);
                    prof(2)=prof(2)+(profits(i)/2);
                end
                end
                sum_cost=sum(cost);
                sum_profit=sum(prof);
                benefit=sum_profit-sum_cost;
                if benefit < 0
                    fitv=1+ abs(benefit);
                else
                    fitv=1/(1+abs(benefit));
                end
                % Count the number of elements in the final path union
                visited_A= best_solution{1}(best_solution{1}~=0);
                visited_B= best_solution{2}(best_solution{2}~=0);
                benefit=[0,0];
                benefit(1)=prof(1)-cost(1);
                benefit(2)=prof(2)-cost(2);
                benefit_data_1(abhi)=prof(1);
                benefit_data_2(abhi)=prof(2);
                cost_data_1(abhi)=benefit(1);
                cost_data_2(abhi)=benefit(2);
                time_data_1(abhi)=time1(len_1+1);
                time_data_2(abhi)=time2(len_2+1);
                best_benefit=benefit(1)+benefit(2);
                un_A= best_solution{1}(best_solution{1}~=0);
                un_B= best_solution{2}(best_solution{2}~=0);
                uni = union(un_A, un_B);
                num_elements_union=numel(uni);

                avg_benefit= best_benefit/2;


                disp(best_solution{1})
                disp(best_solution{2})
            %disp(prof(1))
            %disp(prof(2))
            %disp(cost(1))
            %disp(cost(2))
            %disp(benefit(1))
            %disp(benefit(2))
            %disp(best_benefit)
            %disp(avg_benefit)
                disp(timex)
            end
        end
        [min_benefit_agent_1,max_benefit_agent_1]=bounds(benefit_data_1);
        avg_ben_a_1=mean(benefit_data_1);
        [min_cost_agent_1,max_cost_agent_1]=bounds(cost_data_1);
        avg_cost_a_1=mean(cost_data_1);
        [min_benefit_agent_2,max_benefit_agent_2]=bounds(benefit_data_2);
        avg_ben_a_2=mean(benefit_data_2);
        [min_cost_agent_2,max_cost_agent_2]=bounds(cost_data_1);
        avg_cost_a_2=mean(cost_data_2);
        avg_time=mean(cat(2,time_data_1,time_data_2));
        std_deviation=std(cat(2,time_data_1,time_data_2));
        fprintf(fileID,'%d,%d,%d,%.3f,%d,%d,%.3f,%d,%d,%d,%.3f,%d,%d,%.3f,%.3f,%.3f\n',start_city1,max_benefit_agent_1,min_benefit_agent_1,avg_ben_a_1,max_cost_agent_1,min_cost_agent_1,avg_cost_a_1,start_city2,max_benefit_agent_2,min_benefit_agent_2,avg_ben_a_2,max_cost_agent_2,min_cost_agent_2,avg_cost_a_2,avg_time,std_deviation);
    end
end
fclose(fileID);