BtnDir = 'E:\BosphorusDB\BosphorusDB\BosphorusDB\bs000\';
AbsDir = 'E:\BosphorusDB\abs';
PlyDir = 'E:\BosphorusDB\ply';
DepthDir = 'E:\BosphorusDB\depth';

mask=strcat(BtnDir,'*.bnt');
files  = dir (mask);
[count, ~] = size(files);

fprintf(">>> Read  images <<<\n");
for i = 1:count
    file = files(i);
    fprintf(">>> %s (%d of %d):", file.name, i, count);
    filename = fullfile(file.folder, file.name);
    fprintf(" PLY");
    SavePly(filename, PlyDir);
    fprintf(" ABS");
    depth = BntToAbs(filename, AbsDir);
    fprintf(" Depth");
    SaveDepth(depth, filename, DepthDir);
    fprintf(" <<<\n");
end

fprintf(">>> Done <<<\n");

function SavePly(fileName, outDir)
    
    pc=BosphorusReadPoincloud(fileName);
    
    [~,name,~] = fileparts(fileName);
    outfilename = fullfile(outDir,strcat(name,'.ply'));
    pcwrite(pc, outfilename);
end

function SaveDepth(depth, fileName, outDir)
    [~,name,~] = fileparts(fileName);
    outfilename = fullfile(outDir,strcat(name,'.png'));
    imwrite(uint16(depth),outfilename);
end