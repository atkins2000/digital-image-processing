clc; close all; clear all;
img = imread('triangle.jpg');%the 'circle' image
img = rgb2gray(img);
img= img(1:640,1:1150);
col = length(img(1,:));
rows = length(img(:,1));

%imshow(img)
ih = rows/10;
jh = col/10;

for i = 1:ih-1
    for j = 1:jh-1
        ii = (i-1)*10+1;
        jj = (j-1)*10+1;
        count=0;
        for iii = ii:ii+10
            for jjj = jj:jj+10
                if img(iii,jjj) == 255
                    count = count+1;
                end
            end
        end
        if count >=50
            for iii = ii:ii+10
                for jjj = jj:jj+10
                    img(iii,jjj) = 255;
                end
            end
        else
            for iii = ii:ii+10
                for jjj = jj:jj+10
                    img(iii,jjj) = 0;
                end
            end
        end
    end
end
%imshow(img)

ic=0;
jc=0;
for i =1:rows %finding the centroid
    for j=1:col
        if img(i,j) == 255
            count = count+1;
            ic = ic + i;
            jc = jc + j;
        end
    end
end
ic = ceil(ic/count);%x-coordinate of centroid
jc = ceil(jc/count);%y-coordinate of centroid

bw = edge(img,'Roberts');
perimeter=0;
for i=1:640
    for j =1:1150
        if bw(i,j) == 1
            perimeter = perimeter +1;
        end
    end
end
area =0;
for i=1:64
    for j=1:115
        ix = (i-1)*10+1;
        jx = (j-1)*10+1;
        if img(ix,jx) == 255
            area = area + 100;
        end
    end
end
compactness = (perimeter^2)/area;
