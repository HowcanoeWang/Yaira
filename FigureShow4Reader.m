%% ��ͼǰӦ���ṩ���½ӿ�
%b=get(handles.Kind,'value');
%sampleNumber=get(handles.ListBox,'Value');
%sample4Time=get(handles.mbmbbox,'Value');
%time123=sampleTime(1):accuracy:sampleTime(end);
%% �����ǻ�ͼ����
sampleTime=time123(sample4Time);
eval(['sample=' List{sampleNumber,1} ';'])
UnitsTransfer
cla reset
[X,Y,Z]=meshgrid4scatter3(sample.Kind{b,2},sample.Kind{b,3},sample.Kind{b,4});
scatter3(X,Y,Z,30,'filled');hold on
eval(['axis([' num2str(sample.Size) '])'])
eval(['xlabel(''���س�(' unitX ')'',''fontsize'',14,''Color'',''black'',''FontWeight'',''bold'');'])
eval(['ylabel(''���ؿ�(' unitY ')'',''fontsize'',14,''Color'',''black'',''FontWeight'',''bold'');'])
eval(['zlabel(''���ظ�(' unitZ ')'',''fontsize'',14,''Color'',''black'',''FontWeight'',''bold'');'])
title([sample.Name ' ' sample.Kind{b,1} ' ' datestr(sampleTime,'yyyy.mm.dd HH:MM:SS')]);
