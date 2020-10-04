function varargout = ModelDataViewer(varargin)
% MODELDATAVIEWER MATLAB code for ModelDataViewer.fig
%      MODELDATAVIEWER, by itself, creates a new MODELDATAVIEWER or raises the existing
%      singleton*.
%
%      H = MODELDATAVIEWER returns the handle to a new MODELDATAVIEWER or the handle to
%      the existing singleton*.
%
%      MODELDATAVIEWER('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MODELDATAVIEWER.M with the given input arguments.
%
%      MODELDATAVIEWER('Property','Value',...) creates a new MODELDATAVIEWER or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before ModelDataViewer_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to ModelDataViewer_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help ModelDataViewer

% Last Modified by GUIDE v2.5 20-Apr-2016 15:29:12

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @ModelDataViewer_OpeningFcn, ...
    'gui_OutputFcn',  @ModelDataViewer_OutputFcn, ...
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


% --- Executes just before ModelDataViewer is made visible.
function ModelDataViewer_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to ModelDataViewer (see VARARGIN)

% Choose default command line output for ModelDataViewer
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes ModelDataViewer wait for user response (see UIRESUME)
% uiwait(handles.viewer);

global DataNow XI YI ZI time123 x_lable y_lable z_lable X Y Z sample unitX unitY unitZ Cmax Cmin name kind
load .\SystemData.mat

%初始化坐标轴
set(handles.SampleName,'value',1)
set(handles.KindNum,'value',1)
set(handles.AccuracyWay,'value',1)
%正式绘图程序
set(handles.SampleName,'string',List(:,2))
set(handles.KindNum,'string',Sample1.Kind(:,1))
eval(['DataNow=' List{1,1} '.Kind{1,7};'])
eval(['Size=' List{1,1} '.Size;'])
eval(['accuracy=' List{1,1} '.Accuracy;'])
eval(['SampleTime=' List{1,1} '.Kind{1,5};'])
eval(['sample=' List{1,1} ';'])
UnitsTransfer
[y,x,z,t]=size(DataNow);
x0=Size(1);
x1=Size(2);
y0=Size(3);
y1=Size(4);
z0=Size(5);
z1=Size(6);
[XI,YI,ZI]=meshgrid(x0:(x1-x0)/accuracy:x1,y0:(y1-y0)/accuracy:y1,z0:(z1-z0)/accuracy:z1);
if size(SampleTime,1)>1
    time123=SampleTime(1):(SampleTime(end)-SampleTime(1))/accuracy:SampleTime(end);
else
    time123=SampleTime;
end
x_lable=x0:(x1-x0)/accuracy:x1;
y_lable=y0:(y1-y0)/accuracy:y1;
z_lable=z0:(z1-z0)/accuracy:z1;
if size(SampleTime,1)==1
    set(handles.Time,'string',datestr(SampleTime(1),'yyyy.mm.dd HH:MM:SS'))
    set(handles.slider1,'visible','off')
else
    set(handles.slider1,'visible','on')
    set(handles.slider1,'min',1)
    set(handles.slider1,'max',t)
    set(handles.slider1,'value',1)
    set(handles.slider1,'sliderstep',[1/accuracy 1/accuracy*2])
    set(handles.Time,'string',datestr(SampleTime(1),'yyyy.mm.dd HH:MM:SS'))
end
%X轴初始化设置
set(handles.slider2,'min',1)
set(handles.slider2,'max',x)
set(handles.slider2,'value',1)
set(handles.slider2,'sliderstep',[1/accuracy 1/accuracy*2])
%Y轴初始化设置
set(handles.slider3,'min',1)
set(handles.slider3,'max',y)
set(handles.slider3,'value',1)
set(handles.slider3,'sliderstep',[1/accuracy 1/accuracy*2])
%Z轴初始化设置
set(handles.slider4,'min',1)
set(handles.slider4,'max',z)
set(handles.slider4,'value',z)
set(handles.slider4,'sliderstep',[1/accuracy 1/accuracy*2])
%标记初始化设置
set(handles.X0,'string',['↑' num2str(x0) unitX])
set(handles.X1,'string',[num2str(x1) unitX '↑' ])
set(handles.Y0,'string',['↑' num2str(y0) unitY])
set(handles.Y1,'string',[num2str(y1) unitY '↑' ])
set(handles.Z0,'string',['↑' num2str(z0) unitZ])
set(handles.Z1,'string',[num2str(z1) unitZ '↑' ])
X_ctrl=get(handles.slider2,'value');
Y_ctrl=get(handles.slider3,'value');
Z_ctrl=get(handles.slider4,'value');
Vq(:,:,:)=DataNow(:,:,:,1);
axes(handles.axes1)
Cmax=max(max(max(max(DataNow))));
Cmin=min(min(min(min(DataNow))));
caxis([Cmin Cmax]);
%采样点显示程序
b=get(handles.KindNum,'value');
sampleNumber=get(handles.SampleName,'Value');
sample4Time=get(handles.slider1,'Value');
FigureShow4Reader
hold on
slice(XI,YI,ZI,Vq,x_lable(X_ctrl),y_lable(Y_ctrl),z_lable(Z_ctrl));
axis(Size);
colormap(flipud(summer));
name=sample.Name;
kind=sample.Kind{b,1};

% --- Outputs from this function are returned to the command line.
function varargout = ModelDataViewer_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;
warning('off','MATLAB:HandleGraphics:ObsoletedProperty:JavaFrame')
javaFrame=get(hObject,'JavaFrame');
set(javaFrame,'Maximized',1)


% --- Executes on button press in checkbox1.
function checkbox1_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
slider1_Callback(hObject, eventdata, handles)
% Hint: get(hObject,'Value') returns toggle state of checkbox1


% --- Executes on slider movement.
function slider1_Callback(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global DataNow XI YI ZI time123 x_lable y_lable z_lable X Y Z name kind unitX unitY unitZ Cmin Cmax
T_ctrl=floor(get(handles.slider1,'value'));
set(handles.Time,'string',datestr(time123(T_ctrl),'yyyy.mm.dd HH:MM:SS'))
if get(handles.checkbox1,'value')==1
    X_ctrl=floor(get(handles.slider2,'value'));
    xi=x_lable(X_ctrl);
    set(handles.slider2,'enable','on');
else
    xi=nan;
    set(handles.slider2,'enable','off');
end
if get(handles.checkbox2,'value')==1
    Y_ctrl=floor(get(handles.slider3,'value'));
    yi=y_lable(Y_ctrl);
    set(handles.slider3,'enable','on');
else
    yi=nan;
    set(handles.slider3,'enable','off');
end
if get(handles.checkbox3,'value')==1
    Z_ctrl=floor(get(handles.slider4,'value'));
    zi=z_lable(Z_ctrl);
    set(handles.slider4,'enable','on');
else
    zi=nan;
    set(handles.slider4,'enable','off');
end
%抽取数据
if size(DataNow,4)>1
    Vq(:,:,:)=DataNow(:,:,:,T_ctrl);
elseif size(DataNow,3)>1
    Vq(:,:,:)=DataNow;
end
cla
if get(handles.PointsShow,'value')==1
    scatter3(X,Y,Z,30,'filled');hold on
end
title([name ' ' kind ' ' datestr(time123(T_ctrl),'yyyy.mm.dd HH:MM:SS')]);
eval(['xlabel(''样地长(' unitX ')'',''fontsize'',14,''Color'',''black'',''FontWeight'',''bold'');'])
eval(['ylabel(''样地宽(' unitY ')'',''fontsize'',14,''Color'',''black'',''FontWeight'',''bold'');'])
eval(['zlabel(''样地高(' unitZ ')'',''fontsize'',14,''Color'',''black'',''FontWeight'',''bold'');'])
hold on
slice(XI,YI,ZI,Vq,xi,yi,zi);
%控制图像处颜色条与网格
colormap(flipud(summer));
if strcmp(get(handles.ColorBar,'state'),'on')
    colorbar
    caxis([Cmin Cmax]);
end
if get(handles.GridLine,'value')==0
    shading interp
end
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in checkbox2.
function checkbox2_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
slider1_Callback(hObject, eventdata, handles)
% Hint: get(hObject,'Value') returns toggle state of checkbox2


% --- Executes on slider movement.
function slider2_Callback(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
slider1_Callback(hObject, eventdata, handles)
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in checkbox3.
function checkbox3_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
slider1_Callback(hObject, eventdata, handles)
% Hint: get(hObject,'Value') returns toggle state of checkbox3


% --- Executes on slider movement.
function slider3_Callback(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
slider1_Callback(hObject, eventdata, handles)
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider4_Callback(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
slider1_Callback(hObject, eventdata, handles)
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function Time_Callback(hObject, eventdata, handles)
% hObject    handle to Time (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Time as text
%        str2double(get(hObject,'String')) returns contents of Time as a double


% --- Executes during object creation, after setting all properties.
function Time_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Time (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in PointsShow.
function PointsShow_Callback(hObject, eventdata, handles)
% hObject    handle to PointsShow (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
slider1_Callback(hObject, eventdata, handles)
% Hint: get(hObject,'Value') returns toggle state of PointsShow


% --- Executes on button press in GridLine.
function GridLine_Callback(hObject, eventdata, handles)
% hObject    handle to GridLine (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
slider1_Callback(hObject, eventdata, handles)
% Hint: get(hObject,'Value') returns toggle state of GridLine


% --- Executes on selection change in SampleName.
function SampleName_Callback(hObject, eventdata, handles)
% hObject    handle to SampleName (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns SampleName contents as cell array
%        contents{get(hObject,'Value')} returns selected item from SampleName
load .\SystemData.mat
i=get(handles.SampleName,'value');
samplename=List{i,1};
eval(['set(handles.KindNum,''string'',' samplename '.Kind(:,1))'])

% --- Executes during object creation, after setting all properties.
function SampleName_CreateFcn(hObject, eventdata, handles)
% hObject    handle to SampleName (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in AccuracyWay.
function AccuracyWay_Callback(hObject, eventdata, handles)
% hObject    handle to AccuracyWay (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns AccuracyWay contents as cell array
%        contents{get(hObject,'Value')} returns selected item from AccuracyWay


% --- Executes during object creation, after setting all properties.
function AccuracyWay_CreateFcn(hObject, eventdata, handles)
% hObject    handle to AccuracyWay (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in KindNum.
function KindNum_Callback(hObject, eventdata, handles)
% hObject    handle to KindNum (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns KindNum contents as cell array
%        contents{get(hObject,'Value')} returns selected item from KindNum


% --- Executes during object creation, after setting all properties.
function KindNum_CreateFcn(hObject, eventdata, handles)
% hObject    handle to KindNum (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in FreshFigure.
function FreshFigure_Callback(hObject, eventdata, handles)
% hObject    handle to FreshFigure (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
load .\SystemData.mat
global DataNow XI YI ZI time123 x_lable y_lable z_lable Size X Y Z sample unitX unitY unitZ name kind Cmax Cmin
Yangdi=get(handles.SampleName,'value');
Chazhi=get(handles.AccuracyWay,'value');
Xiangmu=get(handles.KindNum,'value');
%数据获取
eval(['DataNow=' List{Yangdi,1} '.Kind{Xiangmu,6+Chazhi};'])
if ~isempty(DataNow) && all(all(all(all(isnan(DataNow)))))==0
    eval(['Size=' List{Yangdi,1} '.Size;'])
    eval(['accuracy=' List{Yangdi,1} '.Accuracy;'])
    eval(['SampleTime=' List{Yangdi,1} '.Kind{Xiangmu,5};'])
    eval(['sample=' List{Yangdi,1} ';'])
    UnitsTransfer
    [y,x,z,t]=size(DataNow);
    x0=Size(1);
    x1=Size(2);
    y0=Size(3);
    y1=Size(4);
    z0=Size(5);
    z1=Size(6);
    [XI,YI,ZI]=meshgrid(x0:(x1-x0)/accuracy:x1,y0:(y1-y0)/accuracy:y1,z0:(z1-z0)/accuracy:z1);
    if size(SampleTime,1)>1
        time123=SampleTime(1):(SampleTime(end)-SampleTime(1))/accuracy:SampleTime(end);
    else
        time123=SampleTime;
    end
    x_lable=x0:(x1-x0)/accuracy:x1;
    y_lable=y0:(y1-y0)/accuracy:y1;
    z_lable=z0:(z1-z0)/accuracy:z1;
    if size(SampleTime,1)==1
        set(handles.Time,'string',datestr(SampleTime(1),'yyyy.mm.dd HH:MM:SS'))
        set(handles.slider1,'visible','off')
    else
        set(handles.slider1,'visible','on')
        set(handles.slider1,'min',1)
        set(handles.slider1,'max',t)
        set(handles.slider1,'sliderstep',[1/accuracy 1/accuracy*2])
        set(handles.slider1,'value',1)
        T_ctrl=floor(get(handles.slider1,'value'));
        set(handles.Time,'string',datestr(SampleTime(T_ctrl),'yyyy.mm.dd HH:MM:SS'))
    end
    %X轴初始化设置
    set(handles.slider2,'min',1)
    set(handles.slider2,'max',x)
    if get(handles.slider2,'value')>x
        set(handles.slider2,'value',1)
    end
    set(handles.slider2,'sliderstep',[1/accuracy 1/accuracy*2])
    %Y轴初始化设置
    set(handles.slider3,'min',1)
    set(handles.slider3,'max',y)
    if get(handles.slider3,'value')>y
        set(handles.slider3,'value',1)
    end
    set(handles.slider3,'sliderstep',[1/accuracy 1/accuracy*2])
    %Z轴初始化设置
    set(handles.slider4,'min',1)
    set(handles.slider4,'max',z)
    if get(handles.slider4,'value')>z
        set(handles.slider4,'value',z)
    end
    set(handles.slider4,'sliderstep',[1/accuracy 1/accuracy*2])
    %标记初始化设置
    set(handles.X0,'string',['↑' num2str(x0) unitX])
    set(handles.X1,'string',[num2str(x1) unitX '↑' ])
    set(handles.Y0,'string',['↑' num2str(y0) unitY])
    set(handles.Y1,'string',[num2str(y1) unitY '↑' ])
    set(handles.Z0,'string',['↑' num2str(z0) unitZ])
    set(handles.Z1,'string',[num2str(z1) unitZ '↑' ])
    if size(DataNow)==1
        sample4Time=1;
    end
    DrawFigure
    name=sample.Name;
    kind=sample.Kind{b,1};
    Cmax=max(max(max(max(DataNow))));
    Cmin=min(min(min(min(DataNow))));
    set(handles.slider1,'enable','on')
    set(handles.slider2,'enable','on')
    set(handles.slider3,'enable','on')
    set(handles.slider4,'enable','on')
    set(handles.checkbox1,'enable','on')
    set(handles.checkbox2,'enable','on')
    set(handles.checkbox3,'enable','on')
    set(handles.PointsShow,'enable','on')
    set(handles.GridLine,'enable','on')
else
    axes(handles.axes1)
    cla reset
    b=get(handles.KindNum,'value');
    sampleNumber=get(handles.SampleName,'Value');
    sampleTime=1;
    FigureShow
    set(handles.slider1,'enable','off')
    set(handles.slider2,'enable','off')
    set(handles.slider3,'enable','off')
    set(handles.slider4,'enable','off')
    set(handles.checkbox1,'enable','off')
    set(handles.checkbox2,'enable','off')
    set(handles.checkbox3,'enable','off')
    set(handles.PointsShow,'enable','off')
    set(handles.GridLine,'enable','off')
    set(handles.Time,'string','无插值数据')
end

% --------------------------------------------------------------------
function youjian_Callback(hObject, eventdata, handles)
% hObject    handle to youjian (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% --------------------------------------------------------------------
function Flash_ClickedCallback(hObject, eventdata, handles)
% hObject    handle to Flash (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global DataNow XI YI ZI time123 x_lable y_lable z_lable X Y Z name kind unitX unitY unitZ Cmin Cmax

if size(DataNow,4)>1
    if get(handles.checkbox1,'value')==1
        X_ctrl=floor(get(handles.slider2,'value'));
        xi=x_lable(X_ctrl);
        set(handles.slider2,'enable','on');
    else
        xi=nan;
        set(handles.slider2,'enable','off');
    end
    if get(handles.checkbox2,'value')==1
        Y_ctrl=floor(get(handles.slider3,'value'));
        yi=y_lable(Y_ctrl);
        set(handles.slider3,'enable','on');
    else
        yi=nan;
        set(handles.slider3,'enable','off');
    end
    if get(handles.checkbox3,'value')==1
        Z_ctrl=floor(get(handles.slider4,'value'));
        zi=z_lable(Z_ctrl);
        set(handles.slider4,'enable','on');
    else
        zi=nan;
        set(handles.slider4,'enable','off');
    end
    num=size(time123,2);
    for i=1:num
        Vq(:,:,:)=DataNow(:,:,:,i);
        cla
        if get(handles.PointsShow,'value')==1
            scatter3(X,Y,Z,30,'filled');hold on
        end
        title([name ' ' kind ' ' datestr(time123(i),'yyyy.mm.dd HH:MM:SS')]);
        eval(['xlabel(''样地长(' unitX ')'',''fontsize'',14,''Color'',''black'',''FontWeight'',''bold'');'])
        eval(['ylabel(''样地宽(' unitY ')'',''fontsize'',14,''Color'',''black'',''FontWeight'',''bold'');'])
        eval(['zlabel(''样地高(' unitZ ')'',''fontsize'',14,''Color'',''black'',''FontWeight'',''bold'');'])
        hold on
        slice(XI,YI,ZI,Vq,xi,yi,zi);
        %控制图像处颜色条与网格
        colormap(flipud(summer));
        if strcmp(get(handles.ColorBar,'state'),'on')
            colorbar
            caxis([Cmin Cmax]);
        end
        if get(handles.GridLine,'value')==0
            shading interp
        end
        pause(0.05);
    end
    slider1_Callback(hObject, eventdata, handles)
else
    warndlg('时间单一无法生成动画','提示')
end


% --------------------------------------------------------------------
function ColorBar_ClickedCallback(hObject, eventdata, handles)
% hObject    handle to ColorBar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global Cmin Cmax
if strcmp(get(handles.ColorBar,'State'),'on')
    colorbar
    caxis([Cmin Cmax]);
else
    colorbar off
end
