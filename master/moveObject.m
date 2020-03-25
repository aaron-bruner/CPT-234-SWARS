function [shipPos] = moveObject(shipPos, mainAxis, ship)
global right_button;
speed = 3.5;
j = 0;
delta_t = 1;
mousePos = get_mouse_position(mainAxis);
if player == 1
    p1 = fopen('1.txt','w');
    p2 = fopen('2.txt','r');
while j == 0
    uv = (mousePos - shipPos)/norm(mousePos - shipPos);
    velo = speed * uv;
    shipPos = shipPos + velo * delta_t;
    draw_object(mainAxis, ship, shipPos)
    
    if shipPos(1)+1.5 > mousePos(1) && shipPos(1) - 1.5 < mousePos(1) && shipPos(2) + 1.5 > mousePos(2) && shipPos(2) - 1.5 < mousePos(2)
        j = 1;
        break
    end
    if right_button == true
        j = 1;
        break
    else
        pause(0.025);
    end

end
elseif player == 2
    p1 = fopen('1.txt','r');
    p2 = fopen('2.txt','w');
while j == 0
    uv = (mousePos - shipPos)/norm(mousePos - shipPos);
    velo = speed * uv;
    shipPos = shipPos + velo * delta_t;
    draw_object(mainAxis, ship, shipPos)
    
    if shipPos(1)+1.5 > mousePos(1) && shipPos(1) - 1.5 < mousePos(1) && shipPos(2) + 1.5 > mousePos(2) && shipPos(2) - 1.5 < mousePos(2)
        j = 1;
        break
    end
    if right_button == true
        j = 1;
        break
    else
        pause(0.025);
    end

end
end
