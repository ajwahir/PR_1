function [all_sequence,classac]=getIndividualSequence(data,lengths,class)

all_sequence={};
% all_sequence=zeros(length(lengths),2);
 prev=1;
    for ii=1:length(lengths)
       
%         for kk=1:lengths(ii)
        all_sequence=[all_sequence;data(prev:prev+lengths(ii)-1,:)];
        prev=prev+lengths(ii);
        classac(ii)=class;
%         end
    end
end