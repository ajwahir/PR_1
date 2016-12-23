function [all_speaker_test]=getSequenceSpeech(Testdata,Testlen,class)
    all_speaker_test={};
    for ii=1:size(class,1)
        [interseq,~]=getIndividualSequence(Testdata{ii},Testlen{ii},1);
        all_speaker_test=[all_speaker_test; interseq];
    end
end
