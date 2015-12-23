function [th] = rotate_xlabels1(h,rot)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
%make sure the rotation is in the range 0:360 (brute force method)
while rot>360
    rot=rot-360;
end
while rot<0
    rot=rot+360;
end
%get current tick labels
a=get(h,'XTickLabel');
%erase current tick labels from figure
set(h,'XTickLabel',[]);
%get tick label positions
b=get(h,'XTick');
c=get(h,'YTick');
%d=get(h,'ZTick');
%make new tick labels
if rot<180
    th=text(b,repmat(c(length(c))+0.7,length(b),1),a,'HorizontalAlignment','right','rotation',rot);
else
    th=text(b,repmat(c(length(c))+0.7,length(b),1),a,'HorizontalAlignment','left','rotation',rot);
end


end

