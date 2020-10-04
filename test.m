%%
h = uitable('v0','data',rand(100,3)); %这里的v0就是启用老版本的uitable的参数
t = h.getTable;
drawnow
t.scrollCellToVisible(size(get(h,'data'),1),0)

%% 动画
t=linspace(0,35,1000);
y=sin(2*t).*exp(-t/5);
h=plot(t,y);
xlim([0 50])
set(h,'erasemode','xor')
set(h,'color','r')
set(h,'linewidth',2)
for i=1:200
    x=i/20+t;
    set(h,'xdata',x)
    drawnow
end

%% 计算
