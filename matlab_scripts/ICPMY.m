function [rmse]=ICPMY(rgbFileName1,depthFileName1,rgbFileName2,depthFileName2)
    useShowFigures = false;
    ImRgb1 = imread(rgbFileName1);
    ImDepth1 = imread(depthFileName1);
    pointCloud1 = depth2cloud( ImDepth1, ImRgb1 );
    Images1 = rgb2gray(ImRgb1);
    % second cloud
    ImRgb2 = imread(rgbFileName2);
    ImDepth2 = imread(depthFileName2);
    pointCloud2 = depth2cloud( ImDepth2, ImRgb2 );
    Images2 = rgb2gray(ImRgb2);

    sizeImages = [480, 640];
    rng(2);
    border = 10;
    thr = 200; 
    if useShowFigures
        figure,pcshow(pointCloud1), title('First cloud');
        figure,pcshow(pointCloud2), title('Second cloud');
    end
    ROI  = [border, border, sizeImages(2)-border sizeImages(1)-border ];
    %ROI  = [border, border, 630, 470 ];
        points_1 = detectSURFFeatures(Images1,'MetricThreshold', thr, 'ROI', ROI);
        [features1, validPoints1] = extractFeatures(Images1, points_1, 'Upright',true);
        points_2 = detectSURFFeatures(Images2,'MetricThreshold', thr, 'ROI', ROI);
        [features2, validPoints2] = extractFeatures(Images2, points_2, 'Upright',true);
        % Match features across images
        indexPairs = matchFeatures(features1, features2, 'MaxRatio', 0.8, 'Unique', true);
        % Retrieve the locations of the corresponding points for each image.
        matchedPoints1 = validPoints1(indexPairs(:, 1));
        matchedPoints2 = validPoints2(indexPairs(:, 2));
        % Clean the matches with RANSAC algorithm
        [~,inlierPoints1,inlierPoints2] = estimateGeometricTransform(matchedPoints1,matchedPoints2,'affine','MaxDistance',7);
        % Extract point coordinates how much?
        loc_1 = round(inlierPoints1.Location);
        ind_1 = sub2ind(sizeImages, round(loc_1(:,2)), round(loc_1(:,1)));
        Global_Indexes1 = ind_1;
        loc_2 = round(inlierPoints2.Location);
        ind_2 = sub2ind(sizeImages, round(loc_2(:,2)), round(loc_2(:,1))); 
        Global_Indexes2 = ind_2;
    %figure, showMatchedFeatures(ImRgb1,ImRgb2,inlierPoints1,inlierPoints2, 'montage');
    %title(['Inlier point matches : ',num2str(inlierPoints1.Count)]);
    % SimpleICP with 2 frames
    ptRef = select(pointCloud1, Global_Indexes1);
    ptCur = select(pointCloud2, Global_Indexes2);
    [Tform, ~, rmse] = pcregrigid(ptCur, ptRef, 'Metric', 'pointToPoint', ...
            'Extrapolate', true, 'Verbose', false, 'MaxIterations', 1000, ...
            'Tolerance', [0.000001, 0.0000009], 'InlierRatio', 1);
    pointCloudAligned = pctransform(pointCloud1, Tform);
end