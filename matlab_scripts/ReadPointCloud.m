function [ImRgb, ptCloudOut] = ReadPointCloud(imgname,name, meth)
   
    ImRgb = imread(strcat('c:\Users\SW\Music\CSU\Diploma\newTest\',name,'\rgb\image',imgname,'.png'));
    if  strcmp(meth, 'origin') == 1
        ImDepth = imread(strcat('c:\Users\SW\Music\CSU\Diploma\newTest\',name,'\depth\depth',imgname,'.png'));
    else
        ImDepth = imread(strcat('c:\Users\SW\Music\CSU\Diploma\newTest\out',name,'_\',meth,'\',imgname,'.png'));
    end

    pointCloud = depth2cloud(ImDepth,ImRgb);
   % tform = affine3d(Rotation(pi/2,0,pi/4));
    ptCloudOut = pointCloud;%pctransform(pointCloud,tform);
    
end