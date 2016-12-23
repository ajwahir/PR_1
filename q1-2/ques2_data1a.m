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

%part (a)
%finding common sigma
mu1=sum(train_data(1:size(train_data,1),1))/size(train_data,1);
mu2=sum(train_data(1:size(train_data,1),2))/size(train_data,1);
sigma=0;
for i=1:size(train_data,1)
    sigma=sigma+(train_data(i,1)-mu1)^2+(train_data(i,2)-mu2)^2;
end
sigma=sigma/size(train_data,1);
sigma=sqrt(sigma);
%finding classwise mean

n=size(train_data,1)/4;
mean=zeros(4,2);
for i=1:4
    for j=1:2
        mean(i,j)=sum(train_data(n*(i-1)+1:n*i,j))/n;
    end
end

%finding probabilities and predicting class of test data

n=size(test_data,1);
test_prob=zeros(n,4);
predicted_class=zeros(n,1);
for i=1:n
    for j=1:4
        test_prob(i,j)=-log(sigma)-((test_data(i,1)-mean(j,1))^2)/(2*sigma^2)-log(sigma)-((test_data(i,2)-mean(j,2))^2)/(2*sigma^2);
    end
    d=test_prob(i,1:4);
    predicted_class(i)=find(d==max(d));
end


accuracy=0;
n=size(test_data,1)/4;
    for i=1:n
        accuracy=accuracy+(predicted_class(i)==1);
    end
    for i=n+1:2*n
        accuracy=accuracy+(predicted_class(i)==2);
    end
    for i=2*n+1:3*n
        accuracy=accuracy+(predicted_class(i)==3);
    end
    for i=3*n+1:4*n
        accuracy=accuracy+(predicted_class(i)==4);
    end
    accuracy=accuracy/(4*n);

n=size(test_data,1);
    
a=ones(n,1);

for i=1:4
    for j=1:n/4
        a((i-1)*n/4+j,1)=i;
    end
end

accuracy

confusionmat(a,predicted_class(1:n,1))
b=predicted_class(1:n,1);

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

n=size(xy,1);
grid_prob=zeros(n,4);
idx=zeros(n,1);
for i=1:n
    for j=1:4
        grid_prob(i,j)=-log(sigma)-((xy(i,1)-mean(j,1))^2)/(2*sigma^2)-log(sigma)-((xy(i,2)-mean(j,2))^2)/(2*sigma^2);
    end
    d=grid_prob(i,1:4);
    idx(i)=find(d==max(d));
end

decisionmap = reshape(idx, image_size);
figure;
 
%show the image
imagesc(xrange,yrange,decisionmap);
hold on;
set(gca,'ydir','normal');
 
% colormap for the classes:
% class 1 = light red, 2 = light green, 3 = light blue, 4=white 
cmap = [1 0.8 0.8; 0.95 1 0.95; 0.9 0.9 1; 1 1 1]
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






%part (b)


%finding both sigma
mu1=sum(train_data(1:size(train_data,1),1))/size(train_data,1);
mu2=sum(train_data(1:size(train_data,1),2))/size(train_data,1);
sigma1=0;
sigma2=0;
for i=1:size(train_data,1)
    sigma1=sigma1+(train_data(i,1)-mu1)^2;
end
sigma1=sigma1/size(train_data,1);
sigma1=sqrt(sigma1);

for i=1:size(train_data,1)
    sigma2=sigma2+(train_data(i,2)-mu2)^2;
end
sigma2=sigma2/size(train_data,1);
sigma2=sqrt(sigma2);

%finding classwise mean
n=size(train_data,1)/4;
mean=zeros(4,2);
for i=1:4
    for j=1:2
        mean(i,j)=sum(train_data(n*(i-1)+1:n*i,j))/n;
    end
end

%finding probabilities and predicting class of test data

