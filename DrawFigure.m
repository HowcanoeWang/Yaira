if get(handles.checkbox1,'value')==1
    X_ctrl=floor(get(handles.slider2,'value'));
    xi=x_lable(X_ctrl);
    set(handles.slider2,'enable','on');
else
    X_ctrl=NaN;
    xi=nan;
    set(handles.slider2,'enable','off');
end
if get(handles.checkbox2,'value')==1
    Y_ctrl=floor(get(handles.slider3,'value'));
    yi=y_lable(Y_ctrl);
    set(handles.slider3,'enable','on');
else
    Y_ctrl=NaN;
    yi=nan;
    set(handles.slider3,'enable','off');
end
if get(handles.checkbox3,'value')==1
    Z_ctrl=floor(get(handles.slider4,'value'));
    zi=z_lable(Z_ctrl);
    set(handles.slider4,'enable','on');
else
    Z_ctrl=NaN;
    zi=nan;
    set(handles.slider4,'enable','off');
end
%绘图
if size(DataNow,4)>1
    Vq(:,:,:)=DataNow(:,:,:,T_ctrl);
elseif size(DataNow,3)>1
    Vq(:,:,:)=DataNow;
end
%Cmax=max(max(max(max(DataNow))));
%Cmin=min(min(min(min(DataNow))));
axes(handles.axes1)
%caxis([Cmin Cmax]);
b=get(handles.KindNum,'value');
sampleNumber=get(handles.SampleName,'Value');
sample4Time=floor(get(handles.slider1,'Value'));
FigureShow4Reader %采样点显示程序
hold on
slice(XI,YI,ZI,Vq,xi,yi,zi);
axis(Size);
colormap(flipud(summer));
if strcmp(get(handles.ColorBar,'state'),'on')
    colorbar
    %Cmax=max(max(max(max(DataNow))));
    %Cmin=min(min(min(min(DataNow))));
    %caxis([Cmin Cmax]);
end
%控制图像处颜色条与网格
if get(handles.GridLine,'value')==0
    shading interp
end