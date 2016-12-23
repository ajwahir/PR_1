value1=[10,0,0,0,0,0,0,0,0,0;0,8,1,0,1,0,0,0,0,0;0,3,7,0,0,0,0,0,0,0;0,0,1,7,0,0,2,0,0,0;0,0,0,0,10,0,0,0,0,0;0,0,0,2,0,8,0,0,0,0;0,0,0,0,2,1,7,0,0,0;0,0,0,0,0,0,0,10,0,0;0,2,0,0,0,0,2,1,5,0;1,2,0,1,0,0,3,0,0,3]
gorder=[1 2 3 4 5 6 7 8 9 10]
% value1=[8,0,1,0,0,0,0,1,0,0;2,3,4,0,1,0,0,0,0,0;0,5,3,0,0,0,1,0,0,1;0,1,0,1,1,1,4,0,0,2;0,0,0,1,6,0,0,2,1,0;0,0,1,2,0,4,2,0,0,1;0,2,0,0,0,0,6,0,1,1;0,0,3,0,0,1,0,5,0,1;0,1,1,0,0,0,3,0,5,0;3,0,0,0,1,1,1,0,0,4]



numOfClasses = size(value1,1);
totalSamples = sum(sum(value1));

for i = 1:length(value1(:,1))
    TP(i)=value1(i,i);
    FP(i)=sum(value1(:,i))-TP(i);
    FN(i)=sum(value1(i,:))-TP(i);
    TN(i)=sum(sum(value1))-(sum(value1(i,:))+sum(value1(:,i))-TP(i));
    
    N(i)=FP(i)+TN(i);
    P(i)=TP(i)+FN(i);
end
    


for class = 1:numOfClasses
    far(class)=FP(class)/N(class);
    frr(class)=FN(class)/P(class);
end


plot(far,frr)