clc
class1='G:\5th_Semester\PatternRecognition-CS6690\assignment1\Dataset_Assignment1-20161026T193723Z\Dataset_Assignment1\Dataset-1_2Dimensional\Trajectory Dataset\Trajectory_data\class3';
class2='G:\5th_Semester\PatternRecognition-CS6690\assignment1\Dataset_Assignment1-20161026T193723Z\Dataset_Assignment1\Dataset-1_2Dimensional\Trajectory Dataset\Trajectory_data\class7';
class3='G:\5th_Semester\PatternRecognition-CS6690\assignment1\Dataset_Assignment1-20161026T193723Z\Dataset_Assignment1\Dataset-1_2Dimensional\Trajectory Dataset\Trajectory_data\class2';

k=11;
Q=3;
O=k;
iter=15;


[train1,test1,val1,lengthtest1,lengthval1]=readTrajectorydata(class1,k,iter);
[test_sequence1,classac1]=getSequence(test1,lengthtest1,1);
[train2,test2,val2,lengthtest2,lengthval2]=readTrajectorydata(class2,k,iter);
[test_sequence2,classac2]=getSequence(test2,lengthtest2,2);
[train3,test3,val3,lengthtest3,lengthval3]=readTrajectorydata(class3,k,iter);
[test_sequence3,classac3]=getSequence(test3,lengthtest3,3);

all_test_sequence=[test_sequence1 test_sequence2 test_sequence3];
actual_class=horzcat(classac1,classac2,classac3);
actual_class=reshape(actual_class,max(size(actual_class)),1);
predicted_class=zeros(length(all_test_sequence),1);

% Train for all the three classes
prior1 = normalise(rand(Q,1));
transmat1 = mk_stochastic(rand(Q,Q));
obsmat1 = mk_stochastic(rand(Q,O)); 

[~, prior2_1, transmat2_1, obsmat2_1] = dhmm_em(train1, prior1, transmat1, obsmat1, 'max_iter', 20);

prior1 = normalise(rand(Q,1));
transmat1 = mk_stochastic(rand(Q,Q));
obsmat1 = mk_stochastic(rand(Q,O));

[~, prior2_2, transmat2_2, obsmat2_2] = dhmm_em(train2, prior1, transmat1, obsmat1, 'max_iter', 20);

prior1 = normalise(rand(Q,1));
transmat1 = mk_stochastic(rand(Q,Q));
obsmat1 = mk_stochastic(rand(Q,O));

[~, prior2_3, transmat2_3, obsmat2_3] = dhmm_em(train3, prior1, transmat1, obsmat1, 'max_iter', 20);

% prediction
predicte_class=[];
for ii=1:length(all_test_sequence)
    loglik=[];
    loglik = [loglik;dhmm_logprob(all_test_sequence{ii}, prior2_1, transmat2_1, obsmat2_1)];
    loglik = [loglik; dhmm_logprob(all_test_sequence{ii}, prior2_2, transmat2_2, obsmat2_2)];
    loglik = [loglik ;dhmm_logprob(all_test_sequence{ii}, prior2_3, transmat2_3, obsmat2_3)];
    predicted_class(ii)=find(loglik==max(loglik));
end

[confusion_matrix,order]=confusionmat(actual_class,predicted_class)
accuracy = sum(predicted_class==actual_class)/(length(actual_class))*100

