switch x_direction
    case 1
        x_direction=1;
    case 2
        x_direction=2;
    case 3
        x_direction=-1;
    case 4
        x_direction=-2;
end
switch y_direction
    case 1
        y_direction=1;
    case 2
        y_direction=2;
    case 3
        y_direction=-1;
    case 4
        y_direction=-2;
end
switch z_direction
    case 1
        z_direction=1;
    case 2
        z_direction=2;
    case 3
        z_direction=-1;
    case 4
        z_direction=-2;
end
A=[abs(x_direction) abs(y_direction) abs(z_direction)];
if A(1)==A(2)
    if A(2)==A(3)
        [sel,ok]=listdlg(...
            'liststring',{'X包含Y，Y包含Z';'X包含Z，Z包含Y';'Y包含X，X包含Z';'Y包含Z，Z包含X';'Z包含X，X包含Y';'Z包含Y，Y包含X'},...
            'name','请选择一项',...
            'okstring','确定',...
            'cancelstring','取消',...
            'selectionmode','single',...
            'listsize',[200 80]);
        if ok==1
            switch sel
                case 1
                    ranknumber_XYZ
                case 2
                    ranknumber_XZY
                case 3
                    ranknumber_YXZ
                case 4
                    ranknumber_YZX
                case 5
                    ranknumber_ZXY
                case 6
                    ranknumber_ZYX
            end
        else
            CANCEL='cancel';
        end
    end
    if A(2)~=A(3)
        if abs(z_direction)==1
            sel=questdlg('X、Y谁包含谁？','请选择包含关系','X包含Y','Y包含X','X包含Y');
            switch sel
                case ''
                    CANCEL='cancel';
                case 'X包含Y'
                    ranknumber_ZXY
                case 'Y包含X'
                    ranknumber_ZYX
            end
        end
        if abs(z_direction)==2
            sel=questdlg('X、Y谁包含谁？','请选择包含关系','X包含Y','Y包含X','X包含Y');
            switch sel
                case ''
                    CANCEL='cancel';
                case 'X包含Y'
                    ranknumber_XYZ
                case 'Y包含X'
                    ranknumber_YXZ
            end
        end
    end
end
if A(1)~=A(2)
    if A(1)==A(3)
        if abs(y_direction)==1
            sel=questdlg('X、Z谁包含谁？','请选择包含关系','X包含Z','Z包含X','X包含Z');
            switch sel
                case ''
                    CANCEL='cancel';
                case 'X包含Z'
                    ranknumber_YXZ
                case 'Z包含X'
                    ranknumber_YZX
            end
        end
        if abs(y_direction)==2
            sel=questdlg('X、Z谁包含谁？','请选择包含关系','X包含Z','Z包含X','X包含Z');
            switch sel
                case ''
                    CANCEL='cancel';
                case 'X包含Z'
                    ranknumber_XZY
                case 'Z包含X'
                    ranknumber_ZXY
            end
        end
    end
    if A(1)~=A(3)
        if abs(x_direction)==1
            sel=questdlg('Y、Z谁包含谁？','请选择包含关系','Y包含Z','Z包含Y','Y包含Z');
            switch sel
                case ''
                    CANCEL='cancel';
                case 'Y包含Z'
                    ranknumber_XYZ
                case 'Z包含Y'
                    ranknumber_XZY
            end
        end
        if abs(x_direction)==2
            sel=questdlg('Y、Z谁包含谁？','请选择包含关系','Y包含Z','Z包含Y','Y包含Z');
            switch sel
                case ''
                    CANCEL='cancel';
                case 'Y包含Z'
                    ranknumber_YZX
                case 'Z包含Y'
                    ranknumber_ZYX
            end
        end
    end
end