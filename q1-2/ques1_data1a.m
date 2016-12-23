clear;
fileID = fopen('data/lin_sep_1/class1_train.txt','r');
formatSpec = '%f';
d1_train = fscanf(fileID,formatSpec);
d1_train=reshape(d1_train,2,length(d1_train)/2)';

fileID = fopen('data/lin_sep_1/class1_val.txt','r');
formatSpec = '%f';
d1_val = fscanf(fileID,formatSpec);
d1_val=reshape(d1_val,2,length(d1_val)/2)';

fileID = fopen('data/lin_sep_1/class1_test.txt','r');
formatSpec = '%f';
d1_test = fscanf(fileID,formatSpec);
d1_test=reshape(d1_test,2,length(d1_test)/2)';

fileID = fopen('data/lin_sep_1/class2_train.txt','r');
formatSpec = '%f';
d2_train = fscanf(fileID,formatSpec);
d2_train=reshape(d2_train,2,length(d2_train)/2)';

fileID = fopen('data/lin_sep_1/class2_val.txt','r');
formatSpec = '%f';
d2_val = fscanf(fileID,formatSpec);
d2_val=reshape(d2_val,2,length(d2_val)/2)';

fileID = fopen('data/lin_sep_1/class2_test.txt','r');
formatSpec = '%f';
d2_test = fscanf(fileID,formatSpec);
d2_test=reshape(d2_test,2,length(d2_test)/2)';


fileID = fopen('data/lin_sep_1/class3_train.txt','r');
formatSpec = '%f';
d3_train = fscanf(fileID,formatSpec);
d3_train=reshape(d3_train,2,length(d3_train)/2)';

fileID = fopen('data/lin_sep_1/class3_val.txt','r');
formatSpec = '%f';
d3_val = fscanf(fileID,formatSpec);
d3_val=reshape(d3_val,2,length(d3_val)/2)';

fileID = fopen('data/lin_sep_1/class3_test.txt','r');
formatSpec = '%f';
d3_test = fscanf(fileID,formatSpec);
d3_test=reshape(d3_test,2,length(d3_test)/2)';


fileID = fopen('data/lin_sep_1/class4_train.txt','r');
formatSpec = '%f';
d4_train = fscanf(fileID,formatSpec);
d4_train=reshape(d4_train,2,length(d4_train)/2)';

fileID = fopen('data/lin_sep_1/class4_val.txt','r');
formatSpec = '%f';
d4_val = fscanf(fileID,formatSpec);
d4_val=reshape(d4_val,2,length(d4_val)/2)';

fileID = fopen('data/lin_sep_1/class4_test.txt','r');
formatSpec = '%f';
d4_test = fscanf(fileID,formatSpec);
d4_test=reshape(d4_test,2,length(d4_test)/2)';

train_data = vertcat(d1_train,d2_train,d3_train,d4_train);
val_data = vertcat(d1_val,d2_val,d3_val,d4_val);
test_data = vertcat(d1_test,d2_test,d3_test,d4_test);

n=size(train_data,1);
    
a=ones(n,2);
for i=1:n
    a(i,1)=0;
end

for i=1:4
    for j=1:n/4
        a((i-1)*n/4+j,2)=i;
    end
end


    
val_data_neighbours = zeros(size(val_data,1),10);
for i=1:size(val_data,1)
    for j=1:size(train_data,1)
        a(j,1)=sqrt((val_data(i,1)-train_data(j,1))^2+(val_data(i,2)-train_data(j,2))^2);
    end
    train_data_frame=sortrows(a,1);
    val_data_neighbours(i,1:10)=train_data_frame(1:10,2);
end
        
predicted_values=zeros(size(val_data,1),10);

for k=1:10
    for i=1:size(val_data,1)
        predicted_values(i,k)=mode(val_data_neighbours(i,1:k));
    end
end

%finding accuracy for each value of k from 1 to 10

accuracy=[0,0,0,0,0,0,0,0,0,0];
n=size(val_data,1)/4;
for k=1:10
    for i=1:n
        accuracy(k)=accuracy(k)+(predicted_values(i,k)==1);
    end
    for i=n+1:2*n
        accuracy(k)=accuracy(k)+(predicted_values(i,k)==2);
    end
    for i=2*n+1:3*n
        accuracy(k)=accuracy(k)+(predicted_values(i,k)==3);
    end
    for i=3*n+1:4*n
        accuracy(k)=accuracy(k)+(predicted_values(i,k)==4);
    end
    accuracy(k)=accuracy(k)/(4*n);
