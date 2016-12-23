function [cluster_labels,cluster_labels_test,cluster_labels_val,test_lengths,val_lengths]=getIsolatedworddata(path,kmeansK,iter)
    format long

% Reading class 3
data={};
corresIndex={};
inter=[];
len_sequence3=[];
pathclass3=path;
listdir3=dir(pathclass3);
Totalseq=[];
len=[];
nn=0;
for ii=1:length(listdir3)
    if strfind(listdir3(ii).name,'txt')
       nn=nn+1 ;
       fileID = fopen([path '/' listdir3(ii).name],'r');
       allText = textscan(fileID,'%s','delimiter','\n');                        
       Nrows = length(allText{1});
       Ncol = length(strfind(allText{1,1}{1,1},' '));
       fclose(fileID);
       fileID = fopen([path '/' listdir3(ii).name],'r');
       seq=fscanf(fileID,'%f');
       seqr=seq;
       seqr=reshape(seqr,Nrows,Ncol);
       data{ii-2}=seqr;
%        Totalseq=[Totalseq;seqr];
%        len=[len Nrows];
       fclose(fileID);
                        
%        k= strfind(listdir3(ii).name,'_');
%        tx= strfind(listdir3(ii).name,'.');
%        len_sequence=listdir3(ii).name(k(2)+1:tx-1);
%        index=listdir3(ii).name(k(1)+1:k(2)-1);
%        fileID = fopen([pathclass3 '/' listdir3(ii).name],'r');
%        A=textscan(fileID,'%s %s','Delimiter',',');
%        
%        for tt=1:2
%        for kk=1:length(A{1,1})
%             inter= [inter str2double(A{1,tt}{kk})];
%            end
%        end
%        inter=reshape(inter,length(inter)/2,2);
%        data{nn}=inter;
%        len_sequence3=[len_sequence3 len_sequence];
%        corresIndex{nn}=index;
%        inter=[];
%        fclose(fileID);
%        
    end
end

% convert to double and concatnate
class_data_matrix=[];
train_data1=[];
test_data1=[];
val_data1=[];
train_lengths=[];
test_lengths=[];
val_lengths=[];
number_train=round(length(data)*.7);
number_test=round(length(data)*.15);
number_val=(length(data)-(number_train+number_test));
% to select the training and testing data seperately
random_choose=randperm(length(data));
% kmeans params
k=kmeansK;
% iter=7;

for tt=1:length(data)
    data{random_choose(tt)}=double(data{tt});
    if tt<= number_train
        train_data1 = vertcat(train_data1,data{random_choose(tt)});
        train_lengths=[train_lengths length(data{random_choose(tt)}(:,1))];
    elseif tt> number_train && tt<=number_train+number_test
        test_data1= vertcat(train_data1,data{random_choose(tt)});
        test_lengths=[test_lengths length(data{random_choose(tt)}(:,1))];
    else
        val_data1=vertcat(train_data1,data{random_choose(tt)});
        val_lengths=[val_lengths length(data{random_choose(tt)}(:,1))];

    end      
end

[cluster_labels,clustered_train_data1]=kmeans(train_data1,k);
% [cluster_labels,clustered_train_data1]=simple_kmeans(train_data1,k,iter);
cell_train_data=convert_cell(cluster_labels,train_lengths);

[cluster_labels_test,clustered_test_data1]=kmeans(test_data1,k);

[cluster_labels_val,clustered_val_data1]=kmeans(val_data1,k);


end