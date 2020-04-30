clear
clc
%% 
load data.mat
% color weight
w1 =  0.6;
% lbp weight
w2 =  0.3;
% gabor weight
w3 =  0.3;
% hu weight
w4 =  0.1;


% return image number
number = 20;
% determine the threshold of the returned image 
T = 0.9995;

lables = ones(50,1);
lables(1:5) = lables(1:5)*100;
lables(6:10) = lables(6:10)*200;
lables(11:15)= lables(11:15)*300;
lables(16:20) = lables(16:20)*400;
lables(21:25) = lables(21:25)*500;
lables(26:30) = lables(26:30)*600;
lables(31:35) = lables(31:35)*700;
lables(36:40) = lables(36:40)*800;
lables(41:45) = lables(41:45)*900;
lables(46:50) = lables(46:50)*1000;


cnt = 1;
for j = 1:20:1000
  cnt
% Calculate all
for count= 1:size(images_feature,1)
      dist1(count) =distance_func(images_feature(j,1:225),images_feature(count,1:225)); 
      dist2(count) =distance_func(images_feature(j,226:284),images_feature(count,226:284)); 
      dist3(count) =distance_func(images_feature(j,285:444),images_feature(count,285:444)); 
      dist4(count) =distance_func(images_feature(j,445:end),images_feature(count,445:end)); 
end
% Normalized distance
dist1 = dist1/sum(dist1);
dist2 = dist2/sum(dist2);
dist3 = dist3/sum(dist3);
dist4 = dist4/sum(dist4);
new_dist = w1*dist1 +w2*dist2+w3*dist3 +w4*dist4;
new_dist = new_dist/sum(new_dist);
[A1,B1]=sort(new_dist);
A1 = 1-A1;
[xx yy] =find(A1>T);
B = B1(yy);

B = B1(1:number);


chazhun(cnt) = length(find(B<=lables(cnt)))/length(B);
if cnt == 21
    aa = 12;
end
chaquan(cnt) = length(find(B<=lables(cnt)))/number;
cnt =cnt+1;
end

 meanchazhun = [];

for cnt = 1:10
    meanchazhun(cnt) = sum(chazhun( (cnt-1)*5+1:(cnt-1)*5+5    ))/5;

end
figure;bar(meanchazhun);title('Average accuracy')
set(gca,'XTickLabel',{'people','beach','building','bus','dinosaur','elephant','flower','horse','mountain','food'})


