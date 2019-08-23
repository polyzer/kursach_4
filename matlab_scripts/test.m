addpath('DE');
rgb=imread('Data/rgb/r (1).png');
depth_o=imread('Data/depth/d (1).png');
for i=1:9
   s=false(1,9);
   for j=1:9
      if i~=j
        s(j)=false;
      else
        s(j)=true;
      end
   end
   temp = DE(rgb, depth_o, s);
   imwrite(temp, strcat(strcat('file',int2str(i)),'.png'));
end
rmpath('DE');