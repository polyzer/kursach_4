fileformat = 'e:\\BosphorusDB\\BosphorusDB\\BosphorusDB\\bs%03d\\bs%03d_N_N_0.bnt';
outFileformat = 'clouds/pc%03d';
outFileformatT = 'clouds/pc%03d_trans';
s=1;
e=104;
filename0 = sprintf(fileformat,0,0);
pc0=BosphorusReadPoincloud(filename0);

pcwrite(pc1T,sprintf(outFileformat,0),'PLYFormat','binary');
for i = s:e
    
    filename1 = sprintf(fileformat,i,i);
    pc1=BosphorusReadPoincloud(filename1);
    pcwrite(pc1T,sprintf(outFileformat,i),'PLYFormat','binary');
    
    [tform, ~, rmse]= pcregrigid(pc1,pc0);
    pc1T = pctransform(pc1, tform);
    pcwrite(pc1T,sprintf(outFileformatT,i),'PLYFormat','binary');
    
    tic;
    hd=HausdorffDist(pc0.Location,pc1T.Location);
    hdToc = toc;
    res(i,:) = [i; rmse; hd; hdToc];
       
end

T=table(res)
writetable(T,'BosphorusHDTest.xlsx', "Sheet",1,"Range", "A1");