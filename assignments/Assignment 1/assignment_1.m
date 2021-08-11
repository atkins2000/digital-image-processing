set(groot,'defaultFigurePaperPositionMode','manual');
%the bitslice figure is too large for the page of pdf and gets cut off. The
%set function helps counter this and displays the image on one line. This
%function was included after searching on the matlab help

imdata = imread('photo.jpg');
%reads the photo of size and stores it in matrix of 719*719*3

figure(1);
imrgbout = imshow(imdata);
title('Original Image');
%displays the photo in matlab in rgb

saveas(imrgbout,'photo_rgb.pdf');
%saves the photo in rgb in pdf

imgray = rgb2gray(imdata);
%converts the photo into grayscale

figure(2);
imgrayout = imshow(imgray);
title('Grayscale Image');
%displays the photo in matlab in grayscale

saveas(imgrayout,'photo_gray.pdf');
%saves the photo in grayscale in pdf

bitplane = [];
%bit matrix initialised

for i=1:1:8
    bitplane = [bitplane double(bitget(imgray, i))];
    %bitget gets one bit from the pixel intensity value
end

figure(3);
imbitplane = imshow(bitplane);
title('Bitplane of the grayscale image');
%displays the bitplane 8 bit slice

saveas(imbitplane,'photo_bitslice.pdf');
%saves the photo in pdf