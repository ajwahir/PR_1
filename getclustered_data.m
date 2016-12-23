function [clustered_sequence]=getclustered_data(cluster_labels,clustered_train_data1)
    for ii=1:length(cluster_labels)
        clustered_sequence(ii)=clustered_train_data1(cluster_labels(ii));
    end
end