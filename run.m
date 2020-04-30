clear
clc
close all
%%
[filename,pathname]=...
    uigetfile({'*.jpg';'*.bmp';'*.gif'},'choose image');
str=[pathname filename];
image=imread(str);
figure
imshow(image);
 
%%%%%         1  color             %% %%%%%%  1*225
feature1=colorMom(image);
%%%%%%%%%           gray         %%%%%%%%%%
if size(image,3) == 3
    gray_image = rgb2gray(image);
    else
    gray_image =  image;
end
%%%%%         2   lBP    %%%%%%  1*59
%LBP histogram in (8,1) neighborhood
%using uniform patterns      
mapping=getmapping(8,'u2');                           
feature2=lbp(gray_image,1,8,mapping,'h'); 
%%%%%         3   gabor    %%%%%%    1*160
image0 = imresize(gray_image,[64 64]);
feature3  = Gabor_palm(image0);
%%%%%        4   HU    %%%%%%   1*8
feature4 = getfeature4(gray_image);


%%%%%%%%%%%%weight%%%%%%%%%%%%%%%%%%%%%
% color weight
w1 =  0.6;
% lbp weight
w2 =  0.3;
% gabor weight
w3 =  0.3;
% hu weight
w4 =  0.1;
% 
load data.mat
for count= 1:size(images_feature,1)
      dist1(count) =distance_func(feature1,images_feature(count,1:225)); 
      dist2(count) =distance_func(feature2,images_feature(count,226:284)); 
      dist3(count) =distance_func(feature3,images_feature(count,285:444)); 
      dist4(count) =distance_func(feature4,images_feature(count,445:end)); 
end
% Normalized distance
dist1 = dist1/sum(dist1);
dist2 = dist2/sum(dist2);
dist3 = dist3/sum(dist3);
dist4 = dist4/sum(dist4);

 
new_dist = w1*dist1 +w2*dist2+w3*dist3 +w4*dist4;

new_dist = new_dist/sum(new_dist);
[A1,B1]=sort(new_dist);

figure;
nnn = 1;
for i=1:20
    imid = B1(i);
    AA=imread(names{imid}); 
    subplot(4,5,i)
    imshow(AA);
 
    title(num2str(1-A1(i)));
end