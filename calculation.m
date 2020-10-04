samplenumber=size(List,1);
result_num=0;
for t=1:samplenumber
    eval(['sample{t,1}=' List{t,1} '.Kind;'])
    result_num=result_num+size(sample{t,1},1)+1;
end
clear sample
Calcu_result=cell(result_num,1);
%% linear
hwaitbar1=waitbar(0,'(0/3)���ڽ���linear��ֵ���㣬���ĵȴ�����ر�...','Name','������');
result_num=0;
for i=1:samplenumber
    eval(['sample_data=' List{i,1} '.Kind;'])
    eval(['sample_size=' List{i,1} '.Size;'])
    eval(['sample_accuracy=' List{i,1} '.Accuracy;'])
    kindnumber=size(sample_data,1);
    result_num=result_num+1;
    Calcu_result{result_num}=[List{i,2}];
    for j=1:kindnumber
        waitbar((i-1)/samplenumber+1/samplenumber*((j-1)/kindnumber),hwaitbar1)
        result_num=result_num+1;
        if ~isempty(sample_data{j,5}) && ~isempty(sample_data{j,6})
            data_calcu=sample_data(j,:);
            [linear,results]=ndgridcalculate1(data_calcu,sample_size,sample_accuracy);
            a=size(linear);
            eval([List{i,1} '.Kind{j,7}=zeros(a);'])
            eval([List{i,1} '.Kind{j,7}=linear;'])
            clear data_calcu
            Calcu_result{result_num}=results;
        else
            Calcu_result{result_num}=['��' sample_data{j,1} '(������)'];
            continue
        end
    end
    clear sample_data
end
%% nearest
hwaitbar2=waitbar(0,'(1/3)���ڽ���nearest��ֵ���㣬���ĵȴ�����ر�...','Name','������');
for i=1:samplenumber
    eval(['sample_data=' List{i,1} '.Kind;'])
    eval(['sample_size=' List{i,1} '.Size;'])
    eval(['sample_accuracy=' List{i,1} '.Accuracy;'])
    kindnumber=size(sample_data,1);
    for j=1:kindnumber
        waitbar((i-1)/samplenumber+1/samplenumber*((j-1)/kindnumber),hwaitbar2)
        if ~isempty(sample_data{j,5}) && ~isempty(sample_data{j,6})
            data_calcu=sample_data(j,:);
            [nearest]=ndgridcalculate2( data_calcu,sample_size,sample_accuracy);
            a=size(nearest);
            eval([List{i,1} '.Kind{j,8}=zeros(a);'])
            eval([List{i,1} '.Kind{j,8}=nearest;'])
            clear data_calcu
        else
            continue
        end
    end
    clear sample_data
end
%% spline
hwaitbar3=waitbar(0,'(2/3)���ڽ���spline��ֵ���㣬���ĵȴ�����ر�...','Name','������');
for i=1:samplenumber
    eval(['sample_data=' List{i,1} '.Kind;'])
    eval(['sample_size=' List{i,1} '.Size;'])
    eval(['sample_accuracy=' List{i,1} '.Accuracy;'])
    kindnumber=size(sample_data,1);
    for j=1:kindnumber
        waitbar((i-1)/samplenumber+1/samplenumber*((j-1)/kindnumber),hwaitbar3)
        if ~isempty(sample_data{j,5}) && ~isempty(sample_data{j,6})
            data_calcu=sample_data(j,:);
            [spline]=ndgridcalculate3( data_calcu,sample_size,sample_accuracy);
            a=size(spline);
            eval([List{i,1} '.Kind{j,9}=zeros(a);'])
            eval([List{i,1} '.Kind{j,9}=spline;'])
            clear data_calcu
        else
            continue
        end
    end
    clear sample_data
end
delete(hwaitbar3);
delete(hwaitbar2);
delete(hwaitbar1);
SaveState='Edited';
save .\SystemData.mat -append  Calcu_result
hwaitbar4=waitbar(0,'���ڽ��б������ݣ�����ر�','Name','������');
for n=1:samplenumber
    waitbar((n/samplenumber),hwaitbar4)
    eval(['save .\SystemData.mat -append ' List{n,1}])
    eval(['clear ' List{n,1}]) 
end
delete(hwaitbar4)
listdlg('Liststring',Calcu_result,'name','���㱨��','okstring','ȷ��','cancelstring','�ر�','listsize',[250 500])