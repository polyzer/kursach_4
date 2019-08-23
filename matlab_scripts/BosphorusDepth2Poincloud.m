function ptCloud = BosphorusDepth2Poincloud(depth_image)

    [nrows, ncols]= size(depth_image);
    % use a meshgrid for easy element-wise operations
    
    Z = double(depth_image);
    [u, v] = meshgrid(1:ncols, 1:nrows);
    X = u; 
    Y = v; 
    Z(Z==0) = NaN;
    
    ptCloud=pointCloud(cat(3, X, Y, Z));
end