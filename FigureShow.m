%% 绘图前应该提供如下接口
%b=get(handles.Kind,'value');
%sampleNumber=get(handles.ListBox,'Value');
%sampleTime=get(handles.mbmbbox,'Value');
%% 这里是绘图部分
load .\SystemData.mat Time
eval(['sample=' List{sampleNumber,1} ';'])
UnitsTransfer
cla reset
[X,Y,Z]=meshgrid4scatter3(sample.Kind{b,2},sample.Kind{b,3},sample.Kind{b,4});
scatter3(X,Y,Z,30,Z,'filled');hold on
if ~isempty(sample.Kind{b,6})
    max_size=size(sample.Kind{b,2},1)*size(sample.Kind{b,3},1)*size(sample.Kind{b,4},1);
    P=zeros(1,max_size);
    xsize=size(sample.Kind{b,2},1);
    ysize=size(sample.Kind{b,3},1);
    zsize=size(sample.Kind{b,4},1);
    if ~isempty(sample.Kind{b,6})
        if sampleTime<=size(sample.Kind{b,6},4)
            for Xi=1:xsize
                for Yi=1:ysize
                    for Zi=1:zsize
                        P(1,(ysize*zsize*(Xi-1))+zsize*(Yi-1)+Zi)=sample.Kind{b,6}(Yi,Xi,Zi,sampleTime);
                    end
                end
            end
            for i=1:max_size
                text(X(i),Y(i),Z(i),num2str(P(i)))
            end
        end
    end
end
eval(['axis([' num2str(sample.Size) '])'])
eval(['xlabel(''样地长(' unitX ')'',''fontsize'',14,''Color'',''black'',''FontWeight'',''bold'');'])
eval(['ylabel(''样地宽(' unitY ')'',''fontsize'',14,''Color'',''black'',''FontWeight'',''bold'');'])
eval(['zlabel(''样地高(' unitZ ')'',''fontsize'',14,''Color'',''black'',''FontWeight'',''bold'');'])
if isempty(sample.Kind{b,5})
    title([sample.Name ' ' sample.Kind{b,1}]);
else
    ANS=find(sample.Kind{b,5}==Time(sampleTime,1));
    if ~isempty(ANS)
        title([sample.Name ' ' sample.Kind{b,1} ' ' datestr(sample.Kind{b,5}(ANS,1),'yyyy.mm.dd HH:MM:SS')]);
    end
end