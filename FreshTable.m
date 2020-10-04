global load_row load_col
if exist('DataSourceList','var')
    if isempty(DataSourceList)
        set(handles.Table,'ColumnName',{'A';'B';'C';'D';'E';'F';'G';'H';'I';'J';'K';'L';'M';'N';'O';'P';'Q';'R';'S';'T';'U';'V';'W';'X';'Y';'Z'})
        set(handles.Table,'data',cell(32,26))
        set(handles.ExcelName,'string',{''})
        set(handles.ExcelSheet,'string',{''})
    else
        set(handles.ExcelName,'string',DataSourceList(:,3))
        set(handles.ExcelSheet,'string',DataSourceList{1,4}')
        excel_num=get(handles.ExcelName,'value');
        set(handles.ExcelSheet,'string',DataSourceList{excel_num,4}')
        sheet_num=get(handles.ExcelSheet,'value');
        set(handles.Table,'ColumnName',DataSourceList{excel_num,5}{sheet_num,1}(1,:),'data',DataSourceList{excel_num,5}{sheet_num,1}(2:end,:),'ColumnEditable',false);
    end
end
load_row=0;
load_col=0;