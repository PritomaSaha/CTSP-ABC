function changer = generateNeighbourRandomtour(changer,partner,num_cities)
    vc = randi([2, num_cities]);
    %disp('check')
    %disp('changer')
    %disp(changer)
    %disp('partner')
    %disp(partner)
    b_a_1=setdiff(partner{1},changer{1});
    b_a_2=setdiff(partner{2},changer{2});
    len_1=length(b_a_1);
    len_2=length(b_a_2);
    if len_1~=0
       val_1=randi([1,len_1]);
       val_1=b_a_1(val_1);
    else
        val_1=0;
    end
    if len_2~=0
       val_2=randi([1,len_2]);
       val_2=b_a_2(val_2);
    else
        val_2=0;
    end
    %disp('Neighbour tour value')
    %disp(vc)
    %disp(changer{1}(vc))
    %disp(val_1)
    %disp(changer{2}(vc))
    %disp(val_2)
    changer{1}(vc)=val_1;
    changer{2}(vc)=val_2;
    changer10=changer{1}(changer{1}==0);
    changer1n0=changer{1}(changer{1}~=0);
    changer{1}=[changer1n0, changer10];
    changer10=changer{2}(changer{2}==0);
    changer1n0=changer{2}(changer{2}~=0);
    changer{2}=[changer1n0, changer10];
    %disp('Changer =')
    %disp(changer)
end