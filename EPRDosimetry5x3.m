function varargout = NailDosimetry5x1(varargin)
% NAILDOSIMETRY5X1 MATLAB code for NailDosimetry5x1.fig
%      NAILDOSIMETRY5X1, by itself, creates a new NAILDOSIMETRY5X1 or raises the existing
%      singleton*.
%
%      H = NAILDOSIMETRY5X1 returns the handle to a new NAILDOSIMETRY5X1 or the handle to
%      the existing singleton*.
%
%      NAILDOSIMETRY5X1('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in NAILDOSIMETRY5X1.M with the given input arguments.
%
%      NAILDOSIMETRY5X1('Property','Value',...) creates a new NAILDOSIMETRY5X1 or raises
%      the existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before NailDosimetry5x1_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property
%      application
%      stop.  All inputs are passed to NailDosimetry5x1_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help NailDosimetry5x1

% Last Modified by GUIDE v2.5 03-Jun-2015 09:38:18

% Update handles structure
hObject = figure(1);
handles.figure1 = gcf;
handles.currentSpectra = struct('spectra',[],'spectraInformation',[],'fileName',[],'fileDir',[],'color',[]);
handles.spectraBaseline = [];
handles.numSpectraPoints = [];
handles.numFitPoints = [];
handles.search_start = [];
handles.search_stop = [];
handles.subtract = false;
handles.average = false;
handles.multiPlot = false;
handles.currentDoses = 0;
handles.basisSpectra = [];
handles.savedSpectra = struct('spectra',[],'spectraInformation',[],'fileName',[],'fileDir',[],'color',[]);
handles.smoothFit = false;
handles.timesSmoothBeforeFit = 0;
handles.correctOffset = false;
handles.subtractBackground = 'false';
handles.totalMass = 0;
handles.fieldCenter = [];
handles.fieldWidth = [];
handles.plotFit = false;
handles.normalize = false;
handles.baselineStart = [];
handles.baselineStop = [];
handles.smoothType = 'boxcar';
handles.smoothSpan = [];
handles.viewSavedSpectra = false;
handles.plot3 = false;
handles.listSpectra = struct('name',[],'color',[]);
handles.folderList = [];
guidata(hObject, handles);

initialize_gui(hObject, handles, false);

% UIWAIT makes NailDosimetry5x1 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = NailDosimetry5x1_OutputFcn(hObject, eventdata, handles)
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
clf;
mTextBox = uicontrol('style','text');
set(mTextBox,'String','System Error! Code:0001','FontSize',30,'ForegroundColor','red');
set(mTextBox,'Position',[200,200,300,150]);
guidata(handles.figure1, handles);


function fit_start_edit_Callback(hObject, eventdata, handles)
% hObject    handle to search_start_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of search_start_edit as text
%        str2double(get(hObject,'String')) returns contents of search_start_edit as a double
value = str2double(get(hObject,'String'));
if ~isa(value,'numeric') || isnan(value)
    error('Fit stop point must be a number!');
else
    handles.fitStart = value;
    guidata(hObject,handles);
end


% --- Executes during object creation, after setting all properties.
function fit_start_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to search_start_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function search_stop_edit_Callback(hObject, eventdata, handles)
% hObject    handle to search_stop_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of search_stop_edit as text
%        str2double(get(hObject,'String')) returns contents of search_stop_edit as a double
value = str2double(get(hObject,'String'));
if ~isa(value,'numeric') || isnan(value)
    error('Fit stop point must be a number!');
else
    handles.search_stop = value;
    guidata(hObject,handles);
end


% --- Executes during object creation, after setting all properties.
function search_stop_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to search_stop_edit (see GCBO)
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


% --- Executes on button press in smooth_button.
function smooth_button_Callback(hObject, eventdata, handles)
% hObject    handle to smooth_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
cla;
if ~isfield(handles.currentSpectra(1),'spectra')
    error('No spectra selected!');
end
if strcmpi(handles.smoothType,'lowess')
    smoothType = 'lowess';
elseif strcmpi(handles.smoothType,'boxcar')
    smoothType = 'moving';
else
    error('You must choose an appropriate smooth type!');
end
if isempty(handles.smoothSpan)
    error('You must choose a smoothing window value!');
end

for i = 1:length(handles.currentSpectra)
    spectraY = handles.currentSpectra(i).spectra(:,2);
    smoothY = SmoothCorrect(spectraY,handles.smoothSpan,smoothType);
    spectra(:,2) = smoothY;
    spectra(:,1) = [1:length(spectra(:,2))];
    handles.currentSpectra(i).spectra = [spectra(:,1),spectra(:,2)];
    line(1:length(handles.currentSpectra(i).spectra(:,2)),handles.currentSpectra(i).spectra(:,2),'color',handles.currentSpectra(i).color);
    hold on
end
if isfield(handles,'lineLeftClick')
    handles = rmfield(handles, 'lineLeftClick');
end
if isfield(handles,'lineRightClick')
    handles = rmfield(handles, 'lineRightClick');
end
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


% --- Executes on button press in load_folder_button.
function load_folder_button_Callback(hObject, eventdata, handles)
% hObject    handle to load_folder_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.viewSavedSpectra = false;
handles.folderName = uigetdir('','Choose Folder to Load Files');
cd(handles.folderName);
folderList = ls;
folderList(1:2,:) = [];
handles.folderList = folderList;
guidata(hObject,handles);
initialDir = pwd;
LoadListbox(initialDir,handles,hObject);


%Load list box function. 
function LoadListbox(dirPath, handles, hObject)
cd(dirPath)
dirStruct = dir(dirPath);
[sortedNames,sortedIndex] = sortrows({dirStruct.name}');
sortedNames(1:2,:) = [];
sortedIndex(1:2,:) = [];
fullNames = strcat(dirPath,'\',sortedNames);
handles.dirPath = strcat(dirPath,'\');
handles.fileNames = sortedNames;
handles.isDir = [dirStruct.isdir];
handles.sortedIndex = sortedIndex;
handles.text1 = '';
set(handles.listbox1,'String',handles.fileNames,'Value',1);
set(handles.text1,'String',pwd);
guidata(handles.figure1,handles);

contents = cellstr(get(handles.listbox1,'String'));
hex = dec2hex([ 0 0 1], 7);
hexColor = hex(1);
for i = 1:numel(contents)
    newText = contents{i}; 
    rgb = floor(rand(1,3) * 255);
    color8hex = sprintf('#%02X%02X%02X',rgb);
    colors{i} = color8hex;
    newColor = sprintf('<HTML><font color="%s">%s</font></HTML>',color8hex,newText);
    namestr{i} = newColor; 
end
for j = 1:numel(handles.fileNames)
    handles.listSpectra(j).name = fullNames{j};
    handles.listSpectra(j).color = colors{j};
end
set(handles.listbox1, 'String', namestr);
guidata(hObject,handles);

function FilterList(handles,chosenExt,hObject)
fileNamesNew = handles.listSpectra;
j=1;
    for i = 1:numel(fileNamesNew)
        if strcmpi(chosenExt,'all')
            namestr{i} = handles.folderList(i,:);
        else
            [pathstr, name, ext] = fileparts(fileNamesNew(i).name);
            if (strcmpi(ext,chosenExt))
                fileNamesOut{j} = strcat(name,chosenExt);
                listSpectraNew(j).name = fileNamesNew(i).name;
                listSpectraNew(j).color = handles.listSpectra(j).color;
                newText = fileNamesOut{j};
                color8hex = listSpectraNew(j).color;
                newColor = sprintf('<HTML><font color="%s">%s</font></HTML>',color8hex,newText);
                namestr{j} = newColor; 
                j=j+1;
            end
        end
    end
if ~exist('fileNamesOut','var')
    namestr = '';
end
handles.listSpectra = listSpectraNew;
set(handles.listbox1,'String',namestr);
guidata(hObject,handles);

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
viewSavedSpectra = handles.viewSavedSpectra;
if viewSavedSpectra == true
    path = strcat(handles.spectraStruct.path(index),'\',values(index));
else
    path = handles.listSpectra(index).name;
end
[partPath,partName,partExt] = fileparts(path);
selectedName = strcat(partName,partExt);
szArrayAllowedExt = {'all','.fls','.par','.spc','.xlsx','.csv'};
for i=1:length(szArrayAllowedExt)
    found = false;
    if strcmpi(partExt,szArrayAllowedExt{i})
        if ~isempty(handles.currentSpectra(1).fileName)
            for nameIndex = 1:numel(handles.currentSpectra)
                [currentPath,currentName,currentExt] = fileparts(handles.currentSpectra(nameIndex).fileName);
                compareName = strcat(currentName,currentExt);
                if strcmpi(selectedName,compareName) 
                    return
                end
            end
        end
        currentColorHex = handles.listSpectra(index).color;
        currentColorHex = regexprep(currentColorHex,'#','');
        dec1 = hex2dec(currentColorHex(1:2))/255;
        dec2 = hex2dec(currentColorHex(3:4))/255;
        dec3 = hex2dec(currentColorHex(5:6))/255;
        currentColor = [dec1 dec2 dec3];
            if handles.subtract==true
                if ~isfield(handles,'spectra')
                    handles.subtract=false;
                    guidata(hObject,handles)
                    error('You must choose a spectra before subtracting!');
                end
                if viewSavedSpectra == true
                    subSpectra(:,2) = handles.spectraStruct.data(index);
                    subSpectra(:,1) = [1:length(subSpectra(:,2))];
                else
                    [subfileName subfileDir subSpectra(:,2) handles.spectraInformation] = GetData(path,partExt,handles);
                    subSpectra(:,1) = [1:length(subSPectra(:,2))];
                end
                if handles.average == true
                    subSpectra(:,2) = mean(subSpectra,2);
                    subSpectra(:,1) = [1:length(subSpectra(:,2))];
                end
                if ~all(size(handles.spectra)==size(subSpectra))
                    handles.subtract=false;
                    guidata(hObject,handles);
                    error('Spectra must be same dimensions to subtract!');
                else
                    subSpectra = handles.spectra-subSpectra;
                    handles.subtract=false;
                    guidata(hObject,handles)
                end   
            else
                if viewSavedSpectra == true
                    subSpectra(:,2) = handles.spectraStruct.spectra(:,index);
                    subSPectra(:,1) = [1:length(subSpectra(:,2))];
                    handles.currentSpectra.spectra = [subSpectra(:,1),subSpectra(:,2)];
                else
                    [fileName, fileDir, spectraData, spectraInformation] = GetData(path,partExt,handles);
                    subSpectra(:,2) = spectraData;
                    subSpectra(:,1) = [1:length(subSpectra(:,2))];
                    if handles.multiPlot == true
                        if isempty(handles.currentSpectra(1).spectra)
                            handles.currentSpectra(1).fileName = fileName;
                            handles.currentSpectra(1).fileDir = fileDir;
                            handles.currentStructure(1).spectraInformation = spectraInformation;
                            handles.currentSpectra(1).spectra = subSpectra;
                            handles.currentSpectra(1).color = currentColor;
                            guidata(hObject,handles);
                        else
                            structSize = numel(handles.currentSpectra);
                            handles.currentSpectra(structSize+1).fileName = fileName;
                            handles.currentSpectra(structSize+1).fileDir = fileDir;
                            handles.currentStructure(structSize+1).spectraInformation = spectraInformation;
                            handles.currentSpectra(structSize+1).spectra = subSpectra;
                            handles.currentSpectra(structSize+1).color = currentColor;
                            guidata(hObject,handles);
                        end
                    else
                        handles.currentSpectra = struct('spectra',[],'spectraInformation',[],'fileName',[],'fileDir',[]);
                        handles.currentSpectra(1).fileName = fileName;
                        handles.currentSpectra(1).fileDir = fileDir;
                        handles.currentSpectra(1).spectraInformation = spectraInformation;
                        handles.currentSpectra(1).spectra = subSpectra;
                        handles.currentSpectra(1).color = currentColor;
                        guidata(hObject,handles);
                     end
                end
             end
             if handles.average == true
                handles.spectra = mean(handles.spectra,2);
             end
            if viewSavedSpectra == true
                handles.plotNow = line(subSpectra(:,1),subSpectra(:,2),'color',currentColor);
            else
                if handles.multiPlot == true
                    if length(handles.currentSpectra)==1;
                        handles.plotNow = line(handles.currentSpectra(1).spectra(:,1),handles.currentSpectra(1).spectra(:,2),'color',handles.currentSpectra(1).color);
                    else
                        z = 0;
                        for z = 1:numel(handles.currentSpectra)
                            handles.plotNow = line(handles.currentSpectra(z).spectra(:,1),handles.currentSpectra(z).spectra(:,2),'color',handles.currentSpectra(z).color);
                            hold on
                        end
                    end
            else
            cla;
            handles.plotNow = line(handles.currentSpectra(1).spectra(:,1),handles.currentSpectra(1).spectra(:,2),'color',currentColor);
            end
            end            
        guidata(hObject,handles);
        found = true;
    break
    end
end
if found==false
    error('You must choose an appropriate file type!');
end
if isfield(handles,'lineLeftClick')
    handles = rmfield(handles, 'lineLeftClick');
end
if isfield(handles,'lineRightClick')
    handles = rmfield(handles, 'lineRightClick');
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


function search_start_edit_Callback(hObject, eventdata, handles)
% hObject    handle to search_start_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of search_start_edit as text
%        str2double(get(hObject,'String')) returns contents of search_start_edit as a double
value = str2double(get(hObject,'String'));
if ~isa(value,'numeric') || isnan(value)
    error('Position up field must be a number!');
else;
    handles.search_start = value;
    guidata(hObject,handles);
end



% --- Executes during object creation, after setting all properties.
function search_start_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to search_start_edit (see GCBO)
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

%{
if isempty(handles.currentSpectra)
    error('No spectra have been added!');
end
%}
stringCurrent = get(handles.listbox1,'String');
lengthStruct = length(handles.savedSpectra);
if lengthStruct == 1 &&  isempty(handles.savedSpectra.spectra)
    handles.savedSpectra(1).fileName = handles.currentSpectra.fileName;
    handles.savedSpectra(1).filePath = handles.currentSpectra.fileDir;
    handles.savedSpectra(1).spectra = handles.currentSpectra.spectra;
     handles.savedSpectra(1).color = handles.currentSpectra.color;
else
    for i=1:length(handles.listSpectra)
        name = handles.savedSpectra(i).fileName;
        if strcmpi(name,handles.listSpectra(i).name)==1
            error('Spectra cannot have the same names!');
        end
    end
    handles.savedSpectra(lengthStruct+1).fileName = handles.fileName;
    handles.savedSpectra(lengthStruct+1).fileDir = handles.fileDir;
    handles.savedSpectra(lengthStruct+1).spectra = handles.spectra;
end
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


% --- Executes on button press in clear_spectra_button.
function clear_spectra_button_Callback(hObject, eventdata, handles)
% hObject    handle to clear_spectra_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.spectraStruct = struct('name',[],'path',[],'spectra',[]);
handles.spectra = [];
handles.spectraBaseline = [];
handles.spectraTrun = [];
handles.spectraInformation = [];
handles.numSpectraPoints = [];
handles.subtract = false;
handles.fileName = [];
handles.fileDir = [];
handles.correctOffset = false;
handles.subtractBackground = 'false';
if handles.viewSavedSpectra == true
    set(handles.listbox1,'String','');
end
handles.viewSavedSpectra = false;
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


% --- Executes on button press in filter_files_button.
function filter_files_button_Callback(hObject, eventdata, handles)
% hObject    handle to filter_files_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
extNum = get(handles.file_type_popupmenu,'Value');
extList = get(handles.file_type_popupmenu,'String');
ext = extList{extNum};
FilterList(handles,ext,hObject);


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


% --- Executes on selection change in smooth_type_popupmenu.
function fit_type_popupmenu_Callback(hObject, eventdata, handles)
% hObject    handle to smooth_type_popupmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns smooth_type_popupmenu contents as cell array
%        contents{get(hObject,'Value')} returns selected item from smooth_type_popupmenu
fitTypeContent = cellstr(get(hObject,'String'));
handles.fitType = fitTypeContent{get(hObject,'Value')};
guidata(hObject,handles);


% --- Executes during object creation, after setting all properties.
function fit_type_popupmenu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to smooth_type_popupmenu (see GCBO)
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


function search_end_edit_Callback(hObject, eventdata, handles)
% hObject    handle to search_end_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of search_end_edit as text
%        str2double(get(hObject,'String')) returns contents of search_end_edit as a double
value = str2double(get(hObject,'String'));
if ~isa(value,'numeric') || isnan(value)
    error('Standard end must be a number!');
else
handles.stdEnd = value;
guidata(hObject,handles);
end


% --- Executes during object creation, after setting all properties.
function search_end_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to search_end_edit (see GCBO)
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
if isempty(handles.spectraStruct)
    error('No spectra have been added!');
else
    set(handles.edit_output,'String',[handles.folderList],'Foreground',[0 0 1]);
    %{
    for i = 1:length(handles.spectraStruct)
        [pathstr, name, ext] = fileparts(handles.spectraStruct(i).name);
        nameFile{i,:} = strcat(name,ext);
    end
    handles.viewSavedSpectra = true;
    set(handles.edit_output,'String',['Added Spectra:';nameFile],'Foreground',[0 0 1]);
    guidata(hObject,handles);
    set(handles.listbox1,'String',nameFile,'Value',size(nameFile,1),'Foreground',[0 0 1]);
    guidata(hObject,handles);
    %}
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
set(handles.edit_output,'ForegroundColor','black');
for i = 1:numel(handles.currentSpectra)
    set(handles.edit_output,'String',['SPECTRA NAME:';handles.currentSpectra(i).fileName;...
        'SPECTRA INFORMATION:';handles.currentSpectra(i).spectraInformation.parameters;char(10);...
        'SPECTRA COMMENTS';handles.currentSpectra(i).spectraInformation.comment]);
end
guidata(hObject,handles);


% --- Executes on button press in clear_terminal_button.
function clear_terminal_button_Callback(hObject, eventdata, handles)
% hObject    handle to clear_terminal_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.edit_output,'String','');
guidata(hObject,handles);


% --- Executes on button press in save_path_button.
function save_path_button_Callback(hObject, eventdata, handles)
% hObject    handle to save_path_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.savePath = uigetdir();
set(handles.edit_output,'String',strvcat('Save Path:',handles.savePath));
guidata(hObject,handles);


% --- Executes on button press in truncate_button.
function truncate_button_Callback(hObject, eventdata, handles)
% hObject    handle to truncate_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if(get(handles.use_line_check_box,'Value')==0)
    if isempty(handles.search_stop || handles.search_start)
        error('Use lines to specify truncation region!');
    else
        truncateLow = handles.search_start;                    
        truncateHigh = handles.search_end;
    end
else
    api = iptgetapi(handles.lineLeftClick);
    posLeft = api.getPosition();
    api = iptgetapi(handles.lineRightClick);
    posRight = api.getPosition();
    posLeft = posLeft(:,1);
    posLeft = posLeft(1);
    posRight = posRight(:,1);
    posRight = posRight(1); 
    if posLeft > posRight
        posLeftNew = posRight;
        posRightNew = posLeft;
        truncateLow = posLeftNew;
        truncateHigh = posRightNew;
    else
        truncateLow = posLeft;
        truncateHigh = posRight;
    end
end
if isempty(handles.currentSpectra(1).spectra)
    error('You must choose a spectra and set truncation points!');
elseif truncateHigh-truncateLow + 1 > length(handles.currentSpectra(1).spectra(:,2))
    error('Truncation out of range!');
else
    cla;
    for i = 1:length(handles.currentSpectra)
        spectra = handles.currentSpectra(i).spectra;
        handles.currentSpectra(i).spectra = zeros(length(spectra(truncateLow:truncateHigh,2)),2);
        handles.currentSpectra(i).spectra(:,2) = spectra(truncateLow:truncateHigh,2);
        handles.currentSpectra(i).spectra(:,1) = 1:length(handles.currentSpectra(i).spectra(:,2));
        line(1:length(handles.currentSpectra(i).spectra(:,1)),handles.currentSpectra(i).spectra(:,2),'color',handles.currentSpectra(i).color);
        hold on
    end
end
if isfield(handles,'lineLeftClick')
    handles = rmfield(handles, 'lineLeftClick');
end
if isfield(handles,'lineRightClick')
    handles = rmfield(handles, 'lineRightClick');
end
guidata(hObject,handles)


% --- Executes on button press in normalize_checkbox.
function normalize_checkbox_Callback(hObject, eventdata, handles)
% hObject    handle to normalize_checkbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of normalize_checkbox
handles.normalize = get(hObject,'Value');
guidata(hObject,handles);


% --- Executes on button press in baseline_fit_button.
function baseline_fit_button_Callback(hObject, eventdata, handles)
% hObject    handle to baseline_fit_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if ~isfield(handles.currentSpectra,'spectra')
    error('You must choose a spectra!');
elseif (get(handles.use_line_check_box,'Value')==0)
    if isempty(handles.search_start) || isempty(handles.search_stop)
        handles.search_start = 1;
        handles.search_stop = length(handles.currentSpectra(1).spectra(:,2));
        truncateLow = handles.search_start;
        truncateHigh = handles.search_stop;
       
    else
        truncateLow = handles.search_start;                    
        truncateHigh = handles.search_stop;
    end
else
    if ~isfield(handles,'lineLeftClick') || ~isfield(handles,'lineRightClick');
        error('You must set marker lines!');
    end
    api = iptgetapi(handles.lineLeftClick);
    posLeft = api.getPosition();
    api = iptgetapi(handles.lineRightClick);
    posRight = api.getPosition();
    posLeft = posLeft(:,1);
    posLeft = posLeft(1);
    posRight = posRight(:,1);
    posRight = posRight(1); 
    if posLeft > posRight
        posLeftNew = posRight;
        posRightNew = posLeft;
        truncateLow = posLeftNew;
        truncateHigh = posRightNew;
    else
        truncateLow = posLeft;
        truncateHigh = posRight;
    end
end
truncateHigh = floor(truncateHigh);
truncateLow = ceil(truncateLow);
if isempty(handles.currentSpectra(1).spectra)
    error('Error: must choose a spectra and set truncation points!');
elseif truncateHigh-truncateLow + 1 > length(handles.currentSpectra(1).spectra(:,2))
    error('Error: truncation our of range!');
else
    cla;
    for i=1:numel(handles.currentSpectra)
        spectraNow = handles.currentSpectra(i).spectra;  
        spectraY = spectraNow(:,2);
        spectraY = spectraY(truncateLow:truncateHigh);
        spectraX = 1:length(spectraY);
        spectraX = spectraX(:);
        array = (truncateLow:1:truncateHigh)';
        slope_and_intercept = polyfit(spectraX,spectraY,1);
        handles.spectraBaseline = [];
        handles.spectraBaseline(:,i) = (array*slope_and_intercept(1))+slope_and_intercept(2);
        handles.currentSpectra(i).spectra = [];
        handles.currentSpectra(i).spectra(:,2) = spectraY;
        handles.currentSpectra(i).spectra(:,1) = spectraX;
        line(1:length(handles.spectraBaseline(:,i)),handles.spectraBaseline(:,i),'color','r');
        hold on
        handles.plotNow = line(spectraX,spectraY,'color',handles.currentSpectra(i).color);
        hold on
    end
end
if isfield(handles,'lineLeftClick')
    handles = rmfield(handles, 'lineLeftClick');
end
if isfield(handles,'lineRightClick')
    handles = rmfield(handles, 'lineRightClick');
end
handles.search_stop = [];
handles.search_start = [];
guidata(hObject,handles);



% --- Executes on button press in subtract_baseline_button.
function subtract_baseline_button_Callback(hObject, eventdata, handles)
% hObject    handle to subtract_baseline_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if ~isfield(handles,'currentSpectra')
    error('You must choose a spectra!');
elseif isempty(handles.search_start) || isempty(handles.search_stop)
    handles.search_start = 1;
    handles.search_stop = length(handles.currentSpectra(1).spectra(:,2));
end
cla;
for i = 1:numel(handles.currentSpectra)
    spectra = handles.currentSpectra(i).spectra(:,2);
    spectra = spectra - handles.spectraBaseline(:,i);
    handles.plotNow = line(1:length(spectra(:)),spectra,'color',handles.currentSpectra(i).color);
    hold on
    xlswrite('C:\Users\Spencer\Desktop\current_baseline.xlsx',spectra);
    handles.currentSpectra(i).spectra(:,2) = spectra;
    handles.currentSpectra(i).spectra(:,1) = 1:length(spectra);
end
if isfield(handles,'lineLeftClick')
    handles = rmfield(handles, 'lineLeftClick');
end
if isfield(handles,'lineRightClick')
    handles = rmfield(handles, 'lineRightClick');
end
guidata(hObject,handles);


% --- Executes on selection change in smooth_type_popupmenu.
function smooth_type_popupmenu_Callback(hObject, eventdata, handles)
% hObject    handle to smooth_type_popupmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns smooth_type_popupmenu contents as cell array
%        contents{get(hObject,'Value')} returns selected item from smooth_type_popupmenu

contents = cellstr(get(hObject,'String'));
selected = contents{get(hObject,'Value')};
handles.smoothType = selected;
guidata(hObject,handles);


% --- Executes during object creation, after setting all properties.
function smooth_type_popupmenu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to smooth_type_popupmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_text_span_input_Callback(hObject, eventdata, handles)
% hObject    handle to edit_text_span_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_text_span_input as text
%        str2double(get(hObject,'String')) returns contents of edit_text_span_input as a double
handles.smoothSpan = str2double(get(hObject,'String'));
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function edit_text_span_input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_text_span_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on mouse press over axes background.
function axes1_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to axes1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%{
cP = get(gca,'Currentpoint');
x = cP(1,1);
y = cP(1,2);
xlim = get(gca,'xlim');
ylim = get(gca,'ylim');
hold on
plot([x x], ylim); % vertical line
%}
clickType = get(gcbf, 'SelectionType');
xlim = get(gca,'xlim');
ylim = get(gca,'ylim');
cP = get(gca,'Currentpoint');
if (get(handles.amplitude_checkbox,'Value')==1)
    y = cP(1,2);
    xArray = [xlim(1) xlim(2)];
    yArray = [y y];
else
    x = cP(1,1);
    xArray = [x x];
    yArray = [ylim(1) ylim(2)];
end
if strcmpi(clickType,'normal')==1
    if isfield(handles,'lineLeftClick')==1
        xlim = get(gca,'xlim');
        ylim = get(gca,'ylim');
        cP = get(gca,'Currentpoint');
        y = cP(1,2);
        lineHandle = handles.lineLeftClick;
        setPosition(lineHandle,xArray,yArray);
        guidata(hObject,handles);
    else
        xlim = get(gca,'xlim');
        ylim = get(gca,'ylim');
        cP = get(gca,'Currentpoint');
        y = cP(1,2);
        handles.lineLeftClick = imline(gca,xArray,yArray);
        api = iptgetapi(handles.lineLeftClick);
        fcn = makeConstrainToRectFcn('imline',get(gca,'XLim'),...
        get(gca,'YLim'));
        api.setPositionConstraintFcn(fcn);
        guidata(hObject,handles);
    end
elseif strcmpi(clickType,'alt')==1
    if isfield(handles,'lineRightClick')
        'handle exists!';
        xlim = get(gca,'xlim');
        ylim = get(gca,'ylim');
        cP = get(gca,'Currentpoint');
        y = cP(1,2);
        lineHandle = handles.lineRightClick;
        setPosition(lineHandle,xArray,yArray);
        guidata(hObject,handles); 
    else
        handles.lineRightClick = imline(gca,xArray,yArray);
        api = iptgetapi(handles.lineRightClick);
        fcn = makeConstrainToRectFcn('imline',get(gca,'XLim'),...
        get(gca,'YLim'));
        api.setPositionConstraintFcn(fcn);
        guidata(hObject,handles);
        %id = addNewPositionCallback('imline','ButtonDownFcn'); adds the function handle fcn to the list of new-position callback functions of the ROI object h. Whenever the ROI object changes its position each function in the list is called with the syntax:
        %guidata(hObject,handles); 
    end
else
    error('Error : Mouse click error!');
end

% --- Executes on button press in line_distance_button.
function line_distance_button_Callback(hObject, eventdata, handles)
% hObject    handle to line_distance_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

api = iptgetapi(handles.lineLeftClick);
posLeft = api.getPosition();
api = iptgetapi(handles.lineRightClick);
posRight = api.getPosition();
if (get(handles.amplitude_checkbox,'Value')==1)
    posLeft = posLeft(:,2);
    posLeft = posLeft(1);
    posRight = posRight(:,2);
    posRight = posRight(1);
else
    posLeft = posLeft(:,1);
    posLeft = posLeft(1);
    posRight = posRight(:,1);
    posRight = posRight(1); 
end
distance = abs(posLeft-posRight);
set(handles.line_distance_output_edit,'String',num2str(distance)); 
guidata(hObject,handles);


function line_distance_output_edit_Callback(hObject, eventdata, handles)
% hObject    handle to line_distance_output_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of line_distance_output_edit as text
%        str2double(get(hObject,'String')) returns contents of line_distance_output_edit as a double


% --- Executes during object creation, after setting all properties.
function line_distance_output_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to line_distance_output_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in amplitude_checkbox.
function amplitude_checkbox_Callback(hObject, eventdata, handles)
% hObject    handle to amplitude_checkbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of amplitude_checkbox
set(handles.line_width_checkbox,'Value',0);
guidata(hObject,handles);

% --- Executes on button press in fit_button.
function fit_button_Callback(hObject, eventdata, handles)
% hObject    handle to fit_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

fitType = handles.fitType;

if(get(handles.use_line_check_box,'Value')==0)
    stdStart = handles.stdStart;                    
    stdEnd   = handles.stdEnd;
    fitStart = handles.fitStart;
    fitStop = handles.fitStop;
    numFitPoints = abs(fitStart-fitStop)+1;
else
    api = iptgetapi(handles.lineLeftClick);
    posLeft = api.getPosition();
    api = iptgetapi(handles.lineRightClick);
    posRight = api.getPosition();
    posLeft = posLeft(:,1);
    posLeft = posLeft(1);
    posRight = posRight(:,1);
    posRight = posRight(1); 
    distance = abs(posLeft-posRight);
    set(handles.line_distance_output_edit,'String',num2str(distance)); 
    guidata(hObject,handles);
    
    basisSpectra = handles.basisSpectra.data;
    stdStart = posLeft;                    
    stdEnd   = posRight;
    start = posLeft;
    stop = posRight;
    if start < stop
        startCeil = ceil(start);
        stopFloor = floor(stop);
    elseif start > stop
        startCeil = ceil(stop);
        stopFloor = floor(start);
    else
        distanceErrorString = 'Zero distance between lines!';
        set(handles.edit_output,'String',distanceErrorString,'ForegroundColor','r');
        guidata(hObject,handles);
        error(distanceErrorString);
    end
    lengthBasis = size(basisSpectra,1);
    width = abs(startCeil-stopFloor)+1;
    difference = abs(width-lengthBasis);
    gap = difference/2;
    if width < lengthBasis
        if mod(gap, 1) == 0
            gap1 = gap;
            gap2 = gap;
        else
            gap1 = floor(gap)
            gap2 = ceil(gap);
        end
        basisSpectra = basisSpectra(gap1+1:length(basisSpectra)-gap2);
        fitStart = startCeil;
        fitStop = stopFloor;
    elseif width > lengthBasis
        if mod(gap, 1) == 0
            gap1 = gap;
            gap2 = gap;
        else
            gap1 = floor(gap);
            gap2 = ceil(gap);
        end
        fitStart = startCeil + gap1;
        fitStop = stopFloor - gap2;
    else
        fitStart = startCeil;
        fitStop = stopFloor;
    end
    numFitPoints = abs(fitStart-fitStop)+1;
end

if (size(basisSpectra,1) ~= numFitPoints)
    fitErrorString = 'Error : Number of fit points must equal number of points in chosen basis spectra!';
    set(handles.edit_output,'String',fitErrorString,'ForegroundColor','r');
    guidata(hObject,handles);
    error(fitErrorString);
end

if strcmpi(fitType,'Original')
    fitType = 0;
else
    fitType = 1;
end

for i =1:numel(handles.currentSpectra)
    numSpectraPoints{i} = length(handles.currentSpectra(i).spectra);                                                               
    normalize = true;
    normalizeValue = 1;
    data = handles.currentSpectra(i).spectra;
    analyze = AnalyzeClass(data,basisSpectra,numSpectraPoints,numFitPoints,fitType,fitStart,fitStop,false,normalizeValue);
    analyze.DataFit();
    amplitudes(i) = analyze.amplitudes();
    fitted(:,i) = basisSpectra.*amplitudes(i);
    xValues(:,i) = 1:length(fitted(:,i));
    numValues(:,i)=i.*ones(length(fitted(:,i)),1);
end
        
plot3 = handles.plot3;
if(get(handles.plot_fitting_checkbox,'Value')==1)
        if plot3 == true
            api1 = iptgetapi(handles.lineLeftClick);
            pos1 = api1.getPosition();
            api2 = iptgetapi(handles.lineRightClick);
            pos2 = api2.getPosition();
            cla;
            numValues = [1:numel(handles.currentSpectra)];
            repNum = repmat(numValues,length(xValues(:,1)),1);
            repNum2 = repmat(1,1024,1);
            
            numValues = [1.01,2.01,3.01,4.01,5.01];
            repNum = repmat(numValues,length(xValues(:,1)),1);
            
            num = struct('num',[]);
            num(1).num = [350:1:350+length(fitted(:,1))-1];
            num(2).num = [350:1:350+length(fitted(:,2))-1];
            num(3).num = [350:1:350+length(fitted(:,3))-1];
            num(4).num = [350:1:350+length(fitted(:,4))-1];
            num(5).num = [350:1:350+length(fitted(:,5))-1];
            
            
            %{
            x = [0,0,0,0;1,1,1,1;2,2,2,2]';
            y = [1,2,3,4;1,2,3,4;1,2,3,4]';
            z = [1,5,10,9;6,2,6,8;1,6,9,5]';
            %}
            for m = 1:length(handles.currentSpectra)
                line(repNum(:,m),num(m).num,fitted(:,m),'color','red');
                hold on
                line(repmat(m,1024,1),handles.currentSpectra(m).spectra(:,1),handles.currentSpectra(m).spectra(:,2),'color',handles.currentSpectra(m).color)
                hold on
            end
            %surf(repNum,xValues,fitted,'EdgeColor','none','FaceColor','red');
            camlight left; lighting phong
            view(26, 42);

            %[X,Y,Z] = peaks(25);
            %surf(gca,X,Y,Z);
            %handles.lineLeftClick = imline(gca,pos1);
            %handles.lineRightClick = imline(gca,pos2);
        else
            line(fitStart:fitStop,fitted,'linewidth',2.0,'color','r');
            
        end
end
set(handles.edit_output,'String',['Amplitudes :',' ',num2str(amplitudes)]);
savePath = handles.savePath;
nameWrite = strcat(savePath,'\','results_','nail_dosimetry','.xlsx');
xlswrite(nameWrite,fitted);
guidata(hObject,handles);
    
%{
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
%}


% --- Executes on button press in find_center_button.
function find_center_button_Callback(hObject, eventdata, handles)
% hObject    handle to find_center_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
spectra = handles.spectra;
if get(handles.use_line_check_box,'Value')==0
    posLeft = str2double(get(handles.search_start_edit,'String'));
    posRight = str2double(get(handles.search_end_edit,'String'));
else
    api1 = iptgetapi(handles.lineLeftClick);
    posLeft = api1.getPosition();
    api2 = iptgetapi(handles.lineRightClick);
    posRight = api2.getPosition();
    if posLeft > posRight
        posLeftNew = posRight;
        posRightNew = posLeft;
        posLeft = posLeftNew;
        posRight = posRightNew;
    end
end
spectraTrun = spectra(posRight:posLeft);
center = AnalyzeClass();
centerPoint = center.GetCenter();
set(handles.edit_output,'String',['Center : ','',num2str(centerPoint)]);
guidata(hObject,handles);

% --- Executes on button press in range_button.
function range_button_Callback(hObject, eventdata, handles)
% hObject    handle to range_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
spectra = handles.spectra;
if get(handles.use_line_check_box,'Value')==0
    posLeft = str2double(get(handles.search_start_edit,'String'));
    posRight = str2double(get(handles.search_end_edit,'String'));
else
    api1 = iptgetapi(handles.lineLeftClick);
    posLeft = api1.getPosition();
    api2 = iptgetapi(handles.lineRightClick);
    posRight = api2.getPosition();
    if posLeft > posRight
        posLeftNew = posRight;
        posRightNew = posLeft;
        posLeft = posLeftNew;
        posRight = posRightNew;
    end
end
rangeNum = range(spectra(posLeft:posRight));
set(handles.edit_output,'String',['Range : ','',num2str(rangeNum)]);
guidata(hObject,handles);

% --- Executes on button press in pushbutton62.
function pushbutton62_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton62 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in line_width_checkbox.
function line_width_checkbox_Callback(hObject, eventdata, handles)
% hObject    handle to line_width_checkbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of line_width_checkbox
set(handles.amplitude_checkbox,'Value',0);
guidata(hObject,handles);


% --- Executes on button press in use_line_check_box.
function use_line_check_box_Callback(hObject, eventdata, handles)
% hObject    handle to use_line_check_box (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of use_line_check_box


% --- Executes on button press in handles_button.
function handles_button_Callback(hObject, eventdata, handles)
% hObject    handle to handles_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
structSize = length(fieldnames(handles));
names = fieldnames(handles);
set(handles.edit_output,'String',names,'ForegroundColor','k');
guidata(hObject,handles);


% --- Executes on button press in plot3d_checkbox.
function plot3d_checkbox_Callback(hObject, eventdata, handles)
% hObject    handle to plot3d_checkbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of plot3d_checkbox
handles.plot3 = get(hObject,'Value');
guidata(hObject,handles);


% --- Executes on button press in clear_current_spectra_button.
function clear_current_spectra_button_Callback(hObject, eventdata, handles)
% hObject    handle to clear_current_spectra_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.currentSpectra = struct('spectra',[],'spectraInformation',[],'fileName',[],'fileDir',[]);
cla;
guidata(hObject,handles);

% --- Executes on button press in delete_spectra_button.
function delete_spectra_button_Callback(hObject, eventdata, handles)
% hObject    handle to delete_spectra_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if isempty(handles.currentSpectra(1).fileName)
    error('No spectra have been added!');
end
if handles.viewSavedSpectra == true

else
index = 0;   
for index = 1:numel(handles.currentSpectra)
    [pathstr,name,ext] = fileparts(handles.currentSpectra(index).fileName);
    extName = strcat(name,ext);
    index = get(handles.listbox1,'Value');
    strings = get(handles.listbox1,'String');
    selectedString = strings{index};
    [pathstrS,nameS,extS] = fileparts(selectedString);
    extSelect = strcat(nameS,extS);
    if strcmpi(extSelect,extName)
        handles.currentSpectra(index) = [];
        %{
        handles.currentSpectra(index).fileName = [];
        handles.currentSpectra(index).fileName = handles.currentSpectra(index).fileName(~cellfun(@isempty, handles.currentSpectra(index).fileName));
        handles.currentSpectra(index).path = [];
        handles.currentSpectra(index).path = handles.currentSpectra(index).path(~cellfun(@isempty, handles.currentSpectra(index).path));
        handles.currentSpectra(index).spectra = [];
        handles.currentSpectra(index).spectra = handles.currentSpectra(index).spectra(~cellfun(@isempty, handles.currentSpectra(index).spectra));
        handles.currentSpectra(index).information = [];
        %}
        %filenames = getfield(handles.currentSpectra, 'fileName');
        allNames = {handles.currentSpectra.fileName};
        size = numel(handles.currentSpectra);
        set(handles.listbox1,'String',allNames,'Value',size);
        guidata(hObject,handles);
        break
    end
end
cla;
for j = 1:numel(handles.currentSpectra)
    line(1:length(handles.currentSpectra(j).spectra(:,2)),handles.currentSpectra(j).spectra(:,2));
end
end


% --- Executes on button press in standard_align_button.
function standard_align_button_Callback(hObject, eventdata, handles)
% hObject    handle to standard_align_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if ~isfield(handles,'currentSpectra')
    error('You must choose a spectra!');
end
if get(handles.use_line_check_box,'Value')==0
    posLeft = str2double(get(handles.search_start_edit,'String'));
    posRight = str2double(get(handles.search_end_edit,'String'));
else
    api1 = iptgetapi(handles.lineLeftClick);
    posLeft = api1.getPosition();
    api2 = iptgetapi(handles.lineRightClick);
    posRight = api2.getPosition();
    if posLeft > posRight
        posLeftNew = posRight;
        posRightNew = posLeft;
        posLeft = posLeftNew;
        posRight = posRightNew;
    end
end
stdStart = ceil(posLeft(1));
stdEnd = floor(posRight(1));
for i=1:numel(handles.currentSpectra)
    crossovers(i) = AnalyzeClass.Crossover(handles.currentSpectra(i).spectra(:,2),stdStart,stdEnd);
    rgb = handles.currentSpectra(i).color;
    color8hex = sprintf('#%02X%02X%02X',rgb*255);
    output = num2str(crossovers(i));
    newText = ['Crossover Points :',' ',output];
    newColor = sprintf('<HTML><font color="%s">%s</font></HTML>',color8hex,newText);
    namestr{i} = newColor; 
end
%set(handles.edit_output,'String',namestr);
set(handles.edit_output,'Style','list','String',namestr);
guidata(hObject,handles);
   

% --- Executes on button press in right_move_button.
function right_move_button_Callback(hObject, eventdata, handles)
% hObject    handle to right_move_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if ~isfield(handles,'spectra')
    error('You must choose a spectra!');
end
spectra(:,2) = handles.spectra(:,2);
spectra(:,1) = handles.spectra(:,1);
newX = spectra(:,1)+1;
newX = newX(:);
cla;
line(newX,spectra(:,2));
handles.spectra = [newX,spectra(:,2)];
guidata(hObject,handles);


% --- Executes on button press in left_move_button.
function left_move_button_Callback(hObject, eventdata, handles)
% hObject    handle to left_move_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if ~isfield(handles,'spectra')
    error('You must choose a spectra!');
end
spectra(:,2) = handles.spectra(:,2);
spectra(:,1) = handles.spectra(:,1);
newX = spectra(:,1)-1;
newX = newX(:);
cla;
line(newX,spectra(:,2));
handles.spectra = [newX,spectra(:,2)];
guidata(hObject,handles);


% --- Executes on button press in up_move_button.
function up_move_button_Callback(hObject, eventdata, handles)
% hObject    handle to up_move_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if ~isfield(handles,'spectra')
    error('You must choose a spectra!');
end
spectra(:,2) = handles.spectra(:,2);
spectra(:,1) = handles.spectra(:,1);
newY = spectra(:,2)+1;
newY = newY(:);
cla;
line(spectra(:,1),newY);
handles.spectra = [spectra(:,1),newY];
guidata(hObject,handles);

% --- Executes on button press in down_move_button.
function down_move_button_Callback(hObject, eventdata, handles)
% hObject    handle to down_move_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if ~isfield(handles,'spectra')
    error('You must choose a spectra!');
end
spectra(:,2) = handles.spectra(:,2);
spectra(:,1) = handles.spectra(:,1);
newY = spectra(:,2)-1;
newY = newY(:);
cla;
line(spectra(:,1),newY);
handles.spectra = [spectra(:,1),newY];
guidata(hObject,handles);


function edit58_Callback(hObject, eventdata, handles)
% hObject    handle to edit58 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit58 as text
%        str2double(get(hObject,'String')) returns contents of edit58 as a double


% --- Executes during object creation, after setting all properties.
function edit58_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit58 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit59_Callback(hObject, eventdata, handles)
% hObject    handle to edit59 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit59 as text
%        str2double(get(hObject,'String')) returns contents of edit59 as a double


% --- Executes during object creation, after setting all properties.
function edit59_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit59 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit60_Callback(hObject, eventdata, handles)
% hObject    handle to edit60 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit60 as text
%        str2double(get(hObject,'String')) returns contents of edit60 as a double


% --- Executes during object creation, after setting all properties.
function edit60_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit60 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
