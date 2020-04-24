function [shipPositions] = moveObject(shipPositions, mainAxis, ship1, ship2, player)
global right_button;
global quitGame;
global SHIP_SPEED;

if player == 1
    %Ensuring that we have the correct positions by referencing the
    %file
    player1 = fopen('1.txt', 'r');
    ship1x = fscanf(player1, '%f', 1);
    ship1y = fscanf(player1, '%f', 1);
    ship1Positions(1:2) = [ship1x ship1y];
    fclose(player1);
elseif player == 2
    %Ensuring that we have the correct positions by referencing the
    %file
    player2 = fopen('2.txt', 'r');
    ship2x = fscanf(player2, '%f', 1);
    ship2y = fscanf(player2, '%f', 1);
    ship2Pos = [ship2x ship2y];
    fclose(player2);
    
if player == 1
    if right_button == true
        right_button = false;
        shipPositions(3:4) = get_mouse_position(mainAxis);
        uv = (ship1Positions(3:4) - ship1Positions(1:2))/norm(ship1Positions(3:4) - ship1Positions(1:2));
        velo = SHIP_SPEED * uv;
    end
    if ~quitGame
        ship1Positions = ship1Positions + velo;
        player1 = fopen('1.txt', 'w');
        draw_object(mainAxis, ship1, ship1Positions)
        fprintf(player1, '%f %f', ship1Positions(1), ship1Positions(2));
        frewind(player1);
        fclose(player1);
        
        %Just draw player 2's ship while we determine where player 1 is
        %going
        player2 = fopen('2.txt', 'r');
        ship2x = fscanf(player2, '%f', 1);
        ship2y = fscanf(player2, '%f', 1);
        ship2Pos = [ship2x ship2y];
        draw_object(mainAxis, ship2, ship2Pos);
        fclose(player2);
        pause(0.025);
    end
    
end
elseif player == 2
    while ~quitGame
        uv = (mousePos - ship2Pos)/norm(mousePos - ship2Pos);
        velo = SHIP_SPEED * uv;
        ship2Pos = ship2Pos + velo;
        player2 = fopen('2.txt', 'w');
        draw_object(mainAxis, ship2, ship2Pos)
        fprintf(player2, '%f %f', ship2Pos(1), ship2Pos(2));
        frewind(player2);
        fclose(player2);
        
        %Just draw player 1's ship while we determine where player 2 is
        player1 = fopen('1.txt', 'r');
        ship1x = fscanf(player1, '%f', 1);
        ship1y = fscanf(player1, '%f', 1);
        ship1Positions = [ship1x ship1y];
        draw_object(mainAxis, ship1, ship1Positions);
        fclose(player1);
        
        if ship2Pos(1)+1.5 > mousePos(1) && ship2Pos(1) - 1.5 < mousePos(1) && ship2Pos(2) + 1.5 > mousePos(2) && ship2Pos(2) - 1.5 < mousePos(2)
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