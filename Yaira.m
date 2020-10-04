function varargout = Yaira(varargin)
% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Yaira_OpeningFcn, ...
                   'gui_OutputFcn',  @Yaira_OutputFcn, ...
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


function Yaira_OpeningFcn(hObject, eventdata, handles, varargin)
handles.output = hObject;
guidata(hObject, handles);



function varargout = Yaira_OutputFcn(hObject, eventdata, handles) 
varargout{1} = handles.output;
warning('off','MATLAB:HandleGraphics:ObsoletedProperty:JavaFrame')
javaFrame=get(hObject,'JavaFrame'); %warning on
set(javaFrame,'Maximized',1)
set(javaFrame,'FigureIcon',javax.swing.ImageIcon('.\SigmaMeowLogo.png'))

function Yaira_CloseRequestFcn(hObject, eventdata, handles)
button=questdlg('你确定退出吗？','退出程序','确定','取消','确定');
if strcmp(button,'确定')
    delete(hObject);
end;

function Menu_File_Callback(hObject, eventdata, handles)


function Menu_File_New_Callback(hObject, eventdata, handles)
set(handles.axes1,'Position',[0.2701,0.0648,0.7052,0.8607])
set(handles.axes1,'visible','on');
set(handles.EditPanel1,'visible','on');
set(handles.EditPanel2,'visible','off');
set(handles.Table,'Visible','off')
set(handles.DataLoadPanel,'visible','off')
set(handles.Yaira,'Name','新项目(未保存)');
set(handles.ListBox,'string',{''})
set(handles.ListBox,'value',1)
List=cell(0,2);
Num=0;
saveState='Edited';
DataSourceList=[];
clear Sample*
save .\SystemData.mat '-regexp' '^[A-Z]'
set(handles.ListBox,'string',{''})
cla reset
view(3)

function Menu_File_Open_Callback(hObject, eventdata, handles)
[fileName,pathName]=uigetfile('请选择项目文件.mat');
if isstr(pathName) && isstr(fileName)
    load([pathName fileName]);
    if exist('ThreeDSampleViewer')==1
        clearvars -EXCEPT hObject handles eventdata fileName pathName
        load([pathName fileName]);
        saveState='Saved';
        save .\SystemData.mat -regexp  '^[A-Z]'
        save .\SystemData.mat -append pathName fileName
        NewClear
        set(handles.axes1,'Position',[0.2701,0.0648,0.7052,0.8607])
        set(handles.axes1,'visible','on');
        set(handles.Table,'Visible','off')
        set(handles.Table,'Enable','on')
        set(handles.DataLoadPanel,'visible','off')
        set(handles.EditPanel1,'visible','on');
        set(handles.ListBox,'string',List(:,2))
        set(handles.EditPanel2,'visible','off')
        set(handles.DataLoad,'visible','off')
        set(handles.Yaira,'Name',[fileName ' 【文件路径】' pathName]);
        ListBox_Callback(hObject, eventdata, handles)
        if exist('DataSourceList','var') && ~isempty(DataSourceList)
            Data_Read_Callback(hObject, eventdata, handles)
        end
        if exist('Time','var')
            set(handles.SampleTimeAll,'string',datestr(Time,'yyyy.mm.dd HH:MM:SS'))
        else
            set(handles.SampleTimeAll,'string',{''})
        end
        if exist('Calcu_result','var')
            set(handles.SampleDataView,'Enable','on')
        end
    else
        warndlg('非项目文件！','警告！',[0,30]);
    end
end


function Menu_File_Save_Callback(hObject, eventdata, handles)
load('.\SystemData.mat')
if exist('pathName','var')
    SaveData
else
    NewProject
    uiwait(NewProject)
    set(handles.Yaira,'Name',[fileName ' 【文件路径】' pathName])
end


function Menu_File_SaveNew_Callback(hObject, eventdata, handles)
load('.\SystemData.mat')
if ~exist('saveNew','var')
    saveNew=1;
    save '.\SystemData.mat' -append 'saveNew'
end
NewProject
uiwait(NewProject)
set(handles.Yaira,'Name',[fileName ' 【文件路径】' pathName])


function Menu_Data_Callback(hObject, eventdata, handles)


function Menu_Look_Callback(hObject, eventdata, handles)


function Data_Read_Callback(hObject, eventdata, handles)
if strcmp(get(handles.EditPanel1,'Visible'),'on')
    load .\SystemData.mat
    FreshTable
    if exist('Time','var')
        set(handles.SampleTimeAll,'string',datestr(Time,'yyyy.mm.dd HH:MM:SS'))
        b=get(handles.Kind,'value');
        sampleNumber=get(handles.ListBox,'Value');
        sampleTime=get(handles.SampleTimeAll,'Value');
        FigureShow
    end
    set(handles.DataLoadPanel,'Visible','on')
    set(handles.axes1,'Position',[0.2693,0.0576,0.4794,0.3902]);
    set(handles.Table,'Visible','on')
else
    helpdlg('请先新建或打开项目文件','温馨提示')
end


function Data_Calculate_Callback(hObject, eventdata, handles)
load .\SystemData.mat
calculation
set(handles.SampleDataView,'Enable','on')
FreshSaveData


function Menu_File_Exit_Callback(hObject, eventdata, handles)
load('.\SystemData.mat');
if ~exist('saveState','var')
    close(gcf)
elseif strcmp(saveState,'Saved')
    close(gcf)
else
    button=questdlg('未保存，确认关闭？','关闭确认','是','保存','取消','保存');
    if strcmp(button,'是')
        close(gcf)
    elseif strcmp(button,'否')
        return
    else
        Menu_File_Save_Callback(hObject, eventdata, handles)
    end
end

function Data_Devi_Way_Callback(hObject, eventdata, handles)

function Data_Devi_Role_Callback(hObject, eventdata, handles)

function Menu_Help_Callback(hObject, eventdata, handles)

