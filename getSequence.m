function [all_sequence,classac]=getSequence(data,lengths,class)
prev=1;
all_sequence={};
% all_sequence=zeros(length(lengths),2);
    for ii=1:length(lengths)
        all_sequence{ii}=data(prev:prev+lengths(ii)-1);
        prev=prev+lengths(ii);
        classac(ii)=class;
    end
end