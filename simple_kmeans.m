function[cluster_labels,center]=simple_kmeans(data,k,iter)
    center=zeros(k,1);
    cluster_labels=randi(k,1,size(data,1));
    
%     initializing centers 
    for ii=1:k
       center(ii)=mean(data(ii==cluster_labels));
    end
    
    for jj=1:iter
        for seq=1:size(data,1)
        for i=1:k
            distance(seq,i)=norm(data(seq,:)-[center(i) center(i)]);
        end
        
           [~,cluster_labels(seq)]=min(distance(seq,:));
        end
        for ii=1:k
            center(ii)=mean(data(ii==cluster_labels));
        end
    end

end