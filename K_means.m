x = xlsread('C:\Users\admin\Desktop\homework\9.4\watermelon4.0.xlsx', 'Sheet1', 'A1:B30');
[m,n]=size(x);    %m=row ,n=col
k=4;%set the k
u=x(randperm(m,k),:);  %random the average
while 1
  c=zeros(k,30);    %delete the k
  nums=zeros(k,1);  
  %train all the samples
  for i=1:m
    mind=100000;   %put into the shortest distance
    minl=0;        %x's signal
    for j=1:k 
      d=norm(x(i,:)-u(j,:));   %caculate the distance
      if(d<mind)
      mind=d;
      minl=j;
      end
     end
     nums(minl)=nums(minl)+1;   %Clustering Number of Corresponding Families 
     c(minl,nums(minl))=i;      
   end
   %caculate the difference of the two average
   up=zeros(k,2);
   for i=1:k
     for j=1:nums(i)
       up(i,:)=up(i,:)+x(c(i,j),:);
      end
      up(i,:)=up(i,:)/nums(i);
   end
   %iteration's done
   delta_u=norm(up-u);
   if(delta_u<0.001)
      break;
    else
       u=up;
   end
end

%using different signals painting
ch='o*+.>';

for i=1:k
  %paint the point in class
  plot(x(c(i,1:nums(i)),1),x(c(i,1:nums(i)),2),ch(i));
  hold on;
  tc=x(c(i,1:nums(i)),:);       %Sample data of the same family
  %Computing convex hulls and drawing lines
  chl=convhull(tc(:,1),tc(:,2));   %Octave's convhull(x,y) must have two parameters

  %chl=convhull(tc);
  line(tc(chl,1),tc(chl,2))
  hold on;
end

xlabel('density');
ylabel('º¬ÌÇÂÊ');
title('K-means'); 
      
     