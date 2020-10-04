load .\SystemData.mat
rank=get(handles.SampleChoice,'value');
kind=get(handles.KindChoice,'value');
sample_name=List{rank,1};
if eval(['~isempty(datestr(' sample_name '.Kind{kind,5}))'])
    eval(['set(handles.SampleTime,''string'',datestr(' sample_name '.Kind{kind,5},''yyyy.mm.dd HH:MM:SS''));'])
else
    set(handles.SampleTime,'string',{''})
end