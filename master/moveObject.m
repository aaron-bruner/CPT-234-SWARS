function [shipPos] = moveObject(mousePos, shipPos, mainAxis, ship)
    global right_button;
    time = 50;
    xPosition = linspace(shipPos(1),mousePos(1),time);
    yPosition = linspace(shipPos(2),mousePos(2),time);
    j = 0;
while (shipPos ~= mousePos) & (j == 0)
    for k=1:time
        draw_object(mainAxis, ship, [xPosition(k),yPosition(k)]);
        shipPos = [xPosition(k),yPosition(k)];
        if right_button == true
        j = 1;
        break
        else
        pause(0.025);
        end
    end
end