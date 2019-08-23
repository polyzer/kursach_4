outDir = 'E:\outdir\lion\';
depthPath = 'c:\Users\SW\Music\CSU\Diploma\models\lion\lion\depth\';
rgbPath = 'c:\Users\SW\Music\CSU\Diploma\models\lion\lion\rgb\';

rgbname = 'image000132';
name = 'depth000132';
grandPath = 'C:\Users\SW\Music\CSU\Diploma\models\lion_gt.screened_decimated\lion_gt.screened_decimated.ply';

fprintf(">>> Read  grandPC <<<\n");
GrandPc =  pcread(grandPath);

STR={'CLE','BF1','BF2','JBU','ADF','NAF','WMF','MR1','MR2','MR3','LBF','MRU','MRK','MRT','MMF','BOF','MF1','MF2','MF3','MDR','MDA','MDM','M1R','M1A','M1M','GHR','GHA','GHM'};
Labels={'Without filtering','Bilateral 1','Bilateral 2','Bilateral Upsampling ','Anisotropic','Noise-aware','Weight Mode','MRF Eq','MRF CG','MRF GC',' Yang Iterative Depth Refinement ','Second Order MRF','Kernel Data Term MRF','MRF + Tensor','Median M filter ','Bilateral Original filter','My Original filter 1','My Original filter 2','My Original filter 3','M_D_5 + R','M_D_5 + A','M_D_5 + M','M_D_5_1 + R','M_D_5_1 + A','M_D_5_1 + M','GH_channel + R','GH_channel + A','GH_channel + M'}';
count = length(STR);
result = zeros(count,1);
time1 = zeros(count,1);
fprintf(">>> Read  images <<<\n");
ImDepth = imread(strcat(depthPath, name, '.png'));
ImRgb = imread(strcat(rgbPath, rgbname, '.png'));

% ToDo  Filter here %
for i=7:(count)
    alg = STR{i};
    fprintf(strcat(">>> alg = ",alg, " (",int2str(i)," of ", int2str(count), ") <<<\n"));
    suc = 1;
    tic
    try
        out2=DE(ImRgb, ImDepth, alg);
    catch e
        fprintf(strcat(">>> ATENSION alg = ",alg, " <<<\n"));
        result(i) = -1;
        suc = 0;
    end
        
    time1(i)=toc;
    tic
    if suc == 1
        DepthPc = depth2cloud_without_color(out2);
        try
            [tform, ~, rmse]= pcregrigid(DepthPc, GrandPc);
            DepthPcT = pctransform(DepthPc, tform);
            result(i) = rmse;
            pcwrite(DepthPcT, strcat(outDir, name, '_', alg, '.ply'));
        catch e
            fprintf(strcat(">>> ATENSION alg = ",alg, " <<<\n"));
            pcwrite(DepthPc, strcat(outDir, name, '_BAD_', alg, '.ply'));
            result(i) = -1;
        end
    end
    T=table(STR',Labels,result,time1);
    writetable(T,strcat(outDir, 'outAllTest_lion_1.xlsx'), "Sheet",1,"Range", "A1")
end

 fprintf(">>> Filtering done <<<\n");
 %STR={'Without','BF1','BF2','JBU','ADF','NAF','WMF','MR1','MR2','MR3','LBF','MRU','MRK','MRT','MMF','BOF','MF1','MF2','MF3','MS2','MS4','MS8','MDR','MDA','MDM','M1R','M1A','M1M','GHR','GHA','GHM'};

%  T=table(STR',result',time1');
%  writetable(T,strcat(outDir, 'outAllTest.xlsx'), "Sheet",1,"Range", "A1")

