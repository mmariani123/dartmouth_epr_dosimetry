function [excelFile excelData] = DataToCell(fileName) %should add mode argument here to write to txt.

%read the three types of data from the spectra 
%follow the name style: *_pre,*_*Gy_precut,*_*Gy_cut
%pre is the data before irradiation
%irra is the data after irradiation, before cut
%cut is the data after cut
%field is the x-axis of the spectra

data = nailspec;

for i = 1:18
    for j = 1:5
    totalSpec(:,j) = data(i).spec(:,j);
    end
    totalSpecNow(:,(i-1)*5+1:i*5) = totalSpec;
end


len = length(data);             %len = 18.
%make sure you have three types of data for each sample
assert(mod(len,3)==0);

field = data(1).field;
field = field';

excelData = zeros(length(field),len);

excelData = totalSpecNow;

excelFile = xlswrite('C:\Users\f000mps\Desktop\hello',excelData);

end


function naildata=nailspec
% nailspec extract all the information from the spectrum, 
% including magnetic field, signal amplitude and the acquisition parameters
% it will fill into the database of the following parameters
% experiment=struct('field',{},'spec',{},'para',{});


    F=dir('*.spc');
    if isempty(F)
        F = dir('*.dta');
    end
    naildata(length(F)).field=0;
    for i=1:length(F)
        [b,s,p]=eprload(F(i).name);
        naildata(i).field=b;
        naildata(i).spec=s;
        naildata(i).para=p;
        naildata(i).para.filename=F(i).name;
    end
end