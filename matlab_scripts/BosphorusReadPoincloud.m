function ptCloud = BosphorusReadPoincloud(fileName)

    if endsWith(fileName,'.bnt') == 0
        disp(['File name has to have "btn"-extension: ' fileName]);
        return
    end

    [data, zmin, nrows, ncols, imfile] = read_bntfile(fileName);
    
    cloudCoordinates = data(:,[1:3]);
    cloudCoordinates(cloudCoordinates == zmin) = NaN;
    pngFileName=replace(fileName, 'bnt','png');
    
    image = imread(pngFileName);
    [col row, k] = size(image);
    coords =    data(:,[4,5]);
    coords(:,1)=round(coords(:,1)*row);
    coords(:,2)=round(coords(:,2)*col);
    [coordSize x] = size(coords);

    for i = 1:coordSize
        colors(i,:)= image(coords(i,2), coords(i,1),:);%[0;0;0];%
    end
  
    ptCloud=pointCloud(cloudCoordinates, 'Color', colors);
   %  figure; pcshow(ptCloud);

end