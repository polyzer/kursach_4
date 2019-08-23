%[before, after] = calculate('Data/rgb/image00a0010.png', 'Data/depth/depth000010.png','Data/rgb/image000015.png','Data/depth/depth000015.png')
clear all;
close all;
clc;
f_numbers=[1 2 4 10 18 28 42 60];
count=length(f_numbers)-1;
%files=cell(count, 1);
%without_alg=zeros(count,1);
out=zeros(count,9);
time1=zeros(count,9);
time2=zeros(count,9);
for i=1:count
    i
    files{i} = num2str(f_numbers(i))+" "+num2str(f_numbers(i+1));
    rgb1 = 'Data/rgb/r (';
    rgb1 = strcat(rgb1, num2str(f_numbers(i)));
    rgb1 = strcat(rgb1,').png');
    depth1 = 'Data/depth/d (';
    depth1 = strcat(depth1, num2str(f_numbers(i)));
    depth1 = strcat(depth1,').png');
    rgb2 = 'Data/rgb/r (';
    rgb2 = strcat(rgb2, num2str(f_numbers(i+1)));
    rgb2 = strcat(rgb2,').png');
    depth2 = 'Data/depth/d (';
    depth2 = strcat(depth2, num2str(f_numbers(i+1)));
    depth2 = strcat(depth2,').png');
    [t1,t2, t3]=decalculating(rgb1, depth1, rgb2, depth2);
    for z=1:9
        out(i,z)=t1(1,z);
        time1(i,z)=t2(1,z);
        time2(i,z)=t3(1,z);
    end
end
%T=table(files, without_alg, kdn, bill, medi, medi2, roifill)
%T1=table(files, kdn_t1, kdn_t2, bill_t1, bill_t2, medi_t1, medi_t2, medi2_t1, medi2_t2, roifill_t1, roifill_t2)
%writetable(T,"out1.xlsx", "Sheet",1,"Range", "A1")
%writetable(T1,"time.xlsx", "Sheet",1,"Range", "A1")