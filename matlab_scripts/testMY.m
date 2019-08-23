clear all;
close all;
clc;
ImDepth = imread('Data2\depth\d(1).png');
ImRgb = imread('Data2\rgb\r(1).png');
ma=bwmorph(GH_channel(ImDepth),'erode',3);
%sum(ma(:))
OutDepth1 = newSMF(ImDepth,ma);
ma1=edge(rgb2gray(ImRgb),'sobel');
%sum(ma1(:))
ma2=bwmorph(ma1,'dilate',3);
%sum(ma2(:))
ma3=ma|ma2;
%sum(ma3(:))
%imshow(uint8(255*ma3))
OutDepth2 = newSMF(OutDepth1,ma2);
bil_val = double(max(OutDepth2(:)));
%OutDepth3 = newSBF(double(OutDepth2)/bil_val,ma3)*bil_val;
OutDepth4 = bfilter2(double(OutDepth2)/bil_val)*bil_val;

%{
figure
subplot(2,1,1)
imshow(uint8(ImDepth/15))
subplot(2,1,2)
imshow(uint8(OutDepth/15))
%}

pointCloud = depth2cloud(OutDepth4,ImRgb);
pcshow(pointCloud);