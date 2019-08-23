function a = DeTest(name)

    files_number = 30 ;
    step = 5;
    count =fix(files_number/step) - 1;
    a = 0;

    %files{i}

    for i=1:count
        i
        a = a + step;
        %files{i} = num2str(a)+" "+num2str(a+step);
        num_a = sprintf('%06d',a);
        num_step = sprintf('%06d',a + step);
        rgb1 = imread(strcat(name,'\rgb\image',num_a,'.png'));
        depth1 = imread(strcat(name,'\depth\depth',num_a,'.png'));
        rgb2 = imread(strcat(name,'\rgb\image',num_step,'.png'));
        depth2 = imread(strcat(name,'\depth\depth',num_step,'.png'));
        [t1,t2,t3]=decalculating(name, rgb1,depth1,rgb2,depth2,num_a,num_step);
        out(i,:)=t1;
        time1(i,:)=t2;
        time2(i,:)=t3;
    end
    timeA=(mean(time1)+mean(time2))/2;
    STR={'Without','MDR','MDA','MDM','M1R','M1A','M1M','GHR','GHA','GHM'};

    T=table(STR',out',timeA')
    %T1=table(STR',time1')
    %T2=table(STR',time2')
    %T1=table(files, kdn_t1, kdn_t2, bill_t1, bill_t2, medi_t1, medi_t2, medi2_t1, medi2_t2, roifill_t1, roifill_t2)

    writetable(T,strcat('out1_', name,'.xlsx'), "Sheet",1,"Range", "A1")
    %writetable(T1,"time.xlsx", "Sheet",1,"Range", "A1")

end