img = imread('triangle.jpg');
%the image of the corresponding figure drawn in paint

img = rgb2gray(img);
%converts image to rgb
col = length(img(1,:));
%size dimension 1
rows = length(img(:,1));
%size dimension 2

count =0;
ii=0;
jj=0;
for i =1:rows 
for j=1:col
if img(i,j) == 255
count = count+1;
ii = ii + i;
jj = jj + j;
end
end
end
%this section finds the centroid of the white section in the image

ii = ceil(ii/count);%x-coordinate of centroid
jj = ceil(jj/count);%y-coordinate of centroid
dist=[];

for k = 0:0.1:85-.1%0 to 85
x=0;
ix = ii + x;
jx = ceil(jj + x*tan(k*pi/180));
while img(ix,jx) == 255
ix = ii + x;
jx = ceil(jj + x*tan(k*pi/180));
x = x+1;
end
dd = sqrt((jx-jj)^2+(ix-ii)^2);
dist = [dist dd];
end

for k = 85:0.1:95-.1%85 to 95
x=0;
ix = ii;
jx = jj + x;
while img(ix,jx) == 255
jx = jj + x;
x = x+1;
end
dd = sqrt((jx-jj)^2+(ix-ii)^2);
dist = [dist dd];
end

for k = 95:0.1:180-0.1%95 to 180
x=0;
ix = ii - x;
jx = ceil(jj + x*tan(k*pi/180));
while img(ix,jx) == 255
ix = ii - x;
jx = ceil(jj + x*tan(k*pi/180));
x = x+1;
end
dd = sqrt((jx-jj)^2+(ix-ii)^2);
dist = [dist dd];
end

for k = 180:0.1:265-0.1%180 to 264
x=0;
ix = ii - x;
jx = ceil(jj - x*tan(k*pi/180));
while img(ix,jx) == 255
ix = ii - x;
jx = ceil(jj - x*tan(k*pi/180));
x = x+1;
end
dd = sqrt((jx-jj)^2+(ix-ii)^2);
dist = [dist dd];
end

for k = 265:0.1:275-.1%265 to 275
x=0;
ix = ii;
jx = jj - x;
while img(ix,jx) == 255
jx = jj - x;
x = x+1;
end
dd = sqrt((jx-jj)^2+(ix-ii)^2);
dist = [dist dd];
end

for k = 275:0.1:360%275 to 360
x=0;
ix = ii + x;
jx = ceil(jj - x*tan(k*pi/180));
while img(ix,jx) == 255
ix = ii + x;
jx = ceil(jj - x*tan(k*pi/180));
x = x+1;
end
dd = sqrt((jx-jj)^2+(ix-ii)^2);
dist = [dist dd];
end
%The corresponding parts calculate the distance from centroid vs the angle
%they hold

k=0:0.1:360;
plot(k,dist)
ylim([0 250])
xlim([0 360])
grid on
ylabel('Distance from Centroid')
xlabel('Angle in degrees')
%plots the final vector