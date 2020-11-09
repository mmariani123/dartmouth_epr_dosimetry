function varargout = line_fit_gui(varargin)
% LINE_FIT_GUI MATLAB code for line_fit_gui.fig
%      LINE_FIT_GUI, by itself, creates a new LINE_FIT_GUI or raises the existing
%      singleton*.
%
%      H = LINE_FIT_GUI returns the handle to a new LINE_FIT_GUI or the handle to
%      the existing singleton*.
%
%      LINE_FIT_GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in LINE_FIT_GUI.M with the given input arguments.
%
%      LINE_FIT_GUI('Property','Value',...) creates a new LINE_FIT_GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before line_fit_gui_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to line_fit_gui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help line_fit_gui

% Last Modified by GUIDE v2.5 28-Aug-2014 18:11:23

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @line_fit_gui_OpeningFcn, ...
                   'gui_OutputFcn',  @line_fit_gui_OutputFcn, ...
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


% --- Executes just before line_fit_gui is made visible.
function line_fit_gui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to line_fit_gui (see VARARGIN)

% Choose default command line output for line_fit_gui
handles.output = hObject;
handles.currentDoses = 0;
handles.currentValues = 0;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes line_fit_gui wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = line_fit_gui_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in run_button.
function run_button_Callback(hObject, eventdata, handles)
% hObject    handle to run_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
data = get(handles.uitable1,'Data');
doses = cell2mat(data(:,1));
signs = sign(doses);
for z = 1:length(signs)
    if signs(z)<0
        error('Doses cannot be negative!');
    end
end
values = cell2mat(data(:,2:end));
cla
finalString = [];
xRange = [-0.1:0.1:max(doses)+1];
fitType = 'zero';
randomColor = hsv(size(values,2));
for j = 1:size(values,2)
    plot(doses,values(:,j),'o','markerfacecolor',randomColor(j,:),'markeredgecolor',randomColor(j,:));
    hold on
    if get(handles.fit_data_checkbox,'Value')==true 
        [slope(:,j) dataOut(:,j) slopeString{j} sepString{j} rSquaredString{j}] = LineFit(doses,values(:,j),xRange,fitType,[]);
        cellArray{j} = strvcat(strcat('Results',num2str(j),':'),slopeString{1},sepString{1},rSquaredString{1}); 
        finalString = strvcat(finalString,cellArray{j});
        if get(handles.fit_data_checkbox,'Value')==true
            plot(xRange',dataOut(:,j),'color',randomColor(j,:),'linewidth',2);
            set(handles.axes1,'XLIM',[0 max(doses)+1]);
        end
    end
end
set(handles.output_edit,'String',finalString);
    
    
function number_doses_edit_Callback(hObject, eventdata, handles)
% hObject    handle to number_doses_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of number_doses_edit as text
%        str2double(get(hObject,'String')) returns contents of number_doses_edit as a double


% --- Executes during object creation, after setting all properties.
function number_doses_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to number_doses_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in number_doses_button.
function number_doses_button_Callback(hObject, eventdata, handles)
% hObject    handle to number_doses_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    getValue = get(handles.number_doses_edit,'String');
    getValueNum = (str2double(getValue));
    if ~isa(getValueNum,'numeric') || isnan(getValueNum)
        error('Doses to plot must be a number!');
    elseif(getValueNum == 0.0)
        numArray={''};
        set(handles.uitable1,'RowName',numArray);
        error('Doses to plot must be greater than 0!');
    end
        set(handles.uitable1,'RowName',{1:getValueNum});;
        %trueArray=true(1,getValueNum);
        %set(handles.uitable1,'ColumnEditable',trueArray);
        %handles.currentDoses = getValueNum;
        %guidata(hObject,handles);
        
        getValue2 = get(handles.number_values_edit,'String');
        getValueNum2 = (str2double(getValue2));
    if ~isa(getValueNum2,'numeric') || isnan(getValueNum2)
        error('Number of values to plot must be a number!');
    elseif(getValueNum2 <= 0.0)
        error('Number of values to plot must be greater than 0!');
    elseif(getValueNum2 == 1.0)
        set(handles.uitable1,'ColumnName',{'Doses','Values'});
        addDoses = getValueNum;
        numDoses = handles.currentDoses + addDoses;
        oldData = get(handles.uitable1,'Data');
        newData = cell(numDoses,2);
    else
        valuesMulti{1} = 'Doses';
        for i = 1:getValueNum2
            valuesMulti{i+1} = strcat('Values ',num2str(i));
        end
        set(handles.uitable1,'ColumnName',valuesMulti);
        newData = cell(getValueNum,getValueNum2+1);
    end
    set(handles.uitable1,'Data',newData);
    trueArray2=true(1,getValueNum2+1);
    set(handles.uitable1,'ColumnEditable',trueArray2);
    handles.currentValues = getValueNum2;
    guidata(hObject,handles);



function output_edit_Callback(hObject, eventdata, handles)
% hObject    handle to output_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of output_edit as text
%        str2double(get(hObject,'String')) returns contents of output_edit as a double


% --- Executes during object creation, after setting all properties.
function output_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to output_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function number_values_edit_Callback(hObject, eventdata, handles)
% hObject    handle to number_values_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of number_values_edit as text
%        str2double(get(hObject,'String')) returns contents of number_values_edit as a double


% --- Executes during object creation, after setting all properties.
function number_values_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to number_values_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in number_values_button.
function number_values_button_Callback(hObject, eventdata, handles)
% hObject    handle to number_values_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
   

% --- Executes on button press in open_figure_button.
function open_figure_button_Callback(hObject, eventdata, handles)
% hObject    handle to open_figure_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.figure2 = figure(2); 
clf
copyobj(handles.axes1,handles.figure2);
display(handles);


% --- Executes on button press in fit_data_checkbox.
function fit_data_checkbox_Callback(hObject, eventdata, handles)
% hObject    handle to fit_data_checkbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of fit_data_checkbox
