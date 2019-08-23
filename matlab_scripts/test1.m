function[IMG] = test1(img)
    img2 = img;
    img2(img < .005) = mean(img(:));
    H = fspecial('disk',10);
    img3 = imfilter(img2,H,'symmetric');
    img4 = img;
    img4(img < .3) = img3(img < .3);
    filterSize = 10;
    padopt = {'zeros','indexed','symmetric'};
    IMG = medfilt2(img4, [1 1]*filterSize, padopt{3});
end