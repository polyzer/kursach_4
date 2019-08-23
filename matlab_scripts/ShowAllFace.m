% save origins
% files={'c:\Users\SW\Music\CSU\Diploma\newTest\outALL\BF1\2.png', ...
%     'c:\Users\SW\Music\CSU\Diploma\newTest\outALL\BOF\2.png', ...
%     'c:\Users\SW\Music\CSU\Diploma\newTest\outALL\JBU\2.png', ...
%     'c:\Users\SW\Music\CSU\Diploma\newTest\outALL\MF1\2.png', ...
%     'c:\Users\SW\Music\CSU\Diploma\newTest\outALL\MF2\2.png', ...
%     'c:\Users\SW\Music\CSU\Diploma\newTest\outALL\MF3\2.png', ...
%     'c:\Users\SW\Music\CSU\Diploma\newTest\outALL\MMF\2.png', ...
%     'c:\Users\SW\Music\CSU\Diploma\newTest\outALL\MRK\2.png', ...
%     'c:\Users\SW\Music\CSU\Diploma\newTest\outALL\MRU\2.png', ...
%     'c:\Users\SW\Music\CSU\Diploma\newTest\outALL\NAF\2.png', ...
%     };
% r = imread('c:\Users\SW\Music\CSU\Diploma\newTest\anatomy\rgb\image000002.png');
% fc = length (files);
% for i = 1:fc
% 
%     d = imread(files{i});
%     %r = imread(strcat(rgb_path, strrep(files(i).name,'_MF3','')));
% %     pc=BDepth2cloud(d,r);
%     tform = affine3d(Rotation(pi/2,0,pi/4));
%     pct = pctransform(pc,tform);
%     pc = depth2cloud(d, r);
%     tit = extractAfter(files{i}, 'outALL\');
%     tit =strrep(tit, '_',' ');
%     tit =strrep(tit, '\2.png','');
%   	imshow(uint8(d-650));title(tit);
%     saveas(gcf,strcat('.\EPS\DP_anatomy_',strrep(tit,' ','_')),'jpg');
%     saveas(gcf,strcat('.\EPS\DP_anatomy_',strrep(tit,' ','_')),'epsc');
%     pcshow(pct);title(tit);
%      saveas(gcf,strcat('.\EPS\PC_anatomy_',strrep(tit,' ','_')),'jpg');
%     saveas(gcf,strcat('.\EPS\PC_anatomy_',strrep(tit,' ','_')),'epsc');
% end

%% save origins
rgb_path = 'E:\BosphorusDB\BosphorusDB\BosphorusDB\bs002\';
files = dir('e:\BosphorusDB\depth\bs002\*.png');
fc = length (files);
for i = 1:fc

    d = imread(strcat(files(i).folder, '\', files(i).name));
    r = imread(strcat(rgb_path, files(i).name));
    pc=BDepth2cloud(d,r);
    tform = affine3d(Rotation(pi/2,0,pi/4));
    pct = pctransform(pc,tform);
    tit = extractAfter(files(i).name, 'bs002_');
    tit =strrep(tit, '_',' ');
    tit =strrep(tit, '.png','');
    pcshow(pct, 'MarkerSize', 12);%title(tit);
    saveas(gcf,strcat('.\EPS\origin_untitle',strrep(tit,' ','_')),'jpg');
    saveas(gcf,strcat('.\EPS\origin_untitle',strrep(tit,' ','_')),'epsc');
end


% 
% rgb_path = 'E:\BosphorusDB\BosphorusDB\BosphorusDB\bs002\bs002_N_N_0.png';
% r = imread(rgb_path);
% files = dir('e:\BosphorusDB\depth\bs002_filtered\bs002_N_N_0_*');
% fc = length (files);
% for i = 1:fc
% 
%     d = imread(strcat(files(i).folder, '\', files(i).name));
%     pc=BDepth2cloud(d,r);
%     tform = affine3d(Rotation(pi/2,0,pi/4));
%     pct = pctransform(pc,tform);
%     tit = extractAfter(files(i).name, '_N_N_0_');
%     tit =strrep(tit, '_','');
%     tit =strrep(tit, '.png','');
%     figure;pcshow(pct, 'MarkerSize', 12);title(tit);
%     saveas(gcf,strcat('.\EPS\filtered_',tit),'jpg');
%     saveas(gcf,strcat('.\EPS\filtered_',tit),'epsc');
% end