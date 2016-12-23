function [changed_data]=formatchange(data)
for ii=1:size(data)
    changed_data{ii}=data{ii}';
end