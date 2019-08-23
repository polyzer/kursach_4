BosphorusDB = 'E:\BosphorusDB\BosphorusDB\BosphorusDB\';
faceDirs  = dir(BosphorusDB);
faceCount = length(faceDirs);

for face = 105: faceCount
    faceDir = faceDirs(face);
    faceName = faceDir.name;
    if (faceDir.isdir == 0) || strcmp(faceName, '.') || strcmp(faceName,'..' )
        continue
    end
    fprintf(">>> %s (%d of %d):\n", faceName, face, faceCount);
    
    outPlyDir = strcat('E:\BosphorusDB\ply\',faceName,'_filtered\');
    outDepthDir = strcat('E:\BosphorusDB\depth\',faceName,'_filtered\');
    outAbsDir = strcat('E:\BosphorusDB\abs\',faceName,'_filtered\');
    depthPath = strcat('E:\BosphorusDB\depth\',faceName,'\');

    mkdir(outPlyDir);
    mkdir(outDepthDir);
    mkdir(outAbsDir);
    mkdir(depthPath);

    bntDir = strcat(BosphorusDB,faceName,'\');
    rgbPath = strcat(BosphorusDB,faceName,'\');

    STR={'CLE', 'MDM','MMF','MDR','M1R','M1M','GHA','GHM','GHR','BOF','M1A','BF1','MDA','MR1','MRK'};

    mask=strcat(bntDir,'*.bnt');
    files  = dir (mask);
    [fileCount, ~] = size(files);

    for f = 1:fileCount
        file = files(f);
        [~,name,~] = fileparts(file.name);
        if(contains(name, '_N_N_'))
            continue;
        end
        
        fprintf("||| %s (%d of %d):\n", name, f, fileCount);
        count = length(STR);
        fprintf("    Read  images\n");
        try
            ImDepth = BntToDepth(strcat(bntDir, name, '.bnt'));
            ImRgb = imread(strcat(rgbPath, name, '.png'));
        catch
            fprintf("    Read  failed\n");
            continue
        end
        [x,y,k] = size(ImDepth);
        ImRgb = imresize(ImRgb,[x y]);
        % ToDo  Filter here %
        for i = 1:(count)
            alg = STR{i};
            fprintf(strcat("    alg = ",alg, " (",int2str(i)," of ", int2str(count), ")\n"));

            try
                filteredDepth = DE(ImRgb, ImDepth, alg);
                filteredDepth = double(filteredDepth);
                filteredDepth(filteredDepth == 0) = nan;
                filteredPc = BosphorusDepth2Poincloud(filteredDepth);
                pcwrite(filteredPc, strcat(outPlyDir, name, '_', alg, '.ply'));
                imwrite(uint16(filteredDepth),strcat(outDepthDir, name, '_', alg, '.png'));

                imwrite(uint16(ImDepth),strcat(depthPath, name, '.png'));

                DepthToAbs(filteredDepth, strcat(name, '_', alg), outAbsDir);
            catch e
                fprintf(strcat("    ATENSION alg = ",alg, " <<<\n"));
            end
        end
    end
end

fprintf(">>> Filtering done <<<\n");

