%%
h = uitable('v0','data',rand(100,3)); %�����v0���������ϰ汾��uitable�Ĳ���
t = h.getTable;
drawnow
t.scrollCellToVisible(size(get(h,'data'),1),0)

%% ����
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

%% ����
