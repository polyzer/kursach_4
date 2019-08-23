clear all;
close all;
clc;

files_number = 6 ;
step = 1;
count =fix(files_number/step) - 1;
a = 0;

%files{i}

for i=1:count
    i
    a = a + step;
    %files{i} = num2str(a)+" "+num2str(a+step);
    rgb1 = imread(strcat('lion\rgb\image00000',num2str(a),'.png'));
    depth1 = imread(strcat('lion\depth\depth00000',num2str(a),'.png'));
    rgb2 = imread(strcat('lion\rgb\image00000',num2str(a+step),'.png'));
    depth2 = imread(strcat('lion\depth\depth00000',num2str(a+step),'.png'));
    [t1,t2,t3]=decalculating(rgb1,depth1,rgb2,depth2,num2str(a),num2str(a+step));
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
writetable(T,"out1_.xlsx", "Sheet",1,"Range", "A1")
%writetable(T1,"time.xlsx", "Sheet",1,"Range", "A1")