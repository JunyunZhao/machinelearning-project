clear
clc
%%   
count = 1;
images_feature = [];
names  = {};
% for Cycle through all folders
for  cnt=1  :1000                                
      cnt
      pathname=['.\test1000\' num2str(cnt-1) '.jpg'];    % Fuse the path with the name
      image = imread(pathname);
      %%%%%         color            %% %%%%%%  1*225
      feature1=colorMom(image);
      %%%%%%%%%           Grayscale         %%%%%%%%%%
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
      %%%%%%%%%  Merge feature    %%%%%%%%%
      images_feature = [images_feature;feature1,feature2,feature3,feature4];
      names{count} = pathname;
      count = count +1;
end
 
save data.mat images_feature names