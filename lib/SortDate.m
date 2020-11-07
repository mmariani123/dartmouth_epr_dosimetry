function [fullPathNames fileNames] = SortDate(folderName,dataFileType)

%returns fullPathNames and fileNames sorted by date.

cd(folderName);
data = dir(dataFileType); 
dataSort= [data(:).datenum];
[s,s] = sort(dataSort);
fileNames = {data(s).name};
fullPathNames = strcat(folderName,'\',fileNames);

end