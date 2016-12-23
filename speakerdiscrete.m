
path='Team16/';
[class Traindata,Valdata,Testdata, Trainlen ,Vallen, Testlen]=getSpeakerdata(path);   
k=5;
Q=3;
O=k;
prior1 = normalise(rand(Q,1));
transmat1 = mk_stochastic(rand(Q,Q));
obsmat1 = mk_stochastic(rand(Q,O)); 

for classindx=1:size(class,1)
[cluster,center]=kmeans(Traindata{classindx},k);
[cluster_cell,~]=getSequence(cluster,Trainlen{classindx},1);
[~, prior2{classindx}, transmat2{classindx}, obsmat2{classindx}] = dhmm_em(cluster_cell, prior1, transmat1, obsmat1, 'max_iter', 50);
end

% prediction
total_length_test=0;
actual_classes=[];
for ii=1:size(class,1)
    total_length_test=total_length_test+sum(Trainlen{ii});
    inter_actual=zeros(10,1);
    inter_actual(find(inter_actual==0))=ii;
    actual_classes=[actual_classes; inter_actual];
end



all_speaker_test=getSequenceSpeech(Testdata,Testlen,class);
% all_speaker_test_array=[];
for ii=1:length(all_speaker_test)
[all_clutered_test{ii},~]=kmeans(all_speaker_test{ii},k);
end

predicted_class=[];
for particularSeq=1:length(actual_classes)
    loglik=[];
for ii=1:size(class,1)
    loglik = [loglik;dhmm_logprob(all_clutered_test{particularSeq}, prior2{ii}, transmat2{ii}, obsmat2{ii})];
end
    predicted_class(particularSeq)=find(loglik==max(loglik));
end
predicted_class=predicted_class';
[confusion_matrix,order]=confusionmat(actual_classes,predicted_class)
accuracy = sum(predicted_class==actual_classes)/(length(actual_classes))*100

% % GMM-HMM
% M = 2;
% Q = 2;
% left_right = 0;
% 
% prior0 = normalise(rand(Q,1));
% transmat0 = mk_stochastic(rand(Q,Q));
% [Train,~]=getIndividualSequence(Traindata{1},Trainlen{1},1);
% Train=formatchange(Train);
% [mu0, Sigma0] = mixgauss_init(Q*M, Train, 'diag');
% mu0 = reshape(mu0, [O Q M]);
% Sigma0 = reshape(Sigma0, [O O Q M]);
% mixmat0 = mk_stochastic(rand(Q,M));
% 
% 
% 
