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
            'liststring',{'X����Y��Y����Z';'X����Z��Z����Y';'Y����X��X����Z';'Y����Z��Z����X';'Z����X��X����Y';'Z����Y��Y����X'},...
            'name','��ѡ��һ��',...
            'okstring','ȷ��',...
            'cancelstring','ȡ��',...
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
            sel=questdlg('X��Y˭����˭��','��ѡ�������ϵ','X����Y','Y����X','X����Y');
            switch sel
                case ''
                    CANCEL='cancel';
                case 'X����Y'
                    ranknumber_ZXY
                case 'Y����X'
                    ranknumber_ZYX
            end
        end
        if abs(z_direction)==2
            sel=questdlg('X��Y˭����˭��','��ѡ�������ϵ','X����Y','Y����X','X����Y');
            switch sel
                case ''
                    CANCEL='cancel';
                case 'X����Y'
                    ranknumber_XYZ
                case 'Y����X'
                    ranknumber_YXZ
            end
        end
    end
end
if A(1)~=A(2)
    if A(1)==A(3)
        if abs(y_direction)==1
            sel=questdlg('X��Z˭����˭��','��ѡ�������ϵ','X����Z','Z����X','X����Z');
            switch sel
                case ''
                    CANCEL='cancel';
                case 'X����Z'
                    ranknumber_YXZ
                case 'Z����X'
                    ranknumber_YZX
            end
        end
        if abs(y_direction)==2
            sel=questdlg('X��Z˭����˭��','��ѡ�������ϵ','X����Z','Z����X','X����Z');
            switch sel
                case ''
                    CANCEL='cancel';
                case 'X����Z'
                    ranknumber_XZY
                case 'Z����X'
                    ranknumber_ZXY
            end
        end
    end
    if A(1)~=A(3)
        if abs(x_direction)==1
            sel=questdlg('Y��Z˭����˭��','��ѡ�������ϵ','Y����Z','Z����Y','Y����Z');
            switch sel
                case ''
                    CANCEL='cancel';
                case 'Y����Z'
                    ranknumber_XYZ
                case 'Z����Y'
                    ranknumber_XZY
            end
        end
        if abs(x_direction)==2
            sel=questdlg('Y��Z˭����˭��','��ѡ�������ϵ','Y����Z','Z����Y','Y����Z');
            switch sel
                case ''
                    CANCEL='cancel';
                case 'Y����Z'
                    ranknumber_YZX
                case 'Z����Y'
                    ranknumber_ZYX
            end
        end
    end
end