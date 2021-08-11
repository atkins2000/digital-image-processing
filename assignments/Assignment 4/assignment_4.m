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

prob_entropy = prob; % making another array so that original values not lost

for i = 1:1:256
    if prob_entropy(i) == 0
        prob_entropy(i) = 1;
    end
end
%This loop changes all the intensities with no count into 1 so that they
%don't have a probability of 0 and thus make the entropy infinity. They
%are made 1 here to limit their impact on the entropy

entropycalc = -sum(prob_entropy .* log2(prob_entropy));

probability = prob; % for preserving original values
graylvl = [0:255];

for i = 1:1:256
    for j = 1:1:256-i
        if prob(j) < prob(j+1)
            temp_a = prob(j);
            temp_b = graylvl(j);
            prob(j) = prob(j+1);
            graylvl(j) = graylvl(j+1);
            prob(j+1) = temp_a;
            graylvl(j+1) = temp_b;
        end
    end
end
%Sorts in descending order

sumprevtwo = 0;
%Finds the sum of last two elements  

tempmain=[0];
sumarr=[];
a=length(prob);
lengthprob=[a]; 
%Stores length of each level from initial to 2
i = 1;
%Traverses the probability columns
map(:,i)=prob;
%Stores the probability values at each level

while(length(prob)>2) 
 sumprevtwo=prob(length(prob))+prob(length(prob)-1);
 sumarr=[sumarr ; sumprevtwo];
 prob=[prob(1:length(prob)-2),sumprevtwo]; 
 %Generates a new probability column every run through the loop
 
 prob=sort(prob,'descend'); 
 %Sorts in descending order
 i=i+1;
 map(:,i)=[prob,zeros(1,a-length(prob))];
 a1=0;
 lengthprob=[lengthprob;length(prob)]; 
 
 for j=1:length(prob) 
     if prob(j)==sumprevtwo
       a1=j;
     end
 end
 tempmain=[a1,tempmain];  
 %Finds the place where sumprevtwo has been inserted for each
 %probability column.
end


size_map(1:2)=size(map);
%Shows number of probability columns (256-1) and gray levels 256
assign=0;
initial=[];  
%Checks the exact matches of initial and a probability at any stage
length_code = []; 
%Stores length of code of each  intensity level
all_codes = {};  
%Displays the final complete array containing all codes
 
 for i= 1:size_map(1)   
  initial=[initial; map(i,1)];
 end 
 sumarr=[0 ; sumarr]; 
 %Makes comparison in same probability column
 e=1;
 
for i= 1:size_map(1)
  code=[]; 
  for k= 1:size_map(2) 
     assign=0;      
     for j=1:size_map(1) 
         if( map(j,k)==initial(e))  
             %Checks if a initial probability corresponds to any value in
             %the probability distribution at any stage
             assign=map(j,k);     
         end
         if(assign==0 && map(j,k)==sumarr(k)) 
             assign=map(j,k);
         end
     end
     
     %Assigns probabilities starting from the end 
     if assign==map(lengthprob(k),k)       
         %Assigns the lower value 1 out of the two in sum
         code=[code,'1']; 
     elseif assign==map(lengthprob(k)-1,k) 
         %Assigns the higher value 1
         code=[code,'0'];
     else
         code=[code,''];  %If no match then no need to assign further
     end
     
     initial(e)=assign;
  end
  
  e=e+1;
  length_code = [length_code ; length(code)];
  display_code = [int2str(graylvl(i)),' is assigned ',code];
  all_codes = cat(1, all_codes, display_code);
end

for i = 1:1:256
    for j = 1:1:256-i
        if graylvl(j) > graylvl(j+1)
            temp_a = graylvl(j);
            temp_b = length_code(j);
            temp_c = all_codes(j);
            graylvl(j) = graylvl(j+1);
            length_code(j) = length_code(j+1);
            all_codes(j) = all_codes(j+1);
            graylvl(j+1) = temp_a;
            length_code(j+1) = temp_b;
            all_codes(j+1) = temp_c;
        end
    end
end
display(all_codes);

average_length = 0; 
%Calculates average length and efficiency 
for i = 1:length(probability)
    average_length = average_length + probability(i) * length_code(i);
end
efficiency = entropycalc / average_length;

fprintf('Entropy is %f \n', entropycalc);
fprintf('Average length is %f \n', average_length);
fprintf('Efficiency is %f \n', efficiency);