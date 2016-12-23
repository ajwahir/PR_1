clear;
classes = [char('fmjf0'); char('fpaf0'); char('fsak0');char('mfwk0');char('mgag0') ;char('mjxl0'); char('mljc0') ;char('mppc0') ;char('mrdd0'); char('mzmb0')];
n_class = size(classes,2);
train_data = cell(n_class,1);
for i = 1:n_class
    path = strcat(char('Team16/') ,classes(i,:),char('/Train/'));
    dirlist = dir(char(strcat(path,char('.'))));
    train_data{i} = cell(length(dirlist)-2,1);
    for j = 3:length(dirlist)
        fileID = fopen(strcat(path,dirlist(j).name),'r');
        fgets(fileID);
        k = 1;
        while ~feof(fileID)
            temp = fgets(fileID);
            temp = temp(1:end-1);
            train_data{i}{j-2}(k,:) = str2double(strsplit(temp,' '));
            k = k+1;
        end
    end
end


test_data = cell(n_class,1);
for i = 1:n_class
    path = strcat(char('Team16/') ,classes(i),char('/Test/'));
    dirlist = dir(char(strcat(path,char('.'))));
    test_data{i} = cell(length(dirlist)-2,1);
    for j = 3:length(dirlist)
        fileID = fopen(strcat(path,dirlist(j).name),'r');
        fgets(fileID);
        k = 1;
        while ~feof(fileID)
            temp = fgets(fileID);
            temp = temp(1:end-1);
            test_data{i}{j-2}(k,:) = str2double(strsplit(temp));
            k = k+1;
        end
    end
end
% fileID = fopen('Team16/fmjf0/Train/sa1','r');
% formatSpec = '%f';
% d1_train = fscanf(fileID,formatSpec);


val_data = cell(n_class,1);
for i = 1:n_class
    path = strcat(char('Team16/') ,classes(i),char('/Val/'));
    dirlist = dir(char(strcat(path,char('.'))));
    val_data{i} = cell(length(dirlist)-2,1);
    for j = 3:length(dirlist)
        fileID = fopen(strcat(path,dirlist(j).name),'r');
        fgets(fileID);
        k = 1;
        while ~feof(fileID)
            temp = fgets(fileID);
            temp = temp(1:end-1);
            val_data{i}{j-2}(k,:) = str2double(strsplit(temp));
            k = k+1;
        end
    end
end
