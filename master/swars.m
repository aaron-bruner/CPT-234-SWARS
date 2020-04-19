function [] = swars(player)

global quitGame;
global right_button; 
global left_button;
quitGame = false;
right_button = false;
left_button = false;
counter = [];



[mainAxis, ship, axisTitle, torpedo_object] = initialize_graphics();

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

% testing torpedos
% tempMousePos = [25 250];
% speed = 1;
% delta_t = 1;
% i=0;
% torpedoPos = [10, 10; 20, 10; 30, 10];
% while i < 20
%  uv = (tempMousePos - torpedoPos)./norm(tempMousePos - torpedoPos);
%  velo = speed .* uv;
%  torpedoPos = torpedoPos + velo .* delta_t;
%  draw_torpedos(torpedoPos,torpedo_object);
%  i=i+1;
%  disp(torpedoPos);
% end
torpedoPositions = [];
while ~quitGame
    pause(0.025);
    moveObject(mainAxis, ship1, ship2, player);
    [torpedoPositions] = moveTorpedos(player, mainAxis, torpedoPositions, torpedo_object);
    %shoot
    %checkCollisions
    %updateBars
    %refreshPlots
    counter = counter + 1;
end % End while loop
print_title(axisTitle, 'GAME OVER');

end % End for swars function

