function [result,time1,time2]=decalculating(name, InRGB1,InDepth1,InRGB2,InDepth2,i1,i2)

%STR={'MS2','MS4','MS8'};
STR={'MDR','MDA','MDM','M1R','M1A','M1M','GHR','GHA','GHM'};
try
        result(1) = ICPim(InRGB1, InDepth1, InRGB2, InDepth2);
    catch e
        result(1) = -1;
end
time1(1)=0;
time2(1)=0;
count = length(STR);
for i=2:(count+1)
   tic
   out1=DE(InRGB1,InDepth1,STR{i-1});
   time1(i)=toc;
   tic
   out2=DE(InRGB2,InDepth2,STR{i-1});
   time2(i)=toc;
   mkdir(strcat('out',name,'_/',STR{i-1},'/'))
   imwrite(uint16(out1),strcat('out',name,'_/',STR{i-1},'/',i1,'.png'));
   imwrite(uint16(out2),strcat('out',name,'_/',STR{i-1},'/',i2,'.png'));
   try
        result(i) = ICPim(InRGB1,out1,InRGB2,out2);
   catch e
        result(i) = -1;
   end
end

end