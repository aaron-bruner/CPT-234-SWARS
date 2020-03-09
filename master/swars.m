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
