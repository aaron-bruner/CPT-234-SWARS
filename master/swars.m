function [] = swars(player)

%     p1 = fopen('1.txt','r');
%     p2 = fopen('2.txt','w');

    
global quitGame;
global right_button;
quitGame = false;

[mainAxis, ship, axisTitle] = initialize_graphics();
print_title(axisTitle, 'SWARS');

while ~quitGame    
    if player == 1
        pause(0.025);
        
        if right_button == true
            right_button = false;
            [shipPos] = moveObject(shipPos, mainAxis, ship);
        end
    end
end % End while loop
print_title(axisTitle, 'GAME OVER');

end % End for swars function

