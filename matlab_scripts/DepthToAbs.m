function [depth1] = DepthToAbs(depth,name, outDir)
     [rows, cols, k] = size(depth);
   
     depth1 = zeros(240,320,k);
     depth1(1:cols,1:rows,:) = depth';
     depth = depth1';
     [rows, cols, ~] = size(depth);

    % abs format
    % [rows] rows
    % [cols] columns
    % pixels (flag X Y Z):
    % [flags] - if nan 0, if value 1
    % [X] - if nan X = -999999.000000  
    % [Y] - if nan Y = -999999.000000  
    % [Z] - if nan Z = -999999.000000  

    linealDepth = reshape(depth',1, cols*rows);
    flags = isnan(linealDepth) == 0;
    linealDepth(isnan(linealDepth)) = double(-999999);
    [y, x] = meshgrid(1:cols, 1:rows); 
    linealX = reshape(x,1, cols*rows) .* flags;
    linealY = reshape(y,1, cols*rows) .* flags;

    linealX(linealX == 0) = double(-999999);
    linealY(linealY == 0) = double(-999999);

    outfilename = fullfile(outDir,strcat(name,'.abs'));
    fileID = fopen(outfilename,'w');
    fprintf(fileID, '%d rows\n', rows);
    fprintf(fileID, '%d columns\n', cols);
    fprintf(fileID, 'pixels (flag X Y Z):\n');
    writeArray(fileID, flags);
    fprintf(fileID, '\n');
    writeArray(fileID, linealX);
    fprintf(fileID, '\n');
    writeArray(fileID, linealY);
    fprintf(fileID, '\n');
    writeArray(fileID,linealDepth);
    fclose(fileID);

    function writeArray(fileID, arr)
        str = join(num2str(arr));
        fprintf(fileID, str);
    end
end