function ListBox_Callback(hObject, eventdata, handles)
% Hints: contents = cellstr(get(hObject,'String')) returns ListBox contents as cell array
%        contents{get(hObject,'Value')} returns selected item from ListBox
set(handles.Kind,'value',1)
set(handles.SampointX,'value',1)
set(handles.SampointY,'value',1)
set(handles.SampointZ,'value',1)
load .\SystemData.mat
a=get(handles.ListBox,'string');
b=get(handles.Kind,'value');
sel=get(gcf,'selectiontype');
set(handles.EditPanel2,'visible','on')
set(handles.Confirm,'visible','off')
set(handles.EditPanel2,'Title','样地属性')
sampleNumber=get(handles.ListBox,'Value');
sampleEdit=List{sampleNumber,1};
eval(['set(handles.Name,''string'',' sampleEdit '.Name)'])
eval(['set(handles.Accuracy,''string'',' sampleEdit '.Accuracy)'])
eval(['set(handles.Kind,''string'',' sampleEdit '.Kind(:,1))'])
eval(['set(handles.Xmin,''string'',' sampleEdit '.Size(1,1))'])
eval(['set(handles.Xmax,''string'',' sampleEdit '.Size(1,2))'])
eval(['set(handles.Ymin,''string'',' sampleEdit '.Size(1,3))'])
eval(['set(handles.Ymax,''string'',' sampleEdit '.Size(1,4))'])
eval(['set(handles.Zmin,''string'',' sampleEdit '.Size(1,5))'])
eval(['set(handles.Zmax,''string'',' sampleEdit '.Size(1,6))'])
eval(['set(handles.SampointX,''string'',num2cell(' sampleEdit '.Kind{b,2}))'])
eval(['set(handles.SampointY,''string'',num2cell(' sampleEdit '.Kind{b,3}))'])
eval(['set(handles.SampointZ,''string'',num2cell(' sampleEdit '.Kind{b,4}))'])
eval(['set(handles.Xunits,''Value'',' sampleEdit '.Units(1,1))'])
eval(['set(handles.Yunits,''Value'',' sampleEdit '.Units(2,1))'])
eval(['set(handles.Zunits,''Value'',' sampleEdit '.Units(3,1))'])
set(handles.Name,'Enable','off')
set(handles.Accuracy,'Enable','off')
set(handles.Xmin,'Enable','off')
set(handles.Xmax,'Enable','off')
set(handles.Ymin,'Enable','off')
set(handles.Ymax,'Enable','off')
set(handles.Zmin,'Enable','off')
set(handles.Zmax,'Enable','off')
set(handles.SampointX,'Enable','off')
set(handles.SampointY,'Enable','off')
set(handles.SampointZ,'Enable','off')
set(handles.Xunits,'Enable','off')
set(handles.Yunits,'Enable','off')
set(handles.Zunits,'Enable','off')
set(handles.Kindadd,'Enable','off')
set(handles.Kinddel,'Enable','off')
set(handles.Xadd,'Enable','off')
set(handles.Xdel,'Enable','off')
set(handles.Yadd,'Enable','off')
set(handles.Ydel,'Enable','off')
set(handles.Zadd,'Enable','off')
set(handles.Zdel,'Enable','off')
if strcmp(sel,'open')
    set(handles.Confirm,'string','修改')
    set(handles.Confirm,'visible','on')
    set(handles.Name,'Enable','on')
    set(handles.Accuracy,'Enable','on')
    set(handles.Xmin,'Enable','on')
    set(handles.Xmax,'Enable','on')
    set(handles.Ymin,'Enable','on')
    set(handles.Ymax,'Enable','on')
    set(handles.Zmin,'Enable','on')
    set(handles.Zmax,'Enable','on')
    set(handles.SampointX,'Enable','on')
    set(handles.SampointY,'Enable','on')
    set(handles.SampointZ,'Enable','on')
    set(handles.Xunits,'Enable','on')
    set(handles.Yunits,'Enable','on')
    set(handles.Zunits,'Enable','on')
    set(handles.Kindadd,'Enable','on')
    set(handles.Kinddel,'Enable','on')
    set(handles.Xadd,'Enable','on')
    set(handles.Xdel,'Enable','on')
    set(handles.Yadd,'Enable','on')
    set(handles.Ydel,'Enable','on')
    set(handles.Zadd,'Enable','on')
    set(handles.Zdel,'Enable','on')
    new_sample=eval([sampleEdit '.Kind(:,2:end)']);
    save .\SystemData.mat -append new_sample
else
    if ~isempty(a{1,1})
        b=get(handles.Kind,'value');
        sampleNumber=get(handles.ListBox,'Value');
        sampleTime=get(handles.SampleTimeAll,'Value');
        FigureShow
    end
end

function ListBox_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function Add_Callback(hObject, eventdata, handles)
NewClear
button=questdlg('请选择新建方式','新建样地','单个样地','批量样地','单个样地');
if ~isempty(button)
    set(handles.Confirm,'Visible','on')
    set(handles.Confirm,'string','确定')
set(handles.Name,'Enable','on')
set(handles.Accuracy,'Enable','on')
set(handles.Kind,'Enable','on')
set(handles.Xmin,'Enable','on')
set(handles.Xmax,'Enable','on')
set(handles.Ymin,'Enable','on')
set(handles.Ymax,'Enable','on')
set(handles.Zmin,'Enable','on')
set(handles.Zmax,'Enable','on')
set(handles.SampointX,'Enable','on')
set(handles.SampointY,'Enable','on')
set(handles.SampointZ,'Enable','on')
set(handles.Xunits,'Enable','on')
set(handles.Yunits,'Enable','on')
set(handles.Zunits,'Enable','on')
set(handles.Kindadd,'Enable','on')
set(handles.Kinddel,'Enable','on')
set(handles.Xadd,'Enable','on')
set(handles.Xdel,'Enable','on')
set(handles.Yadd,'Enable','on')
set(handles.Ydel,'Enable','on')
set(handles.Zadd,'Enable','on')
set(handles.Zdel,'Enable','on')
new_sample=cell(0,3);
save .\SystemData.mat -append new_sample
    if strcmp(button,'单个样地')
        set(handles.EditPanel2,'Title','新建样地')
        set(handles.NameTxt,'string','样地名称')
        set(handles.EditPanel2,'visible','on');
        set(handles.Accuracy,'string',10)
    else
        set(handles.EditPanel2,'Title','新建样地')
        set(handles.NameTxt,'string','样地数量')
        set(handles.Name,'string',1);
        set(handles.EditPanel2,'visible','on');
        set(handles.Accuracy,'string',10)
    end
end


function Delete_Callback(hObject, eventdata, handles)
if ~isempty(get(handles.ListBox,'string'))
    load .\SystemData.mat
    DelNum=get(handles.ListBox,'Value');
    [excel_row,~]=size(get(handles.ListBox,'string'));
    DelSample=List{DelNum,1};
    DelSampleName=List{DelNum,2};
    eval(['button=questdlg(''确认删除样地【' DelSampleName '】？'',''警告'',''确认'',''取消'',''取消'');'])
    switch button
        case '确认',
            eval(['clearvars' ' ' DelSample])
            if excel_row==1
                List(DelNum,:)=[];
                set(handles.ListBox,'string',{''})
                set(handles.ListBox,'string',{''})
            else
                List(DelNum,:)=[];
                set(handles.ListBox,'string',List(:,2))
                set(handles.ListBox,'Value',1)
            end
            clearvars DelNum DelSample DelSampleName button
            save .\SystemData.mat -regexp '^[A-Z]'
        case '取消',
            return
    end
end


function Edit_Callback(hObject, eventdata, handles)


function axes1_CreateFcn(hObject, eventdata, handles)
view(3)

function Name_Callback(hObject, eventdata, handles)
% Hints: get(hObject,'String') returns contents of Name as text
%        str2double(get(hObject,'String')) returns contents of Name as a double



function Name_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Kind_Callback(hObject, eventdata, handles)
% Hints: get(hObject,'String') returns contents of Kind as text
%        str2double(get(hObject,'String')) returns contents of Kind as a double
load .\SystemData.mat
%----------------绘图部分-------------------------------------------
if strcmp(get(handles.EditPanel2,'Title'),'样地属性')
    b=get(handles.Kind,'value');
    sampleNumber=get(handles.ListBox,'Value');
    sampleTime=get(handles.SampleTimeAll,'Value');
    FigureShow
end
%------------------绘图程序结束------------------------------------------------------
sel=get(gcf,'selectiontype');
if strcmp(sel,'normal') && strcmp(get(handles.Name,'Enable'),'off')
    load .\SystemData.mat
    b=get(handles.Kind,'value');
    sampleNumber=get(handles.ListBox,'Value');
    sampleEdit=List{sampleNumber,1};
    set(handles.SampointX,'value',1)
    set(handles.SampointY,'value',1)
    set(handles.SampointZ,'value',1)
    eval(['set(handles.SampointX,''string'',num2cell(' sampleEdit '.Kind{b,2}))'])
    eval(['set(handles.SampointY,''string'',num2cell(' sampleEdit '.Kind{b,3}))'])
    eval(['set(handles.SampointZ,''string'',num2cell(' sampleEdit '.Kind{b,4}))'])
    %ListBox_Callback(hObject, eventdata, handles)
end
if strcmp(sel,'normal') && strcmp(get(handles.Name,'Enable'),'on')
    load .\SystemData.mat
    if exist('new_sample','var') && size(new_sample,1)~=0
        b=get(handles.Kind,'value');
        set(handles.SampointX,'value',1)
        set(handles.SampointY,'value',1)
        set(handles.SampointZ,'value',1)
        %设置XYZ采样点为new_sample对应的值
        %Add set new_sample cell(0:3)
        set(handles.SampointX,'string',new_sample(b,1))
        set(handles.SampointY,'string',new_sample(b,2))
        set(handles.SampointZ,'string',new_sample(b,3))
    end
end
if strcmp(get(handles.Name,'Enable'),'on')
    if strcmp(sel,'open')
        XYZList=get(handles.Kind,'string');
        RankNum=get(handles.Kind,'Value');
        XYZEdit=inputdlg('请输入采样点(纯数字形式)','修改采样点',[1 40]);
        if ~isempty(XYZEdit)
        XYZList{RankNum,1}=cell2mat(XYZEdit);
        set(handles.Kind,'string',XYZList);
        end
    end
    
