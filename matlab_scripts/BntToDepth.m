function depth = BntToDepth(fileName)
    small = 1;
    if endsWith(fileName,'.bnt') == 0
        disp(['File name has to have "btn"-extension: ' fileName]);
        return
    end

    [data, zmin, nrows, ncols, ~] = read_bntfile(fileName);
    
    Z = data(:,3);
    Z(Z == zmin) = NaN;
    minZ = min(Z);
    if minZ < 0
        Z = Z - minZ;
    end

    pngFileName=replace(fileName, 'bnt','png'); 
    image = imread(pngFileName);
    [row, col, ~] = size(image);
    
    coords =    data(:,[4,5]);
    factor = col/ncols;
    if small == 1
        coords(:,1)=round(coords(:,1)*col/factor);
         if min(coords(:,1)) == 0
             coords(:,1)=coords(:,1)+1;
         end
        coords(:,2)=round(coords(:,2)*row/factor);
    else
        coords(:,1)=round(coords(:,1)*col);
        coords(:,2)=round(coords(:,2)*row);
    end
    coordSize = length(coords);

    depth = zeros(nrows, ncols);
    depth(depth==0)=nan;
    for i = 1:coordSize
        if small == 1
        	depth(coords(i,2),coords(i,1)) = Z(i);
        else
            depth(coords(i,2),coords(i,1)) = Z(i)*factor;
        end
    end
    
    depth(depth==0)=nan;
    %imshow(uint8(depth));
    
end