load('.\SystemData.mat')
ThreeDSampleViewer=1;
if exist('List','var')
    number=size(List,1);
    hwaitbar=waitbar(0,'加载保存引擎中...');
    %eval(['save ' [pathName fileName] ' -append C* D* L* N* T*'])
    eval(['save ' [pathName fileName] ' -regexp ^[A-R]'])
    eval(['save ' [pathName fileName] ' -append ThreeDSampleViewer'])
    if exist('Time','var')
        eval(['save ' [pathName fileName] ' -append Time'])
    end
    waitbar((0.5/number),hwaitbar)
    for i=1:number
        waitbar((i/number),hwaitbar)
        eval(['save([pathName fileName],''-append'',''' List{i,1} ''')'])
    end
    close(hwaitbar)
else
    save([pathName fileName],'-regexp','^[A-Z]')
end
saveState='Saved';
save .\SystemData.mat -append saveState
