function [output] = ChooseDate
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
s = uicontrol('style', 'edit', 'position', [10 10 100 20]);
set(s,'visible','off')
h=uicalendar('DestinationUI', {s, 'string'});
waitfor(h)
output=get(s,'string');
end