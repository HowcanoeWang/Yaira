function varargout = NewProject(varargin)
% NEWPROJECT MATLAB code for NewProject.fig
%      NEWPROJECT, by itself, creates a new NEWPROJECT or raises the existing
%      singleton*.
%
%      H = NEWPROJECT returns the handle to a new NEWPROJECT or the handle to
%      the existing singleton*.
%
%      NEWPROJECT('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in NEWPROJECT.M with the given input arguments.
%
%      NEWPROJECT('Property','Value',...) creates a new NEWPROJECT or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before NewProject_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to NewProject_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help NewProject

% Last Modified by GUIDE v2.5 03-Mar-2016 17:08:48

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @NewProject_OpeningFcn, ...
    'gui_OutputFcn',  @NewProject_OutputFcn, ...
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


% --- Executes just before NewProject is made visible.
function NewProject_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to NewProject (see VARARGIN)

% Choose default command line output for NewProject
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes NewProject wait for user response (see UIRESUME)
% uiwait(handles.NewProject);



% --- Outputs from this function are returned to the command line.
function varargout = NewProject_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
fileName=get(handles.edit2,'string');
pathName=get(handles.NewProject,'UserData');
if pathName==0
    warndlg('请选择文件路径！','警告！',[0,30]);
elseif  isempty(fileName)
    warndlg('请填写项目文件名！','警告！',[0,30]);
else
    pathName=[pathName '\'];
    fileName=[fileName '.mat'];
    if eval(['exist(''' pathName fileName ''')'])==2
        eval(['button=questdlg(''' fileName '同名已存在是否覆盖？' ''',''警告'',''是'',''否'',''是'');'])
        if strcmp(button,'是')
            saveState='Saved';
            save '.\SystemData.mat' -append 'pathName' 'fileName' 'saveState'
            SaveData
            if exist('saveNew','var')
                clearvars -EXCEPT hObject handles eventdata fileName pathName
                load([pathName fileName]);
            end
            close(NewProject)
        else
            return;
        end
    else
        saveState='Saved';
        save '.\SystemData.mat' -append 'pathName' 'fileName' 'saveState'
        SaveData
        if exist('saveNew','var')
            clearvars -EXCEPT hObject handles eventdata fileName pathName
            load([pathName fileName]);
        end
        close(NewProject)
    end
end

% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
button=questdlg('是否取消保存新建的项目？','警告','是','否','是');
if strcmp(button,'是')
    close(gcf)
else
    return;
end

% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
pathName=uigetdir('C:\Program Files');
if pathName~=0
    set(handles.edit1,'string',pathName);
    set(handles.NewProject,'UserData',pathName);
end