n=size(test_data,1);
test_prob=zeros(n,4);
predicted_class=zeros(n,1);
for i=1:n
    for j=1:4
        test_prob(i,j)=-log(sigma1)-((test_data(i,1)-mean(j,1))^2)/(2*sigma1^2)-log(sigma2)-((test_data(i,2)-mean(j,2))^2)/(2*sigma2^2);
    end
    d=test_prob(i,1:4);
    predicted_class(i)=find(d==max(d));
end


accuracy=0;
n=size(test_data,1)/4;
    for i=1:n
        accuracy=accuracy+(predicted_class(i)==1);
    end
    for i=n+1:2*n
        accuracy=accuracy+(predicted_class(i)==2);
    end
    for i=2*n+1:3*n
        accuracy=accuracy+(predicted_class(i)==3);
    end
    for i=3*n+1:4*n
        accuracy=accuracy+(predicted_class(i)==4);
    end
    accuracy=accuracy/(4*n);

n=size(test_data,1);
    
a=ones(n,1);

for i=1:4
    for j=1:n/4
        a((i-1)*n/4+j,1)=i;
    end
end

accuracy

confusionmat(a,predicted_class(1:n,1))
b=predicted_class(1:n,1);

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
n=size(xy,1);
grid_prob=zeros(n,4);
idx=zeros(n,1);
for i=1:n
    for j=1:4
        grid_prob(i,j)=-log(sigma1)-((xy(i,1)-mean(j,1))^2)/(2*sigma1^2)-log(sigma2)-((xy(i,2)-mean(j,2))^2)/(2*sigma2^2);
    end
    d=grid_prob(i,1:4);
    idx(i)=find(d==max(d));
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




%part (c)

%finding all sigma and means
n=size(train_data,1)/4;
mean=zeros(4,2);
for i=1:4
    for j=1:2
        mean(i,j)=sum(train_data(n*(i-1)+1:n*i,j))/n;
    end
end

n=size(train_data,1)/4;
sigma=zeros(4,2);
for i=1:4
    for j=1:2
        sigma(i,j)=0;
        for k=1:n
            sigma(i,j)=sigma(i,j)+(train_data(n*(i-1)+k,j)-mean(i,j))^2;
        end
        sigma(i,j)=sqrt(sigma(i,j)/n);
    end
end

%finding probabilities and predicting class of test data

n=size(test_data,1);
test_prob=zeros(n,4);
predicted_class=zeros(n,1);
for i=1:n
    for j=1:4
        test_prob(i,j)=-log(sigma(j,1))-((test_data(i,1)-mean(j,1))^2)/(2*sigma(j,1)^2)-log(sigma(j,2))-((test_data(i,2)-mean(j,2))^2)/(2*sigma(j,2)^2);
    end
    d=test_prob(i,1:4);
    predicted_class(i)=find(d==max(d));
end

accuracy=0;
n=size(test_data,1)/4;
    for i=1:n
        accuracy=accuracy+(predicted_class(i)==1);
    end
    for i=n+1:2*n
        accuracy=accuracy+(predicted_class(i)==2);
    end
    for i=2*n+1:3*n
        accuracy=accuracy+(predicted_class(i)==3);
    end
    for i=3*n+1:4*n
        accuracy=accuracy+(predicted_class(i)==4);
    end
    accuracy=accuracy/(4*n);

n=size(test_data,1);
    
a=ones(n,1);

for i=1:4
    for j=1:n/4
        a((i-1)*n/4+j,1)=i;
    end
end

accuracy

confusionmat(a,predicted_class(1:n,1))
b=predicted_class(1:n,1);

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
n=size(xy,1);
grid_prob=zeros(n,4);
idx=zeros(n,1);
for i=1:n
    for j=1:4
        grid_prob(i,j)=-log(sigma(j,1))-((xy(i,1)-mean(j,1))^2)/(2*sigma(j,1)^2)-log(sigma(j,2))-((xy(i,2)-mean(j,2))^2)/(2*sigma(j,2)^2);
    end
    d=grid_prob(i,1:4);
    idx(i)=find(d==max(d));
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
