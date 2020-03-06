%Changes


function [] = draw_object(mainAxis, object, mousePos)
%draw_object draws a graphics object on a set of axes
%Input arguments
%   mainAxis - handle to axes object
%   object - structure to the object to be drawn with the following fields
%       outline - outline of the object
%       patch - patch object for the object
%       w - width of the object
%       h - height of the object
%   mousePos - 2 element vector containing [x y] of the mouse position

objectOutlinePos = [mousePos(1) - (object.w * 0.5), mousePos(2) - (object.h * 0.5)];
curobjectOutline = [object.outline(1,:) + objectOutlinePos(1); object.outline(2,:) + objectOutlinePos(2)];
set(object.patch, 'XData', curobjectOutline(1,:), 'YData', curobjectOutline(2,:));