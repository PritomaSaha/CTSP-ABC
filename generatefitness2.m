function [fitv,benefit] = generatefitness2(populationvalue,distancevalues,profitsvalue,num_cities)
    num_city=num_cities;
    cost=[0,0];
    prof=[0,0];
    speed=50;
    visited = zeros(1, num_city);
    timex = zeros(1,num_city);
    %disp('population 1')
    %disp(populationvalue{1}(1))
    %disp('population 2')
    %disp(populationvalue{2}(1))
    %visited array will have code based system, 
    %if visit(i)=1, then 1st competitor first visited
    %if visit(i)=2, then 2nd competitor first visited
    %if visit(i)=3, then both competitor visited together
    visited(populationvalue{1}(1))=1;
    visited(populationvalue{2}(1))=2;
    timex(populationvalue{1}(1))=0.0;
    timex(populationvalue{2}(1))=0.0;
    pop_1=populationvalue{1}(populationvalue{1}~=0);
    pop_2=populationvalue{2}(populationvalue{2}~=0);
    len_1=length(pop_1);
    len_2=length(pop_2);
    time1=zeros(1,len_1+1);
    time2=zeros(1,len_2+1);
    for i=2:len_1
       city1=populationvalue{1}(i);
       time1(i)=time1(i-1)+(double(distancevalues(pop_1(i-1),city1))/double(speed));
       visited(city1)=1;
       timex(city1)=time1(i);
    end
    time1(len_1+1)=time1(len_1)+(double(distancevalues(pop_1(len_1),pop_1(1)))/double(speed));
    for i=2:len_2
       city2=populationvalue{2}(i);
       time2(i)=time2(i-1)+(double(distancevalues(pop_2(i-1),city2))/double(speed));
       if timex(city2)==0
           visited(city2)=2;
       elseif timex(city2) > time2(i)
           visited(city2)=2;
       elseif timex(city2)== time2(i)
           visited(city2)=3;
       end
    end
    time2(len_2+1)=time2(len_2)+(double(distancevalues(pop_2(len_2),pop_2(1)))/double(speed));
    for i= 2:num_city
        from=populationvalue{1}(i-1);
        to=populationvalue{1}(i);
        if to~=0
           cost(1)=cost(1)+(0.2)*distancevalues(from,to);
        else
            cost(1)=cost(1)+(0.2)*distancevalues(from,populationvalue{1}(1));
            break;
        end
    end
    to=populationvalue{1}(num_cities);
    if to~=0
        cost(1)=cost(1)+ (0.2)*distancevalues(to,populationvalue{1}(1));
    end
    for i= 2:num_city
        from=populationvalue{2}(i-1);
        to=populationvalue{2}(i);
        if to~=0
           cost(2)=cost(2)+(0.2)*distancevalues(from,to);
        else
            cost(2)=cost(2)+(0.2)*distancevalues(from,populationvalue{2}(1));
            break;
        end
    end
    to=populationvalue{2}(num_cities);
    if to~=0
        cost(2)=cost(2)+(0.2)*distancevalues(to,populationvalue{2}(1));
    end
    
    
    for i=1:num_city
        if visited(i)==1
            prof(1)=prof(1)+profitsvalue(i);
        end
        if visited(i)==2
            prof(2)=prof(2)+profitsvalue(i);
        end
        if visited(i)==3
            prof(1)=prof(1)+(profitsvalue(i)/2);
            prof(2)=prof(2)+(profitsvalue(i)/2);
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
    
end

