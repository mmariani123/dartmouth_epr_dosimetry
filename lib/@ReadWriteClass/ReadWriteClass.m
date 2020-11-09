classdef ReadWriteClass

properties
    folderName;
    dataFileType;
    spectra;
    numSpectraPoints;
end
    
    
methods
    
function ReadWriteClass()
    % class constructor
    if(nargin > 0)
        obj.spectra = [];
    end
end
 
function Load()
   
    if fileType = 'xls'
        obj.spectra = xlsread(obj.filePath);
    elseif obj.fileType = 'txt'
        obj.spectra = txtread(obj.flePath);
    else
        errror('Must load file with correct file type: .DAT,.SPC,.XLS, etc.');
    end
    
end

function [fullPathNames fileNames] = SortDate(folderName,dataFileType)

%returns fullPathNames and fileNames sorted by date.

cd(folderName);
data = dir(dataFileType); 
dataSort= [data(:).datenum];
[s,s] = sort(dataSort);
fileNames = {data(s).name};
fullPathNames = strcat(folderName,'\',fileNames);

end

end


end