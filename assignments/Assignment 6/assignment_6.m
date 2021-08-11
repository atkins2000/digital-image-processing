format long g;
format compact;
captionFontSize = 14;
Image=imread('Coin.jpg'); 
subplot(1,3,1);
imshow(Image);
title('Original Image', 'FontSize', captionFontSize);
hold on

I = rgb2gray(Image);
subplot(1,3,2);
n=imhist(I); %Compute the histogram
N=sum(n); 
max=0; 

for i=1:256
    P(i)=n(i)/N; %Computing the probability of each intensity level
end
for T=2:255      
    w0=sum(P(1:T)); %Probability of class 1
    w1=sum(P(T+1:256)); %probability of class2
    u0=dot(0:T-1,P(1:T))/w0; %class mean u0
    u1=dot(T:255,P(T+1:256))/w1; %class mean u1
    sigma=w0*w1*((u1-u0)^2); 
    if sigma>max 
        max=sigma; 
        threshold=T-1; 
    end
end


bw=imbinarize(I,threshold/255); %Convert to Binary Image
display(threshold)
originalImage = I;
imshow(originalImage);
title('Original GrayScale Image', 'FontSize', captionFontSize);
set(gcf, 'units','normalized','outerposition',[0 0 1 1]);
hold on
binaryImage=bw;
thresholdValue=threshold;
labeledImage = bwlabel(binaryImage, 8);    
blobMeasurements = regionprops(labeledImage, originalImage, 'all');
numberOfBlobs = size(blobMeasurements, 1);

textFontSize = 14;	
labelShiftX = -7;
blobECD = zeros(1, numberOfBlobs);
X = zeros(length(numberOfBlobs),4);

for k = 1 : numberOfBlobs           % Loop through all blobs.
	% Find the mean of each blob
	thisBlobsPixels = blobMeasurements(k).PixelIdxList; 
	meanGL = mean(originalImage(thisBlobsPixels));
	meanGL2008a = blobMeasurements(k).MeanIntensity;
	
	blobArea = blobMeasurements(k).Area;		
	blobPerimeter = blobMeasurements(k).Perimeter;		
	blobCentroid = blobMeasurements(k).Centroid;		
	blobECD(k) = sqrt(4 * blobArea / pi);					
    X(k,1)=k;
    X(k,2) = blobMeasurements(k).Area;
    X(k,3)=blobCentroid(1);
    X(k,4)=blobCentroid(2);
end
disp(X)
cent = sortrows(X,2);

allBlobCentroids = [blobMeasurements.Centroid];
centroidsX = cent(2:6,3);
centroidsY = cent(2:6,4);

subplot(1,3, 3);
imshow(bw); 
title('Numbered in ascending order.', 'FontSize', captionFontSize); 
subplot(1,3,3);
for k = 1 : numberOfBlobs-1           % Loop through all blobs.
	text(centroidsX(k) + labelShiftX, centroidsY(k), num2str(k), 'FontSize', textFontSize, 'FontWeight', 'Bold');
end
hold on