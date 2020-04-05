function [] = swars(player)
 
global quitGame;
global right_button;
quitGame = false;

[mainAxis, ship, axisTitle] = initialize_graphics();

%Setting up the ships
ship1 = ship;
ship2 = ship;
ship2.patch = patch(NaN,NaN,'y');
set(ship2.patch,'LineWidth', 2);
set(ship2.patch,'EdgeColor', 'white');

%making sure that there are no left over values from last game
p1file = fopen('1.txt','w');
p2file = fopen('2.txt','w');
fprintf(p1file, '%f %f', 100, 20);
fprintf(p2file, '%f %f', 100, 300);
fclose(p1file); fclose(p2file);

%draw the ships at the starting positions
ship1Pos = [100 20];
ship2Pos = [100 300];
draw_object(mainAxis, ship, ship1Pos); draw_object(mainAxis, ship2, ship2Pos);

print_title(axisTitle, 'SWARS');
while ~quitGame    
    %if player == 1
        pause(0.025);
        
        if right_button == true
            right_button = false;
            moveObject(mainAxis, ship1, ship2, player);
        end
    %end
end % End while loop
print_title(axisTitle, 'GAME OVER');

end % End for swars function

