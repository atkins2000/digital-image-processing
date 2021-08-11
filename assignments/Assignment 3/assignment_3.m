imdata = imread('photo.jpeg');
%Read the image into Matlab and stores it as a matrix 

imgray = rgb2gray(imdata);
%Converts the Image into grayscale

count = zeros(1,256);
%Keeps a count of all the intensities in the matrix

for i = 1:1:size(imgray,1)
    for j = 1:1:size(imgray,2)
        count(1,imgray(i,j)+1) = count(1,imgray(i,j)+1) + 1;
    end
end
%A loop to count the intensities

totalcount = size(imgray,1) * size(imgray,2);
prob = count / totalcount;
%Prob stores the probabilities

prob_entropy = prob; 
%Makes another array so that original values not lost

for i = 1:1:256
    if prob_entropy(i) == 0
        prob_entropy(i) = 1;
    end
end
%This loop changes all the intensities with no count into 1 so that they
%don't have a probability of 0 and thus make the entropy infinity. They
%are made 1 here to limit their impact on the entropy

entropycalc = -sum(prob_entropy .* log2(prob_entropy));
fprintf('entropy is %f \n', entropycalc);
%Prints the entropy obtained

entropyfunc = entropy(imgray);
%Entropy is calculated using the inbuilt function to verify the calculated
%entropy

%IGS quantization
sumint = uint8([8,4,2,1]);
imgigs = imgray;
%Makes a copy for use

igs = uint8(zeros(size(imgray,1),size(imgray,2)));
for i = 1:1:size(imgray,1)
    for j = 1:1:size(imgray,2)
        if j==1 
            add = uint8(0);
            igs(i,j) = sum(((bitget(imgigs(i,j), 8:-1:5))+add).*sumint);
        elseif bitget(imgigs(i,j),8)==1 && bitget(imgigs(i,j),7)==1 && bitget(imgigs(i,j),6)==1 && bitget(imgigs(i,j),5)==1
            add = uint8(0);
            igs(i,j) = sum(((bitget(imgigs(i,j), 8:-1:5))+add).*sumint);
        else
            add = (bitget(imgigs(i,j-1),4:-1:1));
            imgigs(i,j) = imgigs(i,j) + sum(add.*sumint);
            igs(i,j) = sum((bitget(imgigs(i,j), 8:-1:5)).*sumint);
        end
    end
end

imgcomp = mat2gray(igs,[0 15]);

figure(1);
imshow(imdata);
title('The Original Image');

figure(2);
imshow(imgray);
title('The Original Image in grayscale');

figure(3);
imshow(imgcomp);
title('The image after IGSQ');