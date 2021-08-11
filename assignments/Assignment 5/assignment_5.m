imdata=imread('cameraman_photo.jpg'); 
%Reads the image into Matlab and stores it as a matrix

figure(1);
imshow(imdata); 
title('Original image');
%Shows the original camera man image

hist=imhist(imdata); 
%Stores the histogram of the original image

figure(2);
imhist(imdata);
title('Histogram of the original image')
%Shows the historgram of the original image_

sumall=sum(hist); %Stores the sum of all the histogram values
maxsig=0; %Stores maximum sigma for comparing in different iterations

P = zeros(256); %Stores probability of each intensity level

for i=1:256
    P(i)=hist(i)/sumall; 
end

for T=1:255
    P1_T = sum(P(1:T)); % probability of class 1 (till T)
    P2_T = sum(P(T+1:256)); % probability of class2 (after T+1)
    m1 = dot([0:T-1],P(1:T))/P1_T; % class 1 mean using dot product with corresponding probabilties
    m2 = dot([T:255],P(T+1:256))/P2_T; % class 2 mean using dot product with corresponding probabilties
    mg = dot([0:255],P(1:256)); % global mean using dot product with corresponding probabilties
    
    sig = P1_T*(m1-mg)^2 + P2_T*(m2-mg)^2; %Stores the variance 
    
    if sig > maxsig 
        maxsig = sig; 
        threshold = T-1; 
    end
end

display(threshold);
otsu = zeros(512,512);
%Makes a zero array for the final image after otsu thresholding

%Converts to binary image 
for i = 1:1:512
    for j = 1:1:512
        if imdata(i,j) <= threshold
            otsu(i,j)  = 0;
        else
            otsu(i,j) = 1;
        end
    end
end

figure(3);
imshow(otsu); %Displays the Binary Image
title('Segmented image');

graythresh(imdata);
%Verifies the threshold obtained