function [] = swars(player)

global quitGame;
quitGame = false;

[mainAxis, ship, axisTitle] = initialize_graphics();
print_title(axisTitle, 'SWARS');


while quitGame ~= true
    pause(0.025);
    
    get_mouse_position(mainAxis);

    object = struct('outline',ship.outline,'patch',ship.patch,'w',ship.w,'h',ship.h);   
    draw_object(mainAxis, object, get_mouse_position(mainAxis));

end % End for while loop
print_title(axisTitle, 'GAME OVER');
pause(1.0);
close(fig);
end % End for swars function