end

k_opt=find(accuracy==max(accuracy));

% all values from k=1 to 10 are optimal. Lets take k_opt=5

k_opt=5;

%finding accuracy on test data and plotting confusion matrix for it

n=size(train_data,1);
    
a=ones(n,2);
for i=1:n
    a(i,1)=0;
end

for i=1:4
    for j=1:n/4
        a((i-1)*n/4+j,2)=i;
    end
end


    
test_data_neighbours = zeros(size(test_data,1),10);
for i=1:size(test_data,1)
    for j=1:size(train_data,1)
        a(j,1)=sqrt((test_data(i,1)-train_data(j,1))^2+(test_data(i,2)-train_data(j,2))^2);
    end
    train_data_frame=sortrows(a,1);
    test_data_neighbours(i,1:10)=train_data_frame(1:10,2);
end
        
predicted_values=zeros(size(test_data,1),10);

for k=1:10
    for i=1:size(test_data,1)
        predicted_values(i,k)=mode(test_data_neighbours(i,1:k));
    end
end

%finding accuracy for each testue of k from 1 to 10

accuracy=[0,0,0,0,0,0,0,0,0,0];
n=size(test_data,1)/4;
for k=1:10
    for i=1:n
        accuracy(k)=accuracy(k)+(predicted_values(i,k)==1);
    end
    for i=n+1:2*n
        accuracy(k)=accuracy(k)+(predicted_values(i,k)==2);
    end
    for i=2*n+1:3*n
        accuracy(k)=accuracy(k)+(predicted_values(i,k)==3);
    end
    for i=3*n+1:4*n
        accuracy(k)=accuracy(k)+(predicted_values(i,k)==4);
    end
    accuracy(k)=accuracy(k)/(4*n);
end

n=size(test_data,1);
    
a=ones(n,1);

for i=1:4
    for j=1:n/4
        a((i-1)*n/4+j,1)=i;
    end
end

accuracy(k_opt)
confusionmat(a,predicted_values(1:n,k_opt))

b=predicted_values(1:n,k_opt);

t=zeros(4,length(a));
y=zeros(4,length(a));
t(1,:)=(a==1);
t(2,:)=(a==2);
t(3,:)=(a==3);
t(4,:)=(a==4);
y(1,:)=(b==1);
y(2,:)=(b==2);
y(3,:)=(b==3);
y(4,:)=(b==4);
plotconfusion(t,y)

%plotting decision surface

min_train=min(train_data);
max_train=max(train_data);
xrange=[min_train(1)-1 max_train(1)+1];
yrange=[min_train(2)-1 max_train(2)+1];
inc = 0.5;
[x, y] = meshgrid(xrange(1):inc:xrange(2), yrange(1):inc:yrange(2));
image_size = size(x);
xy = [x(:) y(:)];

%finding class label at each point of gridmatrix
n=size(train_data,1);
    
a=ones(n,2);
for i=1:n
    a(i,1)=0;
end

for i=1:4
    for j=1:n/4
        a((i-1)*n/4+j,2)=i;
    end
end

grid_data_neighbours = zeros(size(xy,1),5);
for i=1:size(xy,1)
    for j=1:size(train_data,1)
        a(j,1)=sqrt((xy(i,1)-train_data(j,1))^2+(xy(i,2)-train_data(j,2))^2);
    end
    train_data_frame=sortrows(a,1);
    grid_data_neighbours(i,1:5)=train_data_frame(1:5,2);
end
        
idx=zeros(size(xy,1),1);


for i=1:size(xy,1)
    idx(i,1)=mode(grid_data_neighbours(i,1:5));
end

decisionmap = reshape(idx, image_size);
figure;
 
%show the image
imagesc(xrange,yrange,decisionmap);
hold on;
set(gca,'ydir','normal');
 
% colormap for the classes:
% class 1 = light red, 2 = light green, 3 = light blue, 4=white 
cmap = [1 0.8 0.8; 0.95 1 0.95; 0.9 0.9 1,; 1 1 1]
colormap(cmap);


% plot the class training data.
plot(d1_train(:,1),d1_train(:,2), 'r.');
plot(d2_train(:,1),d2_train(:,2), 'go');
plot(d3_train(:,1),d3_train(:,2), 'b*');
plot(d4_train(:,1),d4_train(:,2), '');

% include legend
legend('Class 1', 'Class 2', 'Class 3', 'Class 4','Location','NorthOutside', ...
    'Orientation', 'horizontal');
 
% label the axes.
xlabel('x');
ylabel('y');




