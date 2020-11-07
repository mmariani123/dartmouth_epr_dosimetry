function [spectrum] = CenterraReadFLS(filePath,nspec,nspec_low)

%Original file was read_FLS_flex.m  , author currently unknown.

%   [spectrum]=read_FLS_flex(prefix,[nspec,nspec_low])
%   This function reads an FLS file, returning
%   spectrum = the spectral data structure (including pars, comments,
%   and data    
%           pars = the acquisition paramters
%               [0,sw_width,rec_gain,scan_time,mod_amp,0,B0,...
%               bridge_atten,tc,scan_nr,stop_time]
%           nspec, is an optional number of spectra to read
%           nspec_low, is an optional minimum filenumber to read, e.g start with
%               the (nspec_low+1)th measured spectrum

%   tline = fgetl(fileID) returns the next line of the specified file, removing the newline characters.

spectrum.pars=cell(11,2);      % initialize first elements of arrays
%spectrum.comment=zeros(90,1);   % setsMaximumsize for comment field.
spectrum.comment=cell(1,1);
spectrum.comment{1,1} = '';
spectrum.data=zeros(1024,1);
%spectrum.filename=zeros(length(prefix)+6,1);
spectrum.filename = zeros(length(filePath),1);

if exist('nspecLow')==0
    nspecLow=0;
end

if (nspec == 0) | (exist('nspec')==0)
    nspec=0;
    error('You must specify number of spectra to read!');
end

for n=1:nspec
    nspecStr='00';
    if (nspecLow+n-1)<10
        nspecStr(1)='0';
        nspecStr(2)=num2str(nspecLow+n-1);
    elseif (nspecLow+n-1)>99
        nspecStr='000';
        spectrum.filename=zeros(length(filePath)+7,1);
        nspecStr=num2str(nspecLow+n-1);
    else
        nspecStr=num2str(nspecLow+n-1);
    end
    %spectrum.filename(:,n)=strcat(filePath,nspecStr,'.FLS');
    
    spectrum.filename(:,n)=strcat(filePath);
    strtemp=char(spectrum.filename(:,n))';
    
    
    fid=fopen(strtemp,'r');
    
    
    if fid==(-1)
        disp(strcat(num2str(n-1),' spectra read into memory.'));
        spectrum.filename(:,n)=[];
        return;
    else
        disp(strcat('Loading --',char(spectrum.filename(:,n))'));
    end
    
    line=fgetl(fid);    % line with file type identifier
    if (strcmp(line,'FLS'))==0
        disp('This is not an FLS file.');
        return;
    end
    line=fgetl(fid);    % line with number of points
    npts=str2num(line);
    if n==1
        spectrum.data=zeros(npts,1);    % initialize first elements of data array
    end
    line=fgetl(fid);    % dummy line with "? , ,"
    line=fgetl(fid);    % line with acq. parameters
    %lineNew = strrep(line, 'dB', '');
    %abs(str2num(lineNew)')
    %length(abs(str2num(lineNew)'))
   
    upside = {'NA', 'Sweep Width', 'Receiver Gain', 'Sweep Time', 'Modulation', 'NA', 'Center Field', 'Attenuation', 'Time Constant', 'NA', 'Accumulation'}';
    for parCounter1 = 1:11
        spectrum.pars{parCounter1,1} = upside{parCounter1,1};
    end
    cellString = mat2cell(line);
    splitString = cell(11,1);
    splitString = strsplit(cellString{1,1},' ')';
     for parCounter2 = 1:11
        spectrum.pars{parCounter2,2} = splitString{parCounter2,1} ;
    end
   
    
    line=fgetl(fid);    % comment line;
    
    if length(line)<90
        % bug in comment line with the addition of the data comment, so
        disp('Bug in comment line due to date -> work around.');
        junk=fgetl(fid); % toss out next line
        line(90)=' ';
    elseif length(line)>90
        line(91:end) = [];
    end
    
    spectrum.comment = cellstr(line);

    for i=1:npts
        line=fgetl(fid);
        spectrum.data(i,n)=str2num(line);
    end
    
    fclose(fid);
    
end     % nspec loop

disp(strcat(num2str(n),' spectra read into memory.'));