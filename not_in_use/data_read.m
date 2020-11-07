
function [pre irra cut field]=data_read()
%read the three types of data from the spectra 
%follow the name style: *_pre,*_*Gy_precut,*_*Gy_cut
%pre is the data before irradiation
%irra is the data after irradiation, before cut
%cut is the data after cut
%field is the x-axis of the spectra

data = nailspec;
len = length(data);
%make sure you have three types of data for each sample
assert(mod(len,3)==0);

field = data(1).field;
field = field';

spec = zeros(length(field),len);

for i=1:len
    spec(:,i)=mean(data(i).spec,2);
end
pre = spec(:,3:3:end);
irra = spec(:,2:3:end);
cut = spec(:,1:3:end);

end


