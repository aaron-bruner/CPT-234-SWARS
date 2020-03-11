function [] = swars(player)

clear;clc

global quitGame;
quitGame = false;
global right_button;

[mainAxis, ship, axisTitle] = initialize_graphics();
print_title(axisTitle, 'SWARS');
shipPos = [100 50];
draw_object(mainAxis, ship, shipPos);
while ~quitGame    
pause(0.025);
    if right_button == true
        right_button = false;
        mousePos = get_mouse_position(mainAxis);
        [shipPos] = moveObject(mousePos,shipPos, mainAxis, ship);
    end

end % End while loop

print_title(axisTitle, 'GAME OVER');

end % End for swars function
