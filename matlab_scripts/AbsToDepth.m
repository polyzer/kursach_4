fileName = 'C:\Users\SW\Music\CSU\Diploma\course-face3d\abs\ex.abs';
fid=fopen(fileName);
fgetl(fid);
fgetl(fid);
fgetl(fid);
fgetl(fid);
X = str2num(fgetl(fid));
Y = str2num(fgetl(fid));
Z = str2num(fgetl(fid));
cols = 240;
rows = 320;

dp = reshape(Z,rows, cols);
dp(dp == -999999) = nan;
dp = dp - min(min(dp));
imshow(uint8(dp));
fclose(fid);

