set(groot,'defaultFigurePaperPositionMode','manual');
%the bitslice figure is too large for the page of pdf and gets cut off. The
%set function helps counter this and displays the image on one line. This
%function was included after searching on the matlab help

imdata = imread('photo.jpg');
%reads the photo of size and stores it in matrix of 719*719*3

imgray = rgb2gray(imdata);
%converts the photo into grayscale

bitplane = [];
%bit matrix initialised

for i=1:1:8
    bitplane = [bitplane double(bitget(imgray, i))];
    %bitget gets one bit from the pixel intensity value
end

figure(1);
subplot(2,1,1);
gray_og = imshow(imgray);
title('Original photo in grayscale');
%displays the original image in grayscale

subplot(2,1,2);
bitplane_og = imshow(bitplane);
title('Bitplane of the 8 bit slices');
%displays the bitplane 8 bit slice

incbright = imgray + 60;
%increases the intensity of every pixel by 50

decbright = imgray - 60;
%decreases the intensity of every pixel by 50

M = mean(mean(imgray));
%mean of all pixel intensities

imgcont = cast(imgray,'int16');
%this casting is done to prevent losses due to values that become less than
%0

inccont = (imgray - M)*2 + M;
%image with increased contrast

inccontrast = cast(inccont, 'uint8');
%obtaining 8bit unsigned again

deccont = (imgray - M)/2 + M;
%image with decreased contrast

deccontrast = cast(deccont, 'uint8');

figure(2);
subplot(2,2,1);
incbright_og = imshow(incbright);
title('Image with Increased Brightness');
%displays the more bright version of the original image

subplot(2,2,2);
decbright_og = imshow(decbright);
title('Image with Decreased Brightness');
%displays the less bright version of the original image

subplot(2,2,3);
inccontrast_og = imshow(inccontrast);
title('Image with Increased Contrast');
%displays the more contrasted version of the original image

subplot(2,2,4);
deccontrast_og = imshow(deccontrast);
title('Image with Decreased Contrast');
%displays the less contrasted version of the original image

figure(3);
imhist(imgray);
title('Histogram of the original Image');
%displays the histogram of the original grayscale image

figure(4);
subplot(2,2,1);
imhist(incbright,64);
title('Histogram of the Increased Brightness Image');
%displays the histogram of the increased brightness grayscale image

subplot(2,2,2);
imhist(decbright,64);
title('Histogram of the Decreased Brightness Image');
%displays the histogram of the decreased brightness grayscale image

subplot(2,2,3);
imhist(inccontrast,64);
title('Histogram of the Increased Contrast Image');
%displays the histogram of the increased contrast grayscale image

subplot(2,2,4);
imhist(deccontrast,64);
title('Histogram of the Decreased Contrast Image');
%displays the histogram of the decreased contrast grayscale image

figure(5);
subplot(2,2,1);
incbright_eq = histeq(incbright);
incbright_eqog = imshow(incbright_eq);
title('Image with increased brightness after Histrogram Eqaulisation');
%displays the images formed after histogram equalisations of inc brightness
%images

subplot(2,2,2);
decbright_eq = histeq(decbright);
decbright_eqog = imshow(decbright_eq);
title('Image with decreased brightness after Histrogram Eqaulisation');
%displays the images formed after histogram equalisations of dec brightness
%images

subplot(2,2,3);
inccontrast_eq = histeq(inccontrast);
inccontrast_eqog = imshow(inccontrast_eq);
title('Image with increased contrast after Histrogram Eqaulisation');
%displays the images formed after histogram equalisations of inc contrast
%images

subplot(2,2,4);
deccontrast_eq = histeq(deccontrast);
deccontrast_eqog = imshow(deccontrast_eq);
title('Image with decreased contrast after Histrogram Eqaulisation');
%displays the images formed after histogram equalisations of dec contrast
%images

figure(6);
subplot(2,2,1);
imhist(incbright_eq,64);
title('Histogram after equalisation of Increased Brightness');
%histogram of equalised increased brightness image

subplot(2,2,2);
imhist(decbright_eq,64);
title('Histogram after equalisation of Decreased Brightness');
%histogram of equalised decreased brightness image

subplot(2,2,3);
imhist(inccontrast_eq,64);
title('Histogram after equalisation of Increased Contrast');
%histogram of equalised increased contrast image

subplot(2,2,4);
imhist(deccontrast_eq,64);
title('Histogram after equalisation of Decreased Contrast');
%histogram of equalised decreased contrast image