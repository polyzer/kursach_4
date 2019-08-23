fileformat = 'e:\\BosphorusDB\\BosphorusDB\\BosphorusDB\\bs000\\%s';
outFileformat = 'clouds/self_ff_pc%03d';
outFileformatT = 'clouds/self_ff_pc%03d_trans';
s=1;
e=104;

files  = dir ('e:/BosphorusDB/BosphorusDB/BosphorusDB/bs000/*.bnt');
filename0 = sprintf(fileformat,'bs000_N_N_0.bnt');
pc0=BosphorusReadPoincloud(filename0);
pcwrite(pc1T,sprintf(outFileformat,0),'PLYFormat','binary');
[count, ~] = size(files);
for i = s:count
    
    filename1 = files(i).name;
    pc1=BosphorusReadPoincloud(sprintf(fileformat,filename1));
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
writetable(T,'BosphorusHDSelfFullFaceTest.xlsx', "Sheet",1,"Range", "A1");