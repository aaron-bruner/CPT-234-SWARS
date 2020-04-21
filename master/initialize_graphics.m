function [mainAxis, ship, axisTitle, torpedo_object] = initialize_graphics()
%initialize_graphics creates the graphic environment
%Input arguments
%   none
%Output arguments
%   mainAxis - handle to the axes object
%   ship - structure containing the following fields
%       w - width of ship
%       h - height of ship
%       outline - outline of ship
%       patch - patch object of ship
%   handle to the axis title

SHIP_START_Y = 20; %hero start position
ship.w = 15; %hero width
ship.h = 20; %hero height
SHIP_SHAPE = [1 0 1 2 3 4 3 1; ... %x values
  0 1 2 4 2 1 0 0];    %y values
xScale = ship.w / max(SHIP_SHAPE(1,:));
yScale = ship.h / max(SHIP_SHAPE(2,:));

% torpedos.w = 7;
% torpedos.h = 15;
% TORPEDOS_SHAPE = [1 0 1 2; 0 2 4 2];
% xTorpScale = torpedos.w / max(TORPEDOS_SHAPE(1,:));
% yTorpScale = torpedos.h / max(TORPEDOS_SHAPE(2,:));
% torpedos.outline = [TORPEDOS_SHAPE(1,:) .* xTorpScale; TORPEDOS_SHAPE(2,:) .* yTorpScale];

%coordinats for drawing hero at 0,0.
%scale hero so that he's HERO_W wide and HERO_H tall
ship.outline = [SHIP_SHAPE(1,:) .* xScale; SHIP_SHAPE(2,:) .* yScale];

fig = figure;
set(fig,'color','black');
set(fig,'Resize','off');
pointer=NaN(16,16);
pointer(4,1:7) = 2;
pointer(1:7,4)=2;
pointer(4,4)=1;
set(fig,'Pointer','Custom');
set(fig,'PointerShapeHotSpot',[4 4]);
set(fig,'PointerShapeCData',pointer);
set(fig,'KeyPressFcn',@keyDownListener);
set(fig,'WindowButtonDownFcn', @mouseDownListener);
set(fig,'WindowButtonUpFcn', @mouseUpListener);
set(fig,'WindowButtonMotionFcn', @mouseMoveListener);
mainAxis = axes();
%set color for the court, hide axis ticks.
AXIS_COLOR = [0, 0, 0]; %the sky
set(mainAxis, 'color', AXIS_COLOR, 'YTick', [], 'XTick', []);

%handle for displaying the score
axisTitle = title('');
font = 'Courier';
large_text = 20;
green = [.1, .7, .1];
title_color = green;
set(axisTitle,'fontsize', large_text)
%set(axisTitle, 'FontName', font,'fontsize', large_text);
set(axisTitle, 'Color', title_color);

%set size of the graphics window
axis([0 200 0 324]);
axis off;
hold on
ship.patch = patch(NaN,NaN,'r');
set(ship.patch,'LineWidth', 2);
set(ship.patch,'EdgeColor', 'white');
% torpedos.patch = patch(NaN,NaN,'g');
% set(torpedos.patch,'LineWidth', 1);
% set(torpedos.patch,'EdgeColor', 'green');

%host torpedos
TORPEDO_1_FACE_COLOR = [0.1 0.7 0.1];
TORPEDO_1_EDGE_COLOR = [0.1 0.7 0.1];
TORPEDO_1_SHAPE = 'd';
TORPEDO_1_SIZE = 5;
torpedo_object = plot(NaN,NaN);
set(torpedo_object, 'Marker', TORPEDO_1_SHAPE);
set(torpedo_object, 'MarkerFaceColor', TORPEDO_1_FACE_COLOR);
set(torpedo_object, 'MarkerEdgeColor', TORPEDO_1_EDGE_COLOR);
set(torpedo_object, 'MarkerSize', TORPEDO_1_SIZE);
set(torpedo_object, 'LineStyle', 'None');