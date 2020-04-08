function [] = swars(player)
%%%%%%%%%
close all
clear all
clc
%%%%%%%%%
global quitGame;
quitGame = false;

[mainAxis, ship, axisTitle] = initialize_graphics();
print_title(axisTitle, 'SWARS');

TORP_START_Y = 20; %torp start position
torp.w = 5; %torp width
torp.h = 10; %torp height
TORP_SHAPE = [1 0 1 2 3 4 3 1; ... %x values
  0 1 2 4 2 1 0 0];    %y values
xScale = torp.w / max(TORP_SHAPE(1,:));
yScale = torp.h / max(TORP_SHAPE(2,:));

%coordinats for drawing torp at 0,0.
%scale torp so that he's TORP_W wide and TORP_H tall
torp.outline = [TORP_SHAPE(1,:) .* xScale; TORP_SHAPE(2,:) .* yScale];

torpPos = [100 150];

while ~quitGame
    
    pause(0.025);
    
    pos = get_mouse_position(mainAxis);

    object = struct('outline',ship.outline,'patch',ship.patch,'w',ship.w,'h',ship.h);   
    draw_object(mainAxis, object, pos);

end % End while loop

% END OF GAME SCREEN %
print_title(axisTitle, 'GAME OVER');
pause(1.0);
%%%%%%%%%%%%%%%%%%%%%%

end % End for swars function
