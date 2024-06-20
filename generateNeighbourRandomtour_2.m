function changer = generateNeighbourRandomtour_2(changer,partner,num_cities)
    vc = randi(2, num_cities);
    value_for_1=num_cities;
    value_for_2=num_cities;
    disp(changer{1})
    disp(partner{1})
    while value_for_1==changer{1}(1) || value_for_1==10
    value_for_1 = randi([min(changer{1}(vc), partner{1}(vc)), max(changer{1}(vc), partner{1}(vc))]);
    end
    disp(['value for 1 is' num2str(value_for_1)])
    if changer{1}(vc)~=0
        index = find(changer{1} == value_for_1);
        if isempty(index)
            changer{1}(vc)=value_for_1;
        else
            changer{1}(index)=changer{1}(vc);
            changer{1}(vc)=value_for_1;
        end
    else
        notInArray1 = isempty(find(changer{1} == value_for_1));
        if notInArray1
            changer{1}(vc)=value_for_1;
            changer{1} = [nonzeros(changer{1}).' zeros(1, nnz(changer{1} == 0))];
        end
    end
     while value_for_2==changer{2}(1) || value_for_2==10
            value_for_2=randi([min(changer{2}(vc), partner{2}(vc)), max(changer{2}(vc), partner{2}(vc))]);
     end
    if changer{2}(vc)~=0
        index = find(changer{2} == value_for_1);
        if isempty(index)
            changer{2}(vc)=value_for_1;
        else
            changer{2}(index)=changer{2}(vc);
            changer{2}(vc)=value_for_1;
        end
    else
        notInArray1 = isempty(find(changer{2} == value_for_1));
        if notInArray1
            changer{2}(vc)=value_for_1;
            changer{2} = [nonzeros(changer{2}).' zeros(1, nnz(changer{2} == 0))];
        end
    end
    %disp(changer)
end
