function [class_name Traindata,Valdata,Testdata, Trainlen ,Vallen, Testlen]=getSpeakerdata(path)
classes=dir(path);
class_name=[];
Type_data=[];
Trainlen={};
Testlen={};
Vallen={};
Testdata={};
Traindata={};
Valdata={};

for ii=1:length(classes)
    if isempty(strfind(classes(ii).name,'.'))==1
        class_name=[class_name; classes(ii).name]
        dataType=dir([path classes(ii).name]);
        for ff=1:length(dataType)
            if isempty(strfind(dataType(ff).name,'.'))==1
                Type_data=[Type_data dataType(ff).name];
                sequences=dir(strcat(path,classes(ii).name,'/',dataType(ff).name));
                
                if strcmp(dataType(ff).name,'Train')
                    Trainseq=[];
                    len=[];
                    for kk=3:length(sequences)
                        datapath=[path classes(ii).name '/' dataType(ff).name '/' sequences(kk).name]
                        fileID = fopen(datapath,'r');
                        allText = textscan(fileID,'%s','delimiter','\n');                        
                        Nrows = length(allText{1});
                        fclose(fileID);
                        fileID = fopen(datapath,'r');
                        seq=fscanf(fileID,'%f');
                        seqr=seq(3:end);
                        seqr=reshape(seqr,Nrows-1,seq(1));
                        Trainseq=[Trainseq;seqr];
                        len=[len Nrows-1];
                        fclose(fileID);
                    end
                        Trainlen{ii-2}=len;
                        Traindata{ii-2}=Trainseq;
                        
                elseif strcmp(dataType(ff).name,'Val')
                    Valseq=[];
                    len=[];
                    for kk=3:length(sequences)
                        datapath=[path classes(ii).name '/' dataType(ff).name '/' sequences(kk).name]
                        fileID = fopen(datapath,'r');
                        allText = textscan(fileID,'%s','delimiter','\n');
                        Nrows = length(allText{1});
                        fclose(fileID);
                        fileID = fopen(datapath,'r');
                        seq=fscanf(fileID,'%f');
                        seqr=seq(3:end);
                        seqr=reshape(seqr,Nrows-1,seq(1));
                        Valseq=[Valseq;seqr];
                        len=[len Nrows-1];
                        fclose(fileID);
                    end
                        Vallen{ii-2}=len;
                        Valdata{ii-2}=Valseq;
                 elseif strcmp(dataType(ff).name,'Test')
                     Testseq=[];
                     len=[];
                    for kk=3:length(sequences)
                        datapath=[path classes(ii).name '/' dataType(ff).name '/' sequences(kk).name]
                        fileID = fopen(datapath,'r');
                        allText = textscan(fileID,'%s','delimiter','\n');                        
                        Nrows = length(allText{1});
                        fclose(fileID);
                        fileID = fopen(datapath,'r');
                        seq=fscanf(fileID,'%f');
                        seqr=seq(3:end);
                        seqr=reshape(seqr,Nrows-1,seq(1));
                        Testseq=[Testseq;seqr];
                        len=[len Nrows-1];
                        fclose(fileID);

                    end
                        Testlen{ii-2}=len;
                        Testdata{ii-2}=Testseq;
                end
            end
        end
    end
end 
                        
                        
end