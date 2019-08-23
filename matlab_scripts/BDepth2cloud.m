function [ ptCloud] = BDepth2cloud( depth_image, rgb_image )
    [nrows, ncols]= size(depth_image);
    % use a meshgrid for easy element-wise operations
    [X, Y] = meshgrid(1:ncols, 1:nrows); 
    Z = double(depth_image);

    invalidIndex = find(depth_image(:)==0);
    X(invalidIndex) = NaN;
    Y(invalidIndex) = NaN;
    Z(invalidIndex) = NaN;
    crop = imresize(rgb_image,[nrows, ncols]);
    ptCloud=pointCloud(cat(3, X, Y, Z), 'Color', crop);
    %pcshow(ptCloud);
    
end


