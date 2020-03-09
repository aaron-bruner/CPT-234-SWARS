function [] = swars(player)

[mainAxis, ship, axisTitle] = initialize_graphics();
mouseMoveListner(src, event);

object = struct('outline',ship.outline,'patch',ship.patch,'w',ship.w,'h',ship.h);
draw_object(mainAxis, object, get_mouse_position(mainAxis));

print_title(axisTitle, 'SWARS');

end