end



function Kind_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Accuracy_Callback(hObject, eventdata, handles)


function Accuracy_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function Xmin_Callback(hObject, eventdata, handles)


function Xmin_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Ymin_Callback(hObject, eventdata, handles)


function Ymin_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function Zmin_Callback(hObject, eventdata, handles)


function Zmin_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function Xmax_Callback(hObject, eventdata, handles)


function Xmax_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function Ymax_Callback(hObject, eventdata, handles)


function Ymax_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function Zmax_Callback(hObject, eventdata, handles)


function Zmax_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function Xunits_Callback(hObject, eventdata, handles)


function Xunits_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function Yunits_Callback(hObject, eventdata, handles)

function Yunits_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function Zunits_Callback(hObject, eventdata, handles)

function Zunits_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function Confirm_Callback(hObject, eventdata, handles)
if strcmp(get(handles.Confirm,'string'),'修改')
    load('.\SystemData.mat');
    Name=get(handles.Name,'string');
    Accuracy=str2double(get(handles.Accuracy,'string'));
    Kind=get(handles.Kind,'string');
    Xmin=str2double(get(handles.Xmin,'string'));
    Xmax=str2double(get(handles.Xmax,'string'));
    Ymin=str2double(get(handles.Ymin,'string'));
    Ymax=str2double(get(handles.Ymax,'string'));
    Zmin=str2double(get(handles.Zmin,'string'));
    Zmax=str2double(get(handles.Zmax,'string'));
    Xunits=get(handles.Xunits,'value');
    Yunits=get(handles.Yunits,'value');
    Zunits=get(handles.Zunits,'value');
    SampointX=cellfun(@str2double,get(handles.SampointX,'string'));
    SampointY=cellfun(@str2double,get(handles.SampointY,'string'));
    SampointZ=cellfun(@str2double,get(handles.SampointZ,'string'));
    if isnan(Xmin) || isnan(Xmax) || isnan(Ymin) || isnan(Ymax) || isnan(Zmin) || isnan(Zmax)
        warndlg('请在样地范围输入数字！','警告',[0,30])
    elseif isnan(SampointX(1,1)) || isnan(SampointY(1,1)) || isnan(SampointZ(1,1))
        warndlg('请在采样点输入数字！','警告',[0,30])
    elseif Xmin>=Xmax
        warndlg('样地长度最小值应<最大值！','警告',[0,30])
    elseif Ymin>=Ymax
        warndlg('样地宽度最小值应<最大值！','警告',[0,30])
    elseif Zmin>=Zmax
        warndlg('样地高度(深度)最小值应<最大值！','警告',[0,30])
    elseif max(SampointX)>Xmax || min(SampointX)<Xmin
        warndlg('X采样点应该在样地范围之内！','警告',[0,30])
    elseif max(SampointY)>Ymax || min(SampointY)<Ymin
        warndlg('Y采样点应该在样地范围之内！','警告',[0,30])
    elseif max(SampointZ)>Zmax || min(SampointZ)<Zmin
        warndlg('Z采样点应该在样地范围之内！','警告',[0,30])
    elseif size(SampointX,1)>Accuracy || size(SampointY,1)>Accuracy || size(SampointZ,1)>Accuracy
        warndlg('插值格数应该大余最大采样点数！','警告',[0,30])
    elseif Accuracy>30
        warndlg('插值格数大于30，内存容易溢出！','警告',[0,30])
    else
        b=get(handles.Kind,'value');
        sampleNumber=get(handles.ListBox,'Value');
        sampleEdit=List{sampleNumber,1};
        	eval([sampleEdit '.Name=' '''' Name ''';']);
            eval([sampleEdit '.Size=' '[' num2str(Xmin) ' ' num2str(Xmax) ' ' num2str(Ymin) ' ' num2str(Ymax)...
                ' ' num2str(Zmin) ' ' num2str(Zmax) '];']);
            eval([sampleEdit '.Accuracy=' 'Accuracy;']);
            eval([sampleEdit '.Kind(:,1)=' 'Kind'  ';']);
            eval([sampleEdit '.Kind=[' sampleEdit '.Kind(:,1),' 'new_sample' '];'])
            eval([sampleEdit '.Units=' '[' num2str(Xunits) ';' num2str(Yunits) ';' num2str(Zunits) '];']);
            List{sampleNumber,2}=eval([sampleEdit '.Name']);
            set(handles.ListBox,'string',List(:,2))
            eval(['save .\SystemData.mat -append ' sampleEdit ' List'])
            FreshSaveData
            ListBox_Callback(hObject, eventdata, handles)
    end
end
%% 判断是否是新建
if strcmp(get(handles.Confirm,'string'),'确定')
    if isempty(get(handles.Name,'string'))
        warndlg('请填写样地名称！','警告！',[0,30]);
    elseif isempty(get(handles.Accuracy,'string'))
        warndlg('请填写插值精度！','警告！',[0,30]);
    elseif isequal(get(handles.Kind,'string'),{''})
        warndlg('请填写项目种类！','警告！',[0,30]);
    elseif isempty(get(handles.Xmin,'string'))...
            || isempty(get(handles.Xmin,'string'))...
            || isempty(get(handles.Xmax,'string'))...
            || isempty(get(handles.Ymin,'string'))...
            || isempty(get(handles.Ymax,'string'))...
            || isempty(get(handles.Zmin,'string'))...
            || isempty(get(handles.Zmax,'string'))
        warndlg('请填写样地长范围','警告！',[0,30])
    elseif isequal(get(handles.SampointX,'string'),{''})...
            ||isequal(get(handles.SampointY,'string'),{''})...
            ||isequal(get(handles.SampointZ,'string'),{''})
        warndlg('请填写采样点','警告！',[0,30])
    else
        load('.\SystemData.mat');
        if exist('Num','var')
            Num=Num;
        else
            Num=0;
            List=cell(0,2);
            save .\SystemData.mat -append Num List
        end
        Name=get(handles.Name,'string');
        Accuracy=str2double(get(handles.Accuracy,'string'));
        Kind=get(handles.Kind,'string');
        line=size(Kind,1);
        Xmin=str2double(get(handles.Xmin,'string'));
        Xmax=str2double(get(handles.Xmax,'string'));
        Ymin=str2double(get(handles.Ymin,'string'));
        Ymax=str2double(get(handles.Ymax,'string'));
        Zmin=str2double(get(handles.Zmin,'string'));
        Zmax=str2double(get(handles.Zmax,'string'));
        Xunits=get(handles.Xunits,'value');
        Yunits=get(handles.Yunits,'value');
        Zunits=get(handles.Zunits,'value');
        SampointX=cellfun(@str2double,get(handles.SampointX,'string'));
        SampointY=cellfun(@str2double,get(handles.SampointY,'string'));
        SampointZ=cellfun(@str2double,get(handles.SampointZ,'string'));
        if isnan(Xmin) || isnan(Xmax) || isnan(Ymin) || isnan(Ymax) || isnan(Zmin) || isnan(Zmax)
            warndlg('请在样地范围输入数字！','警告',[0,30])
        elseif isnan(SampointX(1,1)) || isnan(SampointY(1,1)) || isnan(SampointZ(1,1))
            warndlg('请在采样点输入数字！','警告',[0,30])
        elseif Xmin>=Xmax
            warndlg('样地长度最小值应<最大值！','警告',[0,30])
        elseif Ymin>=Ymax
            warndlg('样地宽度最小值应<最大值！','警告',[0,30])
        elseif Zmin>=Zmax
            warndlg('样地高度(深度)最小值应<最大值！','警告',[0,30])
        elseif max(SampointX)>Xmax || min(SampointX)<Xmin
            warndlg('X采样点应该在样地范围之内！','警告',[0,30])
        elseif max(SampointY)>Ymax || min(SampointY)<Ymin
            warndlg('Y采样点应该在样地范围之内！','警告',[0,30])
        elseif max(SampointZ)>Zmax || min(SampointZ)<Zmin
            warndlg('Z采样点应该在样地范围之内！','警告',[0,30])
        elseif size(SampointX,1)>Accuracy || size(SampointY,1)>Accuracy || size(SampointZ,1)>Accuracy
            warndlg('插值格数应该大余最大采样点数！','警告',[0,30])
        elseif Accuracy>30
            warndlg('插值格数大于30，内存容易溢出！','警告',[0,30])
        else
            if strcmp(get(handles.NameTxt,'string'),'样地名称')
                eval(['Sample' num2str(Num+1) '.Kind=' 'cell(' num2str(line) ',9)'  ';'])
                eval(['Sample' num2str(Num+1) '.Name=' '''' Name ''';']);
                eval(['Sample' num2str(Num+1) '.Size=' '[' num2str(Xmin) ' ' num2str(Xmax) ' ' num2str(Ymin) ' ' num2str(Ymax)...
                    ' ' num2str(Zmin) ' ' num2str(Zmax) '];']);
                eval(['Sample' num2str(Num+1) '.Accuracy=' 'Accuracy;']);
                eval(['Sample' num2str(Num+1) '.Kind(:,1)=' 'Kind'  ';']);
                eval(['Sample' num2str(Num+1) '.Kind(:,2:4)=' 'new_sample' ';'])
                eval(['Sample' num2str(Num+1) '.Units=' '[' num2str(Xunits) ';' num2str(Yunits) ';' num2str(Zunits) '];']);
                [Row,~]=size(List);
                List{Row+1,1}=['Sample' num2str(Num+1)];
                List{Row+1,2}=eval(['Sample' num2str(Num+1) '.Name']);
                set(handles.ListBox,'string',List(:,2))
                set(handles.EditPanel2,'visible','off');
                Num=Num+1;
            else
                Name=str2double(get(handles.Name,'string'));
                for Num=Num:Num+Name-1
                    eval(['Sample' num2str(Num+1) '.Kind=' 'cell(' num2str(line) ',9)'  ';'])
                    eval(['Sample' num2str(Num+1) '.Name=' '''批量样地' num2str(Num+1) ''';']);
                    eval(['Sample' num2str(Num+1) '.Size=' '[' num2str(Xmin) ' ' num2str(Xmax) ' ' num2str(Ymin) ' ' num2str(Ymax)...
                        ' ' num2str(Zmin) ' ' num2str(Zmax) '];']);
                    
                    eval(['Sample' num2str(Num+1) '.Accuracy=' 'Accuracy;'])
                    eval(['Sample' num2str(Num+1) '.Kind(:,1)=' 'Kind'  ';'])
                    eval(['Sample' num2str(Num+1) '.Kind(:,2:4)=' 'new_sample' ';'])
                    eval(['Sample' num2str(Num+1) '.Units=' '[' num2str(Xunits) ';' num2str(Yunits) ';' num2str(Zunits) '];'])
                    [Row,~]=size(List);
                    List{Row+1,1}=['Sample' num2str(Num+1)];
                    List{Row+1,2}=eval(['Sample' num2str(Num+1) '.Name']);
                    set(handles.ListBox,'string',List(:,2))
                end
                Num=Num+1;
                set(handles.EditPanel2,'visible','off');
            end
            save .\SystemData.mat -append Sample* Num List
            FreshSaveData
        end
    end
end
%% 判断是否为修改采样点
if strcmp(get(handles.Confirm,'string'),'赋值')
    SampointX=cellfun(@str2double,get(handles.SampointX,'string'));
    SampointY=cellfun(@str2double,get(handles.SampointY,'string'));
    SampointZ=cellfun(@str2double,get(handles.SampointZ,'string'));
    Xmin=str2double(get(handles.Xmin,'string'));
    Xmax=str2double(get(handles.Xmax,'string'));
    Ymin=str2double(get(handles.Ymin,'string'));
    Ymax=str2double(get(handles.Ymax,'string'));
    Zmin=str2double(get(handles.Zmin,'string'));
    Zmax=str2double(get(handles.Zmax,'string'));
    Accuracy=str2double(get(handles.Accuracy,'string'));
    if isempty(get(handles.Name,'string'))
        warndlg('请填写样地名称！','警告！',[0,30]);
    elseif isempty(get(handles.Accuracy,'string'))
        warndlg('请填写插值精度！','警告！',[0,30]);
    elseif isequal(get(handles.Kind,'string'),{''})
        warndlg('请填写项目种类！','警告！',[0,30]);
    elseif isempty(get(handles.Xmin,'string'))...
            || isempty(get(handles.Xmin,'string'))...
            || isempty(get(handles.Xmax,'string'))...
            || isempty(get(handles.Ymin,'string'))...
            || isempty(get(handles.Ymax,'string'))...
            || isempty(get(handles.Zmin,'string'))...
            || isempty(get(handles.Zmax,'string'))
        warndlg('请填写样地长范围','警告！',[0,30])
    elseif isequal(get(handles.SampointX,'string'),{''})...
            ||isequal(get(handles.SampointY,'string'),{''})...
            ||isequal(get(handles.SampointZ,'string'),{''})
        warndlg('请填写采样点','警告！',[0,30])
    elseif max(SampointX)>Xmax || min(SampointX)<Xmin
        warndlg('X采样点应该在样地范围之内！','警告',[0,30])
    elseif max(SampointY)>Ymax || min(SampointY)<Ymin
        warndlg('Y采样点应该在样地范围之内！','警告',[0,30])
    elseif max(SampointZ)>Zmax || min(SampointZ)<Zmin
        warndlg('Z采样点应该在样地范围之内！','警告',[0,30])
    elseif size(SampointX,1)>Accuracy || size(SampointY,1)>Accuracy || size(SampointZ,1)>Accuracy
        warndlg('插值格数应该大余最大采样点数！','警告',[0,30])
    elseif Accuracy>30
        warndlg('插值格数大于30，内存容易溢出！','警告',[0,30])
    else
        load .\SystemData.mat new_sample
        line=get(handles.Kind,'value');
        if strcmp(get(handles.EditPanel2,'Title'),'新建样地')
            [line_new_sample,~]=size(new_sample);
            if line_new_sample<line
                new_sample{line,1}=SampointX;
                new_sample{line,2}=SampointY;
                new_sample{line,3}=SampointZ;
            else
                new_sample=[new_sample(1:line-1,:);{SampointX},{SampointY},{SampointZ};new_sample(line:end,:)];
            end
        end
        if strcmp(get(handles.EditPanel2,'Title'),'样地属性')
            new_sample{line,1}=SampointX;
            new_sample{line,2}=SampointY;
            new_sample{line,3}=SampointZ;
        end
        save .\SystemData.mat -append new_sample
        set(handles.Kindadd,'Enable','on')
        set(handles.Kind,'Enable','on')
        set(handles.Kinddel,'Enable','on')
        set(handles.Same2up,'Visible','off')
        if strcmp(get(handles.EditPanel2,'Title'),'新建样地')
            set(handles.Confirm,'string','确定')
        else
            set(handles.Confirm,'string','修改')
        end
    end
end
FreshSaveData
set(handles.SampleDataView,'enable','off')

function Yaira_CreateFcn(hObject, eventdata, handles)
clear
save SystemData


function SampointX_Callback(hObject, eventdata, handles)
sel=get(gcf,'selectiontype');
if strcmp(sel,'open')
    set(handles.Confirm,'string','赋值')
    XYZList=get(handles.SampointX,'string');
    RankNum=get(handles.SampointX,'Value');
    XYZEdit=inputdlg('请输入采样点(纯数字形式)','修改采样点',[1 40]);
    if ~isempty(XYZEdit)
    XYZList{RankNum,1}=cell2mat(XYZEdit);
    set(handles.SampointX,'string',XYZList);
    end
end


function SampointX_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function SampointY_Callback(hObject, eventdata, handles)
sel=get(gcf,'selectiontype');
if strcmp(sel,'open')
    set(handles.Confirm,'string','赋值')
    XYZList=get(handles.SampointY,'string');
    RankNum=get(handles.SampointY,'Value');
    XYZEdit=inputdlg('请输入采样点(纯数字形式)','修改采样点',[1 40]);
    if ~isempty(XYZEdit)
    XYZList{RankNum,1}=cell2mat(XYZEdit);
    set(handles.SampointY,'string',XYZList);
    end
end

function SampointY_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function SampointZ_Callback(hObject, eventdata, handles)
sel=get(gcf,'selectiontype');
if strcmp(sel,'open')
    set(handles.Confirm,'string','赋值')
    XYZList=get(handles.SampointZ,'string');
    RankNum=get(handles.SampointZ,'Value');
    XYZEdit=inputdlg('请输入采样点(纯数字形式)','修改采样点',[1 40]);
    if ~isempty(XYZEdit)
    XYZList{RankNum,1}=cell2mat(XYZEdit);
    set(handles.SampointZ,'string',XYZList);
    end
end

function SampointZ_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function Xadd_Callback(hObject, eventdata, handles)
XYZAdd=inputdlg('请输入采样点(纯数字形式)','增加采样点',[1 40]);
if ~isempty(XYZAdd) && ~isempty(XYZAdd{1})
XYZList=get(handles.SampointX,'string');
RankNum=get(handles.SampointX,'Value');
[XlistNum,XlistCol]=size(XYZList);
if XlistCol==0 || isempty(XYZList{1,1})
    XYZList{XlistNum,1}=cell2mat(XYZAdd);
else
    if RankNum==XlistNum
        XYZList{XlistNum+1,1}=cell2mat(XYZAdd);
    else
        XYZList=[XYZList(1:RankNum,:);XYZAdd;XYZList(RankNum+1:end,:)];
    end
    set(handles.SampointX,'Value',RankNum+1)
end
set(handles.SampointX,'string',XYZList);
set(handles.Confirm,'string','赋值')
end


function Xdel_Callback(hObject, eventdata, handles)
XYZList=get(handles.SampointX,'string');
[XlistNum,~]=size(XYZList);
Row=get(handles.SampointX,'value');
if XlistNum~=1
    XYZList(Row,:)=[];
else
    XYZList={''};
end
if Row~=1
set(handles.SampointX,'value',Row-1);
end
set(handles.SampointX,'string',XYZList);
set(handles.Confirm,'string','赋值')


function Yadd_Callback(hObject, eventdata, handles)
XYZAdd=inputdlg('请输入采样点(纯数字形式)','增加采样点',[1 40]);
if ~isempty(XYZAdd) && ~isempty(XYZAdd{1})
XYZList=get(handles.SampointY,'string');
RankNum=get(handles.SampointY,'Value');
[XlistNum,XlistCol]=size(XYZList);
if XlistCol==0 || isempty(XYZList{1,1})
    XYZList{XlistNum,1}=cell2mat(XYZAdd);
else
    if RankNum==XlistNum
        XYZList{XlistNum+1,1}=cell2mat(XYZAdd);
    else
        XYZList=[XYZList(1:RankNum,:);XYZAdd;XYZList(RankNum+1:end,:)];
    end
    set(handles.SampointY,'Value',RankNum+1)
end
set(handles.SampointY,'string',XYZList);
set(handles.Confirm,'string','赋值')
end


function Ydel_Callback(hObject, eventdata, handles)
XYZList=get(handles.SampointY,'string');
[XlistNum,~]=size(XYZList);
Row=get(handles.SampointY,'value');
if XlistNum~=1
    XYZList(Row,:)=[];
else
    XYZList={''};
end
if Row~=1
set(handles.SampointY,'value',Row-1);
end
set(handles.SampointY,'string',XYZList);
set(handles.Confirm,'string','赋值')


function Zadd_Callback(hObject, eventdata, handles)
XYZAdd=inputdlg('请输入采样点(纯数字形式)','增加采样点',[1 40]);
if ~isempty(XYZAdd) && ~isempty(XYZAdd{1})
XYZList=get(handles.SampointZ,'string');
RankNum=get(handles.SampointZ,'Value');
[XlistNum,XlistCol]=size(XYZList);
if XlistCol==0 || isempty(XYZList{1,1})
    XYZList{XlistNum,1}=cell2mat(XYZAdd);
else
    if RankNum==XlistNum
        XYZList{XlistNum+1,1}=cell2mat(XYZAdd);
    else
        XYZList=[XYZList(1:RankNum,:);XYZAdd;XYZList(RankNum+1:end,:)];
    end
    set(handles.SampointZ,'Value',RankNum+1)
end
set(handles.SampointZ,'string',XYZList);
set(handles.Confirm,'string','赋值')
end


function Zdel_Callback(hObject, eventdata, handles)
XYZList=get(handles.SampointZ,'string');
[XlistNum,~]=size(XYZList);
Row=get(handles.SampointZ,'value');
if XlistNum~=1
    XYZList(Row,:)=[];
else
    XYZList={''};
end
if Row~=1
set(handles.SampointZ,'value',Row-1);
end
set(handles.SampointZ,'string',XYZList);
set(handles.Confirm,'string','赋值')


function Kindadd_Callback(hObject, eventdata, handles)
XYZAdd=inputdlg('请输入项目种类','增加项目种类',[1 40]);
if ~isempty(XYZAdd) && ~isempty(XYZAdd{1})
XYZList=get(handles.Kind,'string');
RankNum=get(handles.Kind,'Value');
[XlistNum,XlistCol]=size(XYZList);
%save 'XYZList.mat' 'XYZList'
set(handles.Kindadd,'Enable','off')
set(handles.Kind,'Enable','off')
set(handles.Kinddel,'Enable','off')
set(handles.Same2up,'Visible','on')
if XlistCol==0 || isempty(XYZList{1,1})
    XYZList{XlistNum,1}=cell2mat(XYZAdd);
else
    if RankNum==XlistNum
        XYZList{XlistNum+1,1}=cell2mat(XYZAdd);
    else
        XYZList=[XYZList(1:RankNum,:);XYZAdd;XYZList(RankNum+1:end,:)];
    end
    set(handles.Kind,'Value',RankNum+1)
end
set(handles.Kind,'string',XYZList);
set(handles.Confirm,'string','赋值');
set(handles.SampointX,'string',{''});
set(handles.SampointX,'Value',1);
set(handles.SampointY,'string',{''});
set(handles.SampointY,'Value',1);
set(handles.SampointZ,'string',{''});
set(handles.SampointZ,'Value',1);
end


function Kinddel_Callback(hObject, eventdata, handles)
load .\SystemData.mat new_sample
XYZList=get(handles.Kind,'string');
[XlistNum,~]=size(XYZList);
Row=get(handles.Kind,'value');
if XlistNum~=1
    XYZList(Row,:)=[];
else
    XYZList={''};
end
if Row~=1
set(handles.Kind,'value',Row-1);
end
set(handles.Kind,'string',XYZList);
new_sample(Row,:)=[];
save .\SystemData.mat -append new_sample

function ExcelName_Callback(hObject, eventdata, handles)
load .\SystemData.mat
set(handles.ExcelSheet,'value',1)
FreshTable


% Hints: contents = cellstr(get(hObject,'String')) returns ExcelName contents as cell array
%        contents{get(hObject,'Value')} returns selected item from ExcelName


% --- Executes during object creation, after setting all properties.
function ExcelName_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function ExcelAdd_Callback(hObject, eventdata, handles)
load .\SystemData.mat
if exist('Num','var') && Num>=1
    if exist('DataSourceList','var') && ~isempty(DataSourceList)
        [filerow,~]=size(DataSourceList);
    else
        DataSourceList=cell(0,5);
        [filerow,~]=size(DataSourceList);
        save .\SystemData.mat -append DataSourceList
    end
    [filename,pathname]=uigetfile({'*.xlsx';'*.xls'},'选择Excel文件','MultiSelect','on');
    if ~isnumeric(filename) && ~isnumeric(pathname)
    filename=cellstr(filename);
    [~,filenum]=size(filename);
        for i=1:filenum
            [~,colfile]=find(strcmp(DataSourceList(:,2),filename{1,i}));
            [~,colpath]=find(strcmp(DataSourceList(:,1),pathname));
            %[~,colfile]=find(cellfun(@(x) strcmp(x,filename{1,i}),DataSourceList));
            %[~,colpath]=find(cellfun(@(x) strcmp(x,pathname),DataSourceList));
            %[~,colfile]=cellfun(@(x)find(strcmp(filename{1,i},x)),DataSourceList(:,2),'UniformOutput' ,false);
            %[~,colpath]=cellfun(@(x)find(strcmp(pathname,x)),DataSourceList(:,1),'UniformOutput' ,false);
            if ~isempty(colfile) && ~isempty(colpath)
                filename(:,i)={0};
            end
        end
        hwaitbar=waitbar(0,'数据正在全力搬运，请稍后','Name','读取中');
        for i=1:filenum
            %waitbar(i/filenum,hwaitbar,['读取完成' num2str(floor((i/filenum)*100)) '%'])
            if filename{1,i}==0
                %helpdlg('已跳过重复的表格','温馨提示')
                continue
            end
            DataSourceList(filerow+1,1)=cellstr(pathname);
            DataSourceList(filerow+1,2)=filename(1,i);
            DataSourceList{filerow+1,3}=['【' DataSourceList{filerow+1,2} '】' DataSourceList{filerow+1,1}];
            [~, desc] = xlsfinfo([DataSourceList{filerow+1,1},DataSourceList{filerow+1,2}]);
            DataSourceList{filerow+1,4}=desc;
            n=length(desc);
            data=cell(n,1);
            for t=1:n
                waitbar((i-1)/filenum+1/filenum*((t-1)/n),hwaitbar)
                [~,~,data{t,1}]=xlsread([DataSourceList{filerow+1,1},DataSourceList{filerow+1,2}],desc{t});
                for m=1:numel(data{t,1})
                    if isnan(data{t,1}{m})
                        data{t,1}{m}='';
                    end
                end
                DataSourceList{filerow+1,5}=data;
            end
            filerow=filerow+1;
        end
        delete(hwaitbar);
        clear hwaitbar;
        save .\SystemData.mat -append DataSourceList
        set(handles.ExcelName,'string',DataSourceList(:,3))
        set(handles.ExcelSheet,'string',DataSourceList{1,4}')
        FreshSaveData
    end
    FreshTable
else
    warndlg('尚无样地数据，请新建样地！','警告',[0,30])
end


function ExcelDel_Callback(hObject, eventdata, handles)
if ~isempty(get(handles.ExcelName,'string'))
    load .\SystemData.mat
    DelNum=get(handles.ExcelName,'Value');
    DelSampleName=DataSourceList{DelNum,2};
    eval(['button=questdlg(''确认删除数据源【' DelSampleName '】？(不会删除源文件)'',''警告'',''确认'',''取消'',''取消'');'])
    switch button
        case '确认',
            [excel_row,~]=size(get(handles.ExcelName,'string'));
            if excel_row==1
                DataSourceList(DelNum,:)=[];
                set(handles.ExcelName,'string',{''})
                set(handles.ExcelSheet,'string',{''})
            else
                DataSourceList(DelNum,:)=[];
                set(handles.ExcelName,'string',DataSourceList(:,3))
                set(handles.ExcelName,'value',1);
                excel_num=get(handles.ExcelName,'value');
                set(handles.ExcelSheet,'string',DataSourceList{excel_num,4}')
            end
            set(handles.ExcelName,'Value',1)
            clearvars DelNum button DelSampleName
            save .\SystemData.mat -regexp '^[A-Z]'
        case '取消',
            return
    end
    FreshTable
end

% --- Executes on selection change in ExcelSheet.
function ExcelSheet_Callback(hObject, eventdata, handles)
load .\SystemData.mat
FreshTable
% Hints: contents = cellstr(get(hObject,'String')) returns ExcelSheet contents as cell array
%        contents{get(hObject,'Value')} returns selected item from ExcelSheet


function ExcelSheet_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in CloseDataPanel.
function CloseDataPanel_Callback(hObject, eventdata, handles)
% hObject    handle to CloseDataPanel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.DataLoadPanel,'Visible','off')
set(handles.axes1,'Position',[0.2701,0.0648,0.7052,0.8607]);
set(handles.Table,'Visible','off')
set(handles.Table,'Enable','on')
set(handles.DataLoad,'visible','off')
set(handles.ExcelName,'Enable','on')
set(handles.ExcelSheet,'Enable','on')
set(handles.ExcelAdd,'Enable','on')
set(handles.ExcelDel,'Enable','on')


% --------------------------------------------------------------------
function AddData2_Callback(hObject, eventdata, handles)
% hObject    handle to AddData2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
load .\SystemData.mat
global load_row load_col
if load_row~=0
    if exist('Time','var')
        set(handles.SampleTimeAll,'String',datestr(Time,'yyyy.mm.dd HH:MM:SS'))
    end
    set(handles.DataLoad,'visible','on')
    set(handles.Table,'Enable','off')
    set(handles.ExcelName,'Enable','off')
    set(handles.ExcelSheet,'Enable','off')
    set(handles.ExcelAdd,'Enable','off')
    set(handles.ExcelDel,'Enable','off')
    set(handles.ConfirmData,'Enable','off')
    set(handles.SampleChoice,'string',List(:,2))
    rank=get(handles.SampleChoice,'value');
    kind=get(handles.KindChoice,'value');
    sample_name=List{rank,1};
    eval(['set(handles.KindChoice,''string'',' sample_name '.Kind(:,1));'])
    %set(handles.SampleTimeAll,'string',datestr(Time,'yyyy.mm.dd'))
    if eval(['~isempty(datestr(' sample_name '.Kind{kind,5}))'])
        eval(['set(handles.SampleTime,''string'',datestr(' sample_name '.Kind{kind,5},''yyyy.mm.dd HH:MM:SS''));'])
    end
    b=get(handles.Kind,'value');
    sampleNumber=get(handles.ListBox,'Value');
    sampleTime=get(handles.SampleTime,'Value');
    FigureShow
else
    warndlg('请选择要导入的采样点','警告')
end
%mLine=get(eventdata.Table,Indices(1));
%save mline.mat mLine

% --------------------------------------------------------------------
function ContextMenu_Callback(hObject, eventdata, handles)
% hObject    handle to ContextMenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function uipushtool1_ClickedCallback(hObject, eventdata, handles)
% hObject    handle to uipushtool1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
ListBox_Callback(hObject, eventdata, handles)


% --- Executes when selected cell(s) is changed in Table.
function Table_CellSelectionCallback(hObject, eventdata, handles)
% hObject    handle to Table (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.TABLE)
%	Indices: row and column indices of the cell(s) currently selecteds
% handles    structure with handles and user data (see GUIDATA)
global load_row load_col
load_row=eventdata.Indices(:,1);
load_col=eventdata.Indices(:,2);
%save Points.mat load_row load_col


% --- Executes on selection change in SampleChoice.
function SampleChoice_Callback(hObject, eventdata, handles)
% hObject    handle to SampleChoice (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
SampleTimeShow
b=get(handles.KindChoice,'value');
sampleNumber=get(handles.SampleChoice,'Value');
set(handles.ConfirmData,'Enable','off')
set(handles.SampleTime,'value',1)
sampleTime=get(handles.SampleTime,'value');
FigureShow
% Hints: contents = cellstr(get(hObject,'String')) returns SampleChoice contents as cell array
%        contents{get(hObject,'Value')} returns selected item from SampleChoice


% --- Executes during object creation, after setting all properties.
function SampleChoice_CreateFcn(hObject, eventdata, handles)
% hObject    handle to SampleChoice (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in KindChoice.
function KindChoice_Callback(hObject, eventdata, handles)
% hObject    handle to KindChoice (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
SampleTimeShow
b=get(handles.KindChoice,'value');
sampleNumber=get(handles.SampleChoice,'Value');
sampleTime=get(handles.SampleTime,'Value');
set(handles.ConfirmData,'Enable','off')
FigureShow
% Hints: contents = cellstr(get(hObject,'String')) returns KindChoice contents as cell array
%        contents{get(hObject,'Value')} returns selected item from KindChoice


% --- Executes during object creation, after setting all properties.
function KindChoice_CreateFcn(hObject, eventdata, handles)
% hObject    handle to KindChoice (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in TimeAdd.
function TimeAdd_Callback(hObject, eventdata, handles)
% hObject    handle to TimeAdd (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%[Date]=ChooseDate;
Date=inputdlg('输入时间：(时间格式为2015/06/23 10:23:45)','添加采样时间');
if ~isempty(Date)
    Date=datenum(Date);
    load .\SystemData.mat
    if exist('Time','var')
        load .\SystemData.mat Time
    else
        Time=zeros(0,1);
    end
    if ~isempty(Date)
        RankNum=get(handles.SampleTimeAll,'Value');
        [row,~]=size(Time);
        if row==0
            Time(row+1,1)=Date;
        else
            if RankNum==row
                Time(row+1,1)=Date;
            else
                Time=[Time(1:RankNum,:);Date;Time(RankNum+1:end,:)];
            end
            set(handles.SampleTimeAll,'Value',RankNum+1)
        end
        Time=sort(Time);
        set(handles.SampleTimeAll,'string',datestr(Time,'yyyy.mm.dd HH:MM:SS'))
        save .\SystemData.mat -append Time
        FreshSaveData
    end
end

% --- Executes on button press in TimeDelete.
function TimeDelete_Callback(hObject, eventdata, handles)
% hObject    handle to TimeDelete (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
load .\SystemData.mat
if exist('Time','var')
    [row,~]=size(Time);
    del_row=get(handles.SampleTimeAll,'value');
    if row~=0
    Time(del_row,:)=[];
    end
    [row,~]=size(Time);
    if row==0
        set(handles.SampleTimeAll,'value',1);
        set(handles.SampleTimeAll,'string',{''});
    else
        set(handles.SampleTimeAll,'value',1);
        set(handles.SampleTimeAll,'string',datestr(Time,'yyyy.mm.dd HH:MM:SS'));
    end
save .\SystemData.mat -append Time
FreshSaveData
end

% --- Executes on selection change in SampleTimeAll.
function SampleTimeAll_Callback(hObject, eventdata, handles)
% hObject    handle to SampleTimeAll (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
load .\SystemData.mat
if strcmp(get(handles.DataLoad,'Visible'),'on')
    if isequal(get(gcf,'selectiontype'),'open')
        n=get(handles.SampleTimeAll,'value');
        add_time=Time(n);
        rank=get(handles.SampleChoice,'value');
        kind=get(handles.KindChoice,'value');
        sample_name=List{rank,1};
        eval(['have_time=' sample_name '.Kind{kind,5};'])
        if isempty(find(have_time==add_time, 1))
            have_time=[have_time;add_time];
            have_time=sort(have_time);
            eval([sample_name '.Kind{kind,5}=have_time;'])
            b=get(handles.KindChoice,'value');
            eval([sample_name '.Kind{kind,6}=nan(size(' sample_name '.Kind{b,3},1),size(' sample_name '.Kind{b,2},1),size(' sample_name '.Kind{b,4},1),size(have_time,1));'])
            save .\SystemData.mat -append Sample*
            SampleTimeShow
        end
    end
else
    b=get(handles.Kind,'value');
    sampleNumber=get(handles.ListBox,'Value');
    sampleTime=get(handles.SampleTimeAll,'Value');
    FigureShow
end
    
% Hints: contents = cellstr(get(hObject,'String')) returns SampleTimeAll contents as cell array
%        contents{get(hObject,'Value')} returns selected item from SampleTimeAll

function SampleTime_Callback(hObject, eventdata, handles)
load .\SystemData.mat
b=get(handles.KindChoice,'value');
sampleNumber=get(handles.SampleChoice,'Value');
sampleTime=get(handles.SampleTime,'Value');
FigureShow
if isequal(get(gcf,'selectiontype'),'open')
    n=get(handles.SampleTime,'value');
    rank=get(handles.SampleChoice,'value');
    kind=get(handles.KindChoice,'value');
    sample_name=List{rank,1};
    eval(['have_time=' sample_name '.Kind{kind,5};'])
    have_time(n)=[];
    eval([sample_name '.Kind{kind,5}=have_time;'])
    b=get(handles.KindChoice,'value');
    eval([sample_name '.Kind{kind,6}=nan(size(' sample_name '.Kind{b,3},1),size(' sample_name '.Kind{b,2},1),size(' sample_name '.Kind{b,4},1),size(have_time,1));'])
    save .\SystemData.mat -append Sample*
    SampleTimeShow
    set(handles.SampleTime,'Value',max(1,n-1))
    FreshSaveData
end

% --- Executes during object creation, after setting all properties.
function SampleTimeAll_CreateFcn(hObject, eventdata, handles)
% hObject    handle to SampleTimeAll (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in Xdirection.
function Xdirection_Callback(hObject, eventdata, handles)
% hObject    handle to Xdirection (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.ConfirmData,'Enable','off')
% Hints: contents = cellstr(get(hObject,'String')) returns Xdirection contents as cell array
%        contents{get(hObject,'Value')} returns selected item from Xdirection


% --- Executes during object creation, after setting all properties.
function Xdirection_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Xdirection (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in Ydirection.
function Ydirection_Callback(hObject, eventdata, handles)
% hObject    handle to Ydirection (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.ConfirmData,'Enable','off')
% Hints: contents = cellstr(get(hObject,'String')) returns Ydirection contents as cell array
%        contents{get(hObject,'Value')} returns selected item from Ydirection


% --- Executes during object creation, after setting all properties.
function Ydirection_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Ydirection (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in Zdirection.
function Zdirection_Callback(hObject, eventdata, handles)
% hObject    handle to Zdirection (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.ConfirmData,'Enable','off')
% Hints: contents = cellstr(get(hObject,'String')) returns Zdirection contents as cell array
%        contents{get(hObject,'Value')} returns selected item from Zdirection


% --- Executes during object creation, after setting all properties.
function Zdirection_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Zdirection (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in ViewFirst.
function ViewFirst_Callback(hObject, eventdata, handles)
% hObject    handle to ViewFirst (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
load .\SystemData.mat
global load_row load_col
x_direction=get(handles.Xdirection,'value');
y_direction=get(handles.Ydirection,'value');
z_direction=get(handles.Zdirection,'value');
%max_layer=get(handles.Max,'value');
%med_layer=get(handles.Med,'value');
%min_layer=get(handles.Min,'value');
excel_name=get(handles.ExcelName,'Value');
excel_sheet=get(handles.ExcelSheet,'Value');
sample_name=get(handles.SampleChoice,'Value');
sample_kind=get(handles.KindChoice,'value');
sample_name=List{sample_name,1};
clear STOP
data_selected=DataSourceList{excel_name,5}{excel_sheet,1}(2:end,:);
[excel_num,~]=size(load_col);
for i=1:excel_num
    if ischar(DataSourceList{excel_name,5}{excel_sheet,1}{load_row(i)+1,load_col(i)})
        warndlg('请选择非文本数值！')
        clear data_selected
        STOP='keke';
        break
    else
        %data_selected(load_row(i),load_col(i))=cell2mat(DataSourceList{excel_name,5}{excel_sheet,1}(load_row(i)+1,load_col(i)));
        data_selected(load_row(i),load_col(i))={inf};
    end
end
if ~exist('STOP','var')
    [x,y]=find(cellfun(@(x) isequal(x,inf),data_selected)==1);
    ranknumber
    list_sample=cell(max.size*med.size*min.size,1);
    if eval(['size(' sample_name '.Kind{sample_kind,2},1)*size(' sample_name '.Kind{sample_kind,3},1)*size(' sample_name '.Kind{sample_kind,4},1)'])~=size(x,1)
        button=questdlg('选中的点数和样地采样点数不相符！','警告','重选','返回','重选');
        if strcmp(button,'重选')
            set(handles.Table,'Enable','on')
        else
            return
        end
    elseif size(find(x==x(1)),1)==size(x,1) && (x_direction~=y_direction || y_direction~=z_direction || z_direction~=x_direction)
        warndlg('单行应该使XYZ方向均为横向！','警告');
    elseif size(find(y==y(1)),1)==size(y,1) && (x_direction~=y_direction || y_direction~=z_direction || z_direction~=x_direction)
        warndlg('单列应该使XYZ方向均为纵向！','警告');
    %elseif max_layer==med_layer || med_layer==min_layer || min_layer==max_layer
        %warndlg('嵌套不应有重复！','警告');
    else
        
        for Max=1:max.size
            for Med=1:med.size
                for Min=1:min.size
                    eval(['list_sample{(Max-1)*med.size*min.size+min.size*(Med-1)+Min,1}=[''X'' num2str(' ...
                        x_rank ') ''Y'' num2str(' y_rank ') ''Z'' num2str(' z_rank ')];'])
                end
            end
        end
        for t=1:size(x,1)
            data_selected{x(t),y(t)}=list_sample{t,1};
        end
        set(handles.Table,'data',data_selected)
        %save test.mat x_direction y_direction z_direction max_layer med_layer min_layer excel_name excel_sheet DataSourceList load_row load_col sample_kind sample_name
        %eval(['save test.mat -append ' sample_name])
        save .\SystemData.mat -append excel_name excel_sheet max med min x y x_rank y_rank z_rank
        set(handles.ConfirmData,'Enable','on')
        set(handles.Table,'Enable','on')
        set(handles.KindChoice,'Enable','off')
        set(handles.SampleChoice,'Enable','off')
        set(handles.Xdirection,'Enable','off')
        set(handles.Ydirection,'Enable','off')
        set(handles.Zdirection,'Enable','off')
    end
end
% --- Executes on button press in ConfirmData.
function ConfirmData_Callback(hObject, eventdata, handles)
% hObject    handle to ConfirmData (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
load .\SystemData.mat
data_selected=DataSourceList{excel_name,5}{excel_sheet,1}(2:end,:);
%A=zeros(med.size,min.size,max.size);
for Max=1:max.size
    for Med=1:med.size
        for Min=1:min.size
            %eval(['A((' eval(med.layer) '),(' eval(min.layer) '),(' eval(max.layer) '))=data_selected{x((Max-1)*med.size*min.size+min.size*(Med-1)+Min),y((Max-1)*med.size*min.size+min.size*(Med-1)+Min)};'])
            eval(['A((' y_rank '),(' x_rank '),(' z_rank '))=data_selected{x((Max-1)*med.size*min.size+min.size*(Med-1)+Min),y((Max-1)*med.size*min.size+min.size*(Med-1)+Min)};'])
        end
    end
end
sample_name=List{get(handles.SampleChoice,'value'),1};
sample_kind=get(handles.KindChoice,'value');
sample_time=get(handles.SampleTime,'value');
eval([sample_name '.Kind{' num2str(sample_kind) ',6}(:,:,:,' num2str(sample_time) ')=A;'])
save .\SystemData.mat -append Sample*
FreshTable
set(handles.Table,'Enable','on')
set(handles.DataLoad,'visible','off')
set(handles.ExcelName,'Enable','on')
set(handles.ExcelSheet,'Enable','on')
set(handles.ExcelAdd,'Enable','on')
set(handles.ExcelDel,'Enable','on')
set(handles.KindChoice,'Enable','on')
set(handles.SampleChoice,'Enable','on')
set(handles.Xdirection,'Enable','on')
set(handles.Ydirection,'Enable','on')
set(handles.Zdirection,'Enable','on')
b=get(handles.KindChoice,'value');
sampleNumber=get(handles.SampleChoice,'Value');
sampleTime=get(handles.SampleTimeAll,'Value');
FigureShow
set(handles.ListBox,'value',sampleNumber)
set(handles.Kind,'value',b)
set(handles.SampleTimeAll,'value',sampleTime)
FreshSaveData

% --- Executes on button press in Same2up.
function Same2up_Callback(hObject, eventdata, handles)
% hObject    handle to Same2up (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
load .\SystemData.mat new_sample
if exist('new_sample','var') 
    if size(new_sample,1)==0
        warndlg('没有采样点可以同上啊！')
    else
        line=get(handles.Kind,'Value');
        set(handles.SampointX,'value',1)
        set(handles.SampointY,'value',1)
        set(handles.SampointZ,'value',1)
        set(handles.SampointX,'string',new_sample(line-1,1))
        set(handles.SampointY,'string',new_sample(line-1,2))
        set(handles.SampointZ,'string',new_sample(line-1,3))
    end
end


% --- Executes on button press in CancelData.
function CancelData_Callback(hObject, eventdata, handles)
% hObject    handle to CancelData (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
load .\SystemData.mat
set(handles.Table,'Enable','on')
set(handles.DataLoad,'visible','off')
set(handles.ExcelName,'Enable','on')
set(handles.ExcelSheet,'Enable','on')
set(handles.ExcelAdd,'Enable','on')
set(handles.ExcelDel,'Enable','on')
set(handles.KindChoice,'Enable','on')
set(handles.SampleChoice,'Enable','on')
set(handles.Xdirection,'Enable','on')
set(handles.Ydirection,'Enable','on')
set(handles.Zdirection,'Enable','on')
FreshTable
b=get(handles.Kind,'value');
sampleNumber=get(handles.ListBox,'Value');
sampleTime=get(handles.SampleTimeAll,'Value');
FigureShow


% --- Executes on button press in sametime2up.
function sametime2up_Callback(hObject, eventdata, handles)
% hObject    handle to sametime2up (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
load .\SystemData.mat
rank=get(handles.SampleChoice,'value');
kind=get(handles.KindChoice,'value');
sample_name=List{rank,1};
eval([sample_name '.Kind{kind,5}=Time;'])
eval(['have_time=' sample_name '.Kind{kind,5};'])
b=get(handles.KindChoice,'value');
eval([sample_name '.Kind{kind,6}=nan(size(' sample_name '.Kind{b,3},1),size(' sample_name '.Kind{b,2},1),size(' sample_name '.Kind{b,4},1),size(have_time,1));'])
save .\SystemData.mat -append Sample*
SampleTimeShow
FreshSaveData
%set(handles.SampleTime,'string',datestr(Time,'yyyy,mm,dd'))


% --------------------------------------------------------------------
function Diary_Callback(hObject, eventdata, handles)
% hObject    handle to Diary (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
load .\SystemData.mat
if exist('Calcu_result','var')
    listdlg('Liststring',Calcu_result,'name','计算报告','okstring','确定','cancelstring','关闭','listsize',[250 500])
else
    warndlg('没有计算插值，请点击差值计算','提示')
end


% --------------------------------------------------------------------
function SampleDataView_Callback(hObject, eventdata, handles)
% hObject    handle to SampleDataView (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
load .\SystemData.mat
if exist('Calcu_result','var')
    ModelDataViewer
else
    warndlg('还没有插值数据，请先计算！','提示')
end


% --------------------------------------------------------------------
function UserManuals_Callback(hObject, eventdata, handles)
% hObject    handle to UserManuals (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
open  .\用户手册.pdf

% --------------------------------------------------------------------
function SoftInfo_Callback(hObject, eventdata, handles)
% hObject    handle to SoftInfo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
msgbox({'【软件名称】';'Yaira样地数据四维可视化软件';'';'【软件版本】：';'Yaira ver1.0';'';'【开发者】：';'Howcanoe Wang';'Cima Chang';'';'【网站维护】';'Chijie Holmes'})

% --------------------------------------------------------------------
function Website_Callback(hObject, eventdata, handles)
% hObject    handle to Website (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
web www.sigmameow.com
