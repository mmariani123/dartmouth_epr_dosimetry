function varargout = NailDosimetry(varargin)
% NAILDOSIMETRY MATLAB code for NailDosimetry.fig
%      NAILDOSIMETRY, by itself, creates a new NAILDOSIMETRY or raises the existing
%      singleton*.
%
%      H = NAILDOSIMETRY returns the handle to a new NAILDOSIMETRY or the handle to
%      the existing singleton*.
%
%      NAILDOSIMETRY('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in NAILDOSIMETRY.M with the given input arguments.
%
%      NAILDOSIMETRY('Property','Value',...) creates a new NAILDOSIMETRY or raises
%      the existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before NailDosimetry_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to NailDosimetry_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help NailDosimetry

% Last Modified by GUIDE v2.5 01-Sep-2014 19:24:50

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @NailDosimetry_OpeningFcn, ...
                   'gui_OutputFcn',  @NailDosimetry_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT

% --- Executes just before NailDosimetry is made visible.
function NailDosimetry_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to NailDosimetry (see VARARGIN)

% Choose default command line output for NailDosimetry
handles.output = hObject;

% Update handles structure
handles.spectra = [];
handles.spectraTrun = [];
handles.spectraInformation = [];
handles.numSpectraPoints = [];
handles.numFitPoints = [];
handles.subtract = false;
handles.average = false;
handles.multiPlot = false;
handles.currentDoses = 0;
handles.fileName = [];
handles.fileDir = [];
handles.basisSpectra = [];
handles.spectraStruct = struct('name',[],'path',[],'spectra',[]);
set(handles.uitable1,'Data',[]);
handles.smoothFit = false;
handles.timesSmoothBeforeFit = 0;
handles.correctOffset = false;
guidata(hObject, handles);
handles.subtractBackground = 'false';
handles.totalMass = 0;
handles.fieldCenter = [];
handles.fieldWidth = [];
handles.plotFit = false;
handles.normalize = false;

initialize_gui(hObject, handles, false);

% UIWAIT makes NailDosimetry wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = NailDosimetry_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --------------------------------------------------------------------
function initialize_gui(fig_handle, handles, isreset)
% If the metricdata field is present and the reset flag is false, it means
% we are we are just re-initializing a GUI by calling it from the cmd line
% while it is up. So, bail out as we dont want to reset the data.
if isfield(handles, 'metricdata') && ~isreset
    return;
end

% Update handles structure
guidata(handles.figure1, handles);


function fit_start_edit_Callback(hObject, eventdata, handles)
% hObject    handle to fit_start_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of fit_start_edit as text
%        str2double(get(hObject,'String')) returns contents of fit_start_edit as a double
value = str2double(get(hObject,'String'));
if ~isa(value,'numeric') || isnan(value)
    error('Fit stop point must be a number!');
else
    handles.fitStart = value;
    guidata(hObject,handles);
end


% --- Executes during object creation, after setting all properties.
function fit_start_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to fit_start_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function fit_stop_edit_Callback(hObject, eventdata, handles)
% hObject    handle to fit_stop_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of fit_stop_edit as text
%        str2double(get(hObject,'String')) returns contents of fit_stop_edit as a double
value = str2double(get(hObject,'String'));
if ~isa(value,'numeric') || isnan(value)
    error('Fit stop point must be a number!');
else
    handles.fitStop = value;
    guidata(hObject,handles);
end


% --- Executes during object creation, after setting all properties.
function fit_stop_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to fit_stop_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function pos_down_field_edit_Callback(hObject, eventdata, handles)
% hObject    handle to pos_down_field_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of pos_down_field_edit as text
%        str2double(get(hObject,'String')) returns contents of pos_down_field_edit as a double
value = str2double(get(hObject,'String'));
if ~isa(value,'numeric') || isnan(value)
    error('Position down field must be a number!');
else
    handles.posDown = value;
    guidata(hObject,handles);
end

% --- Executes during object creation, after setting all properties.
function pos_down_field_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pos_down_field_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in file_type_popupmenu.
function file_type_popupmenu_Callback(hObject, eventdata, handles)
% hObject    handle to file_type_popupmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns file_type_popupmenu contents as cell array
%        contents{get(hObject,'Value')} returns selected item from file_type_popupmenu


% --- Executes during object creation, after setting all properties.
function file_type_popupmenu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to file_type_popupmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in run_procedure_button.
function run_procedure_button_Callback(hObject, eventdata, handles)
% hObject    handle to run_procedure_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
tableData = get(handles.uitable1,'Data');
fileNames = tableData(1:handles.currentDoses,1);
doses = tableData(1:handles.currentDoses,2);
masses = tableData(1:handles.currentDoses,3);
subtractNames = tableData(1:handles.currentDoses,4);
fitType = handles.fitType;                        
stdStart = handles.stdStart;                    
stdEnd   = handles.stdEnd;                    
numSpectraPoints = handles.numberSpectraPoints;              
fitStart = handles.fitStart;
fitStop = handles.fitStop;
posUp = handles.posUp;
posDown = handles.posDown;
numFitPoints = handles.numFitPoints;
smoothBeforeFit = handles.smoothFit;            
timesSmoothPostCut = handles.timesSmoothBeforeFit;                
subtractBackground = handles.subtractBackground;                        
numberOfDoses = handles.currentDoses;
truncateLow = [];
truncateHigh = [];

if (fitStop - fitStart) + 1 ~= numFitPoints
error('Number Fit Points Error!');
end
if posUp < 0 
    error('Position up field must be a positive value!');
elseif posDown < 0 
    error('position down field must be a positive value!');
elseif posUp == posDown
    error('position up cannot equal position down!');
elseif (numSpectraPoints-posUp) <= (numSpectraPoints-posDown)
    error('Position up must be larger than position down!');
end
if stdEnd + posUp   > numSpectraPoints                 
    error('Position up cannot exceed total number of spectra points');
end

masses = masses(:);
for numMass = 1: length(masses)
    handles.totalMass = handles.totalMass + str2double(masses(numMass));
end

for i2 = 1:length(fileNames)
    if length(handles.spectraStruct.name)==0
        error('Must add spectra to include files for analysis!');
    end
    for m = 1:length(handles.spectraStruct.name);
        [path name ext] = fileparts(strjoin(handles.spectraStruct.name(m)));
        nameCurrent = strcat(name,ext);
        if strcmpi(fileNames(i2),nameCurrent)
            spectra(:,i2) = handles.spectraStruct.spectra{m};
        end
    end
end

if subtractBackground == true
for i3 = 1:length(subtractNames)
    if length(handles.spectraStruct.name)==0
        error('Must add spectra to include files for analysis!');
    end
    for m2 = 1:length(handles.spectraStruct.name)
        [path2 name2 ext2] = fileparts(strjoin(handles.spectraStruct.name(m2)));
        nameCurrent2 = strcat(name2,ext2);
        if strcmpi(fileNames(i3),nameCurrent2)
            subtractSpectra(:,i3) = handles.spectraStruct.spectra{m2};
        end
    end
end
end

if subtractBackground == true
    data = spectra - subtractSpectra;
else
    data = spectra;
end

correctOffset = handles.correctOffset;
[dataTrun data crossoverPoints]   = AlignmentEPR(spectra,numSpectraPoints,correctOffset,stdStart,stdEnd,posDown,posUp);

if smoothBeforeFit == true;
    for z = 1 : numberOfDoses;
        for z2 = 1:timesSmoothPostCut
            dataTrun(:,z) = SmoothCorrect([1:length(dataTrun)],dataTrun(:,z),0.05,'lowess');
        end
    end
end
 
if strcmpi(fitType,'Original')
    fitType = 0;
else
    fitType = 1;
end
normalize = handles.normalize; 
normalizeValues = str2double(masses);
pointsToFit = handles.numFitPoints;
fitResults = DataFit(dataTrun,posDown+posUp,handles.basisSpectra.data,pointsToFit,fitType,fitStart,fitStop,normalize,normalizeValues);
for h = 1:length(fitResults)
    A = cell('');
    A(1,1:5) = {'Amplitudes','NormRSquared','Residual','Fit','FitTotal'};
    A(2:(2+length(fitResults(h).amplitudes))-1,1) = num2cell(fitResults(h).amplitudes);
    A(2:(2+length(fitResults(h).resNorm)-1),2) = num2cell(fitResults(h).resNorm);
    A(2:(2+size(fitResults(h).residual,1)-1),3:(3+size(fitResults(h).residual,2)-1)) = num2cell(fitResults(h).residual);
    currentCount = 3+size(fitResults(h).residual,2)-1;
    A(2:(2+size(fitResults(h).fitted,1)-1),(currentCount+1:(currentCount+size(fitResults(h).residual,2)))) = num2cell(fitResults(h).fitted);
    currentCount = currentCount+size(fitResults(h).residual,2);
    A(2:(2+length(fitResults(h).fittedTotal)-1),currentCount+1) = num2cell(fitResults(h).fittedTotal);
    finalCount = size(A,2);
    nums = (finalCount - 3)/2;
    A(1,1) = {'Amplitudes'};
    A(1,2) = {'NormRSquared'};
    A(1,3:3+nums-1) = {'Residual'};
    A(1,3+nums:(3+(2*nums)-1)) = {'Fit'};
    A(1,3+(2*nums)) = {'FitTotal'};
    savePath = handles.savePath;
    nameWrite = strcat(savePath,'\','results_',fileNames{h},'.xlsx');
    xlswrite(nameWrite,A);
end

if handles.plotFit == true
figure(3)
clf
for i=1:numberOfDoses
    subplot(ceil(numberOfDoses/3),3,i);
    plot(1:numFitPoints,dataTrun(fitStart:fitStop,i),'b','linewidth',2);
    set(gca, 'xTickLabel', num2str(get(gca,'xTick')','%g'))  %can use %E or %e as well or %.2g.
    hold on
    plot(1:numFitPoints,fitResults(i).fittedTotal,'r','linewidth',2);
end
Suptitle(strvcat('Fit to Spectra ',strcat('Doses:',strjoin(doses))));
% determine position of the axes:
axp = get(gca,'Position');
% determine startpoint and endpoint for the arrows:
xs = 0.07;
xe=axp(1)+axp(3);
ys = 0.05;
ye=axp(2)+axp(4);
% make the arrows:
annotation('arrow', [xs xe],[ys ys],'LineWidth',2);
annotation('arrow', [xs xs],[ys ye],'LineWidth',2);
ylabel('Signal Amplitude (AU)','color','k','FontSize',12);
xlabel('Magnetic Field (gauss)','color','k','FontSize',12);
end

% --- Executes on button press in smooth_button.
function smooth_button_Callback(hObject, eventdata, handles)
% hObject    handle to smooth_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if ~isfield(handles,'spectra')
    error('No Spectra Selected!');
end
for i = 1:size(handles.spectra,2)
    handles.spectra(:,i) = SmoothCorrect(handles.spectra(:,i));
end
plot(handles.spectra);
guidata(handles.figure1,handles);


% --- Executes on button press in line_fit_button.
function line_fit_button_Callback(hObject, eventdata, handles)
% hObject    handle to line_fit_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
evalString = 'line_fit_gui(handles)';
subgui_handle = eval(evalString);
subgui_data_handle = guidata(subgui_handle);
guidata(subgui_handle,subgui_data_handle); 


% --- Executes during object creation, after setting all properties.
function edit_doses_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_doses (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function uitable1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to uitable1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on button press in load_folder_button.
function load_folder_button_Callback(hObject, eventdata, handles)
% hObject    handle to load_folder_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.folderName = uigetdir('','Choose Folder to Load Files');
cd(handles.folderName);
folderList = ls;
folderList(1:2,:) = [];
handles.folderList = folderList;
guidata(hObject,handles);
initialDir = pwd;
LoadListbox(initialDir,handles);

%Load list box function. 
function LoadListbox(dirPath, handles)
cd(dirPath)
dirStruct = dir(dirPath);
[sortedNames,sortedIndex] = sortrows({dirStruct.name}');
sortedNames(1:2,:) = [];
sortedIndex(1:2,:) = [];
handles.dirPath = strcat(dirPath,'\');
handles.fileNames = sortedNames;
handles.isDir = [dirStruct.isdir];
handles.sortedIndex = sortedIndex;
handles.text1 = '';
set(handles.listbox1,'String',handles.fileNames,'Value',1);
set(handles.text1,'String',pwd);
guidata(handles.figure1,handles);

function FilterList(handles,chosenExt)
%[pathstr, name, ext] = fileparts(filename)
%disp(length(handles.fileNames));
fileNamesNew = handles.fileNames;
if strcmpi(chosenExt,'all')
    fileNamesOut = fileNamesNew;
else
    j=1;
    for i = 1:length(fileNamesNew)
        [pathstr, name, ext] = fileparts(fileNamesNew{i});
        if (strcmpi(ext,chosenExt))
            fileNamesOut{j} = strcat(name,chosenExt);
            j=j+1;
        end
    end
end
if ~exist('fileNamesOut','var')
    fileNamesOut = '';
end
set(handles.listbox1,'String',fileNamesOut);


function [fileName fileDir data information] = GetData(path,type,handles)
    [partPath,partName,partExt] = fileparts(path);
    if ~strcmpi(partExt,type)
        error('The Extensions do not Match!');
    end
    fileName = strcat(partName,partExt);
    type = lower(type);
    switch type
        case '.fls'
            spectrum = CenterraReadFLS(path,1);
            cd(partPath);
            fileDir = partPath;
            cellArray1 = spectrum.pars(:,1);
            for i=1:11
                informationNow{i} = strjoin([spectrum.pars(i,1),spectrum.pars(i,2)]);
            end
            information.parameters = informationNow';
            information.comment = spectrum.comment;
            data = spectrum.data;
        case '.par'
            [x,data,pars,fileName] = eprload(path);
            fieldNames = fieldnames(pars);
            fieldNames = fieldNames(:);
            for i=1:length(fieldNames)
                value = getfield(pars,strrep(mat2str(cell2mat(fieldNames(i))),'''',''));
                if isa(value,'numeric')
                    value = num2str(value);
                end
                informationNow{i} = strjoin([fieldNames(i),value]);
            end
            information.parameters = informationNow';
            information.comment = 'None';
            cd(partPath);
            fileDir = partPath;
        case '.spc'
            [x,data,pars,fileName] = eprload(path);
            fieldNames = fieldnames(pars);
            fieldNames = fieldNames(:);
            for i=1:length(fieldNames)
                value = getfield(pars,strrep(mat2str(cell2mat(fieldNames(i))),'''',''));
                if isa(value,'numeric')
                    value = num2str(value);
                end
                informationNow{i} = strjoin([fieldNames(i),value]);
            end
            information.parameters = informationNow';
            information.comment = 'None';
            cd(partPath);
            fileDir = partPath;
        case '.xlsx'
            [data,xtxt,xraw] = xlsread(path);
            information.parameters = xtxt;
            information.comment = 'None';
            cd(partPath);
            fileDir = partPath;
        case '.csv'
            data = csvread(path);
            cd(partPath);
            fileDir = partPath;
            information.parameters = 'None';
            information.comment = 'None';
    end


% --- Executes on selection change in listbox1.
function listbox1_Callback(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox1

%get(handles.figure1,'SelectionType');
% If double click
values = get(hObject,'String');
index = get(hObject,'Value');
if ~isfield(handles,'dirPath')
    error('No directory path has been selected!');
end
if isempty(values)
    set(hObject,'Value',1); % Add this line so that the list can be changed.
    eror('No files present!');
end
fullPath = strcat(handles.dirPath,values(index));
fullPath = fullPath{1};
[partPath,partName,partExt] = fileparts(fullPath);
szArrayAllowedExt = {'all','.fls','.par','.spc','.xlsx','.csv'};
for i=1:length(szArrayAllowedExt)
    found = false;
    if strcmpi(partExt,szArrayAllowedExt{i})
        if handles.subtract==true
            if ~isfield(handles,'spectra')
                handles.subtract=false;
                guidata(hObject,handles)
                error('You must choose a spectra before subtracting!');
            end
            [subfileName subfileDir subSpectra handles.spectraInformation] = GetData(fullPath,partExt,handles);
            if handles.average == true
                subSpectra = mean(subSpectra,2);
            end
            if ~all(size(handles.spectra)==size(subSpectra))
                handles.subtract=false;
                guidata(hObject,handles);
                error('Spectra must be same dimensions to subtract!');
            else
                handles.spectra = handles.spectra-subSpectra;
                handles.subtract=false;
                guidata(hObject,handles)
            end   
        else
            [handles.fileName, handles.fileDir, handles.spectra handles.spectraInformation] = GetData(fullPath,partExt,handles);
            if handles.average == true
                handles.spectra = mean(handles.spectra,2);
            end
        end
        if handles.multiPlot == true
        else
        cla;
        end
        if size(handles.spectra,2)==1
            randomColor = rand(1, 3);
            handles.plotNow = line(1:size(handles.spectra,1),handles.spectra,'color',randomColor);
        else
            handles.plotNow = line(1:size(handles.spectra,1),handles.spectra);
        end
        guidata(hObject,handles);
        found = true;
        break
    end
end
if found==false
    error('You must choose an appropriate file type!');
end
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function listbox1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function standard_start_edit_Callback(hObject, eventdata, handles)
% hObject    handle to standard_start_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of standard_start_edit as text
%        str2double(get(hObject,'String')) returns contents of standard_start_edit as a double
value = str2double(get(hObject,'String'));
if ~isa(value,'numeric') || isnan(value)
    error('Position up field must be a number!');
else
    handles.stdStart = value;
    guidata(hObject,handles);
end


% --- Executes during object creation, after setting all properties.
function standard_start_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to standard_start_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function pos_up_field_edit_Callback(hObject, eventdata, handles)
% hObject    handle to pos_up_field_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of pos_up_field_edit as text
%        str2double(get(hObject,'String')) returns contents of pos_up_field_edit as a double
value = str2double(get(hObject,'String'))
if ~isa(value,'numeric') || isnan(value)
    error('Position up field must be a number!');
else
handles.posUp = value;
guidata(hObject,handles);
end


% --- Executes during object creation, after setting all properties.
function pos_up_field_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pos_up_field_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in subtract_spectra_button.
function subtract_spectra_button_Callback(hObject, eventdata, handles)
% hObject    handle to subtract_spectra_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if ~isfield(handles,'spectra')||isempty(handles.spectra)
    error('Much choose spectra from which to subtract!');
    handles.subtract = false;
else
    handles.subtract = true;
end
guidata(hObject,handles);


% --- Executes on button press in add_spectra_button.
function add_spectra_button_Callback(hObject, eventdata, handles)
% hObject    handle to add_spectra_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
lengthStruct = length(handles.spectraStruct.name);
if lengthStruct > 1
    for i=1:lengthStruct
        name = handles.spectraStruct.name{i};
        if strcmpi(name,handles.fileName)==1
            error('Spectra cannot have the same names!');
        end
    end
end
handles.spectraStruct.name{lengthStruct+1} = handles.fileName;
handles.spectraStruct.path{lengthStruct+1} = handles.fileDir;
handles.spectraStruct.spectra{lengthStruct+1} = handles.spectra;
guidata(hObject,handles);


% --- Executes on button press in average_spectra_check_box.
function average_spectra_check_box_Callback(hObject, eventdata, handles)
% hObject    handle to average_spectra_check_box (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of average_spectra_check_box
handles.average=get(hObject,'Value');
guidata(hObject,handles);


% --- Executes on button press in plot_together_check_box.
function plot_together_check_box_Callback(hObject, eventdata, handles)
% hObject    handle to plot_together_check_box (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of plot_together_check_box
handles.multiPlot=get(hObject,'Value');
guidata(hObject,handles);


% --- Executes on button press in clear_button.
function clear_button_Callback(hObject, eventdata, handles)
% hObject    handle to clear_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.spectraStruct = struct('name',[],'path',[],'spectra',[]);
cla;
guidata(hObject,handles);


function edit_doses_Callback(hObject, eventdata, handles)
% hObject    handle to edit_doses (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_doses as text
%        str2double(get(hObject,'String')) returns contents of edit_doses as a double


function edit_remove_dose_Callback(hObject, eventdata, handles)
% hObject    handle to edit_remove_dose (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_remove_dose as text
%        str2double(get(hObject,'String')) returns contents of edit_remove_dose as a double


% --- Executes during object creation, after setting all properties.
function edit_remove_dose_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_remove_dose (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in edit_doses_button.
function edit_doses_button_Callback(hObject, eventdata, handles)
% hObject    handle to edit_doses_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% handles    structure with handles and user data (see GUIDATA)
    getValue = get(handles.edit_doses,'String');
    getValueNum = (str2double(getValue));
    if ~isa(getValueNum,'numeric') || isnan(getValueNum)
        error('Doses to plot must be a number!');
    elseif getValueNum == 0.0
        numArray={''};
        set(handles.uitable1,'RowName',numArray);
        numDoses = handles.currentDoses;
        error('Doses to plot must be greater than 0!');
    elseif getValueNum > 99
        numDoses = handles.currentDoses;
        error('Doses to plot must be less than 100!');
    elseif getValueNum > handles.currentDoses
        addDoses = getValueNum - handles.currentDoses;
        numDoses = handles.currentDoses + addDoses;
        oldData = get(handles.uitable1,'Data');
        addData = cell(addDoses,4);
        addData(:) = {''};
        newData = [oldData;addData];
     elseif getValueNum < handles.currentDoses
        subDoses = handles.currentDoses - getValueNum;
        numDoses = handles.currentDoses - subDoses;
        oldData = get(handles.uitable1,'Data');
        nRows = size(oldData,1);
        newData = oldData;
        newData((nRows-subDoses)+1:nRows,:) = [];
    elseif getValueNum == handles.currentDoses
        numDoses = handles.currentDoses;
        newData = get(handles.uitable1,'Data');
    end
    set(handles.uitable1,'RowName',{1:numDoses});
    set(handles.uitable1,'Data',newData);
    trueArray=true(1,4);
    set(handles.uitable1,'ColumnEditable',trueArray);
    handles.currentDoses = getValueNum;
    guidata(hObject,handles);

        
% --- Executes on button press in remove_doses_button.
function remove_doses_button_Callback(hObject, eventdata, handles)
% hObject    handle to remove_doses_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    getValue = get(handles.edit_doses,'String');
    getValueNum = (str2double(getValue));
    if getValueNum <= 1
        error('Must have more than one dose to remove!');
    end
    getValueRemove = get(handles.edit_remove_dose,'String');
    getValueRemoveNum = (str2double(getValueRemove));
    data = get(handles.uitable1,'Data');
    dataBefore = data(1:getValueRemoveNum-1,:);
    dataAfter = data(getValueRemoveNum+1:handles.currentDoses,:);
    dataNow = [dataBefore;dataAfter];
    set(handles.uitable1,'RowName',{1:getValueNum-1});
    set(handles.uitable1,'Data',dataNow);
    handles.currentDoses = getValueNum-1;
    set(handles.edit_doses,'String',handles.currentDoses);
    trueArray=true(1,handles.currentDoses);
    set(handles.uitable1,'ColumnEditable',trueArray);
    guidata(hObject,handles);

    
% --- Executes on button press in open_figure_button.
function open_figure_button_Callback(hObject, eventdata, handles)
% hObject    handle to open_figure_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%figure(2);
%set(get(gca));
handles.figure2 = figure(2);
clf
copyobj(handles.axes1,handles.figure2);


function edit_insert_dose_Callback(hObject, eventdata, handles)
% hObject    handle to edit_insert_dose (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_insert_dose as text
%        str2double(get(hObject,'String')) returns contents of edit_insert_dose as a double


% --- Executes during object creation, after setting all properties.
function edit_insert_dose_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_insert_dose (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in insert_doses_button.
function insert_doses_button_Callback(hObject, eventdata, handles)
% hObject    handle to insert_doses_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    getValue = get(handles.edit_doses,'String');
    getValueNum = (str2double(getValue));
    if getValueNum >= 99
        error('Maximum number of doses is 99!');
    end
    getValueInsert = get(handles.edit_insert_dose,'String');
    getValueInsertNum = (str2double(getValueInsert));
    if getValueInsertNum == handles.currentDoses
        error('Just increase number of doses to plot by one!');
    end
    data = get(handles.uitable1,'Data');
    dataBefore = data(1:getValueInsertNum-1,:);
    dataAfter = data(getValueInsertNum:handles.currentDoses,:);
    dataInsert = cell(1,4);
    dataInsert(:) = {''};
    dataNow = [dataBefore;dataInsert;dataAfter];
    set(handles.uitable1,'RowName',{1:getValueNum+1});
    set(handles.uitable1,'Data',dataNow);
    set(handles.edit_doses,'String',num2str(getValueNum+1));
    handles.currentDoses = getValueNum+1;
    trueArray=true(1,handles.currentDoses);
    set(handles.uitable1,'ColumnEditable',trueArray);
    guidata(hObject,handles);
    
    
% --- Executes on button press in filter_files_button.
function filter_files_button_Callback(hObject, eventdata, handles)
% hObject    handle to filter_files_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
extNum = get(handles.file_type_popupmenu,'Value');
extList = get(handles.file_type_popupmenu,'String');
ext = extList{extNum};
FilterList(handles,ext);


function number_spectra_points_edit_Callback(hObject, eventdata, handles)
% hObject    handle to number_spectra_points_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of number_spectra_points_edit as text
%        str2double(get(hObject,'String')) returns contents of number_spectra_points_edit as a double
value = str2double(get(hObject,'String'));
if ~isa(value,'numeric') || isnan(value)
    error('Number of spectra points must be a number!');
else
    handles.numberSpectraPoints = value;
    guidata(hObject,handles);
end


% --- Executes during object creation, after setting all properties.
function number_spectra_points_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to number_spectra_points_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function number_points_fit_edit_Callback(hObject, eventdata, handles)
% hObject    handle to number_points_fit_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of number_points_fit_edit as text
%        str2double(get(hObject,'String')) returns contents of number_points_fit_edit as a double
value = str2double(get(hObject,'String'));
if ~isa(value,'numeric') || isnan(value)
    error('Number fit points must be a number!');
else
handles.numFitPoints = value;
guidata(hObject,handles);
end


% --- Executes during object creation, after setting all properties.
function number_points_fit_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to number_points_fit_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function position_down_edit_Callback(hObject, eventdata, handles)
% hObject    handle to position_down_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of position_down_edit as text
%        str2double(get(hObject,'String')) returns contents of position_down_edit as a double
value = str2double(get(hObject,'String'));
if ~isa(value,'numeric') || isnan(value)
    error('Position down must be a number!');
else
    handles.posDown = value;
    guidata(hObject,handles);
end

% --- Executes during object creation, after setting all properties.
function position_down_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to position_down_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function position_up_edit_Callback(hObject, eventdata, handles)
% hObject    handle to position_up_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of position_up_edit as text
%        str2double(get(hObject,'String')) returns contents of position_up_edit as a double
value = str2double(get(hObject,'String'));
if ~isa(value,'numeric') || isnan(value)
    error('Position up field must be a number!');
else
    handles.posUp = value;
    guidata(hObject,handles);
end


% --- Executes during object creation, after setting all properties.
function position_up_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to position_up_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in fit_type_popupmenu.
function fit_type_popupmenu_Callback(hObject, eventdata, handles)
% hObject    handle to fit_type_popupmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns fit_type_popupmenu contents as cell array
%        contents{get(hObject,'Value')} returns selected item from fit_type_popupmenu
fitTypeContent = cellstr(get(hObject,'String'));
handles.fitType = fitTypeContent{get(hObject,'Value')};
guidata(hObject,handles);


% --- Executes during object creation, after setting all properties.
function fit_type_popupmenu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to fit_type_popupmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in basis_spectra_button.
function basis_spectra_button_Callback(hObject, eventdata, handles)
% hObject    handle to basis_spectra_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[fileName,pathName] = uigetfile('','Choose basis spectra file');
nameString = strcat(pathName,fileName);
[pathstr,name,ext] = fileparts(nameString);
if strcmpi(ext,'.xlsx') 
    [num,txt,raw] = xlsread(nameString);
    basisSpectra.names = txt;
    basisSpectra.data = num;
else
    error('Basis spetcra file must be an excel ''.xlsx'' file!');
end
handles.basisSpectra = basisSpectra;
set(handles.basis_spectra_edit,'String',nameString);
guidata(hObject,handles);


% --- Executes on button press in correct_offset_checkbox.
function correct_offset_checkbox_Callback(hObject, eventdata, handles)
% hObject    handle to correct_offset_checkbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of correct_offset_checkbox
handles.correctOffset = get(hObject,'Value');
guidata(hObject,handles);

% --- Executes on button press in plot_fitting_checkbox.
function plot_fitting_checkbox_Callback(hObject, eventdata, handles)
% hObject    handle to plot_fitting_checkbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of plot_fitting_checkbox
handles.plotFit = get(hObject,'Value');
guidata(hObject,handles);

function edit_output_Callback(hObject, eventdata, handles)
% hObject    handle to edit_output (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_output as text
%        str2double(get(hObject,'String')) returns contents of edit_output as a double


% --- Executes during object creation, after setting all properties.
function edit_output_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_output (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes when entered data in editable cell(s) in uitable1.
function uitable1_CellEditCallback(hObject, eventdata, handles)
% hObject    handle to uitable1 (see GCBO)
% eventdata  structure with the following fields (see UITABLE)
%	Indices: row and column indices of the cell(s) edited
%	PreviousData: previous data for the cell(s) edited
%	EditData: string(s) entered by the user
%	NewData: EditData or its converted form set on the Data property. Empty if Data was not changed
%	Error: error string when failed to convert EditData to appropriate value for Data
% handles    structure with handles and user data (see GUIDATA)


function standard_end_edit_Callback(hObject, eventdata, handles)
% hObject    handle to standard_end_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of standard_end_edit as text
%        str2double(get(hObject,'String')) returns contents of standard_end_edit as a double
value = str2double(get(hObject,'String'));
if ~isa(value,'numeric') || isnan(value)
    error('Standard end must be a number!');
else
handles.stdEnd = value;
guidata(hObject,handles);
end


% --- Executes during object creation, after setting all properties.
function standard_end_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to standard_end_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in list_spectra_button.
function list_spectra_button_Callback(hObject, eventdata, handles)
% hObject    handle to list_spectra_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if isempty(handles.spectraStruct.name)
    error('No spectra have been added!');
else
    for i = 1:length(handles.spectraStruct.name)
        [pathstr, name, ext] = fileparts(handles.spectraStruct.name{i});
        nameFile{i,:} = strcat(name,ext);
end
    set(handles.edit_output,'String',['Added Spectra:';nameFile]);
    guidata(hObject,handles);
end


function basis_spectra_edit_Callback(hObject, eventdata, handles)
% hObject    handle to basis_spectra_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of basis_spectra_edit as text
%        str2double(get(hObject,'String')) returns contents of basis_spectra_edit as a double


% --- Executes during object creation, after setting all properties.
function basis_spectra_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to basis_spectra_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on key press with focus on edit_doses and none of its controls.
function edit_doses_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_doses (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in load_info_button.
function load_info_button_Callback(hObject, eventdata, handles)
% hObject    handle to load_info_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.edit_output,'String',['SPECTRA INFORMATION:';handles.spectraInformation.parameters;char(10);'SPECTRA COMMENTS';handles.spectraInformation.comment])
guidata(hObject,handles);


% --- Executes on button press in clear_terminal_button.
function clear_terminal_button_Callback(hObject, eventdata, handles)
% hObject    handle to clear_terminal_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.edit_output,'String','');
guidata(hObject,handles);


% --- Executes on button press in smooth_fit_checkbox.
function smooth_fit_checkbox_Callback(hObject, eventdata, handles)
% hObject    handle to smooth_fit_checkbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of smooth_fit_checkbox
handles.smoothFit = get(hObject,'Value');
guidata(hObject,handles);


function smooth_before_fit_edit_Callback(hObject, eventdata, handles)
% hObject    handle to smooth_before_fit_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of smooth_before_fit_edit as text
%        str2double(get(hObject,'String')) returns contents of smooth_before_fit_edit as a double
value = str2double(get(hObject,'String'));
if ~isa(value,'numeric') || isnan(value)
    error('Times to smooth must be a number!');
else
handles.timesSmoothBeforeFit = value;
guidata(hObject,handles)
end

% --- Executes during object creation, after setting all properties.
function smooth_before_fit_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to smooth_before_fit_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in subtract_procedure_checkbox.
function subtract_procedure_checkbox_Callback(hObject, eventdata, handles)
% hObject    handle to subtract_procedure_checkbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of subtract_procedure_checkbox
handles.subtractBackground = get(hObject,'Value');
guidata(hObject,handles);


% --- Executes on button press in save_path_button.
function save_path_button_Callback(hObject, eventdata, handles)
% hObject    handle to save_path_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.savePath = uigetdir();
set(handles.edit_output,'String',strvcat('Save Path:',handles.savePath));
guidata(hObject,handles);



function truncate_low_edit_Callback(hObject, eventdata, handles)
% hObject    handle to truncate_low_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of truncate_low_edit as text
%        str2double(get(hObject,'String')) returns contents of truncate_low_edit as a double
value = str2double(get(hObject,'String'));
if ~isa(value,'numeric') || isnan(value)
    error('Truncate values smooth must be a number!');
else
handles.truncateLow = value;
guidata(hObject,handles)
end


% --- Executes during object creation, after setting all properties.
function truncate_low_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to truncate_low_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function truncate_high_edit_Callback(hObject, eventdata, handles)
% hObject    handle to truncate_high_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of truncate_high_edit as text
%        str2double(get(hObject,'String')) returns contents of truncate_high_edit as a double
value = str2double(get(hObject,'String'));
if ~isa(value,'numeric') || isnan(value)
    error('Truncate values smooth must be a number!');
else
handles.truncateHigh = value;
guidata(hObject,handles)
end


% --- Executes during object creation, after setting all properties.
function truncate_high_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to truncate_high_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in truncate_button.
function truncate_button_Callback(hObject, eventdata, handles)
% hObject    handle to truncate_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if ~isfield(handles,'spectra') || ~isfield(handles,'truncateLow') || ~isfield(handles,'truncateHigh')
    error('Must choose a spectra and set truncation points !');
else
    handles.spectraTrun = [];
    for i = 1:size(handles.spectra,2)
    handles.spectraTrun(:,i) = handles.spectra(handles.truncateLow:handles.truncateHigh,i);
    end
plot(handles.spectraTrun);
handles.spectra = handles.spectraTrun;
guidata(handles.figure1,handles);
end


% --- Executes on button press in normalize_checkbox.
function normalize_checkbox_Callback(hObject, eventdata, handles)
% hObject    handle to normalize_checkbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of normalize_checkbox
handles.normalize = get(hObject,'Value');
guidata(hObject,handles);
