function moveObject(mainAxis, ship1, ship2, player)
global right_button;
if right_button == true
    right_button = false;
    speed = 3.5;
    j = 0;
    delta_t = 1;
    mousePos = get_mouse_position(mainAxis);
    %getting initial positions depending on the player
    if player == 1
        player1 = fopen('1.txt', 'r');
        ship1x = fscanf(player1, '%f', 1);
        ship1y = fscanf(player1, '%f', 1);
        ship1Pos = [ship1x ship1y];
        fclose(player1);
    elseif player == 2
        player2 = fopen('2.txt', 'r');
        ship2x = fscanf(player2, '%f', 1);
        ship2y = fscanf(player2, '%f', 1);
        ship2Pos = [ship2x ship2y];
        fclose(player2);
    end
    
    if player == 1
        while j == 0
            uv = (mousePos - ship1Pos)/norm(mousePos - ship1Pos);
            velo = speed * uv;
            ship1Pos = ship1Pos + velo * delta_t;
            player1 = fopen('1.txt', 'w');
            draw_object(mainAxis, ship1, ship1Pos)
            fprintf(player1, '%f %f', ship1Pos(1), ship1Pos(2));
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
            
            if ship1Pos(1)+2 > mousePos(1) && ship1Pos(1) - 2 < mousePos(1) && ship1Pos(2) + 2 > mousePos(2) && ship1Pos(2) - 2 < mousePos(2)
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
        while j == 0
            uv = (mousePos - ship2Pos)/norm(mousePos - ship2Pos);
            velo = speed * uv;
            ship2Pos = ship2Pos + velo * delta_t;
            player2 = fopen('2.txt', 'w');
            draw_object(mainAxis, ship2, ship2Pos)
            fprintf(player2, '%f %f', ship2Pos(1), ship2Pos(2));
            frewind(player2);
            fclose(player2);
            
            %Just draw player 1's ship while we determine where player 2 is
            player1 = fopen('1.txt', 'r');
            ship1x = fscanf(player1, '%f', 1);
            ship1y = fscanf(player1, '%f', 1);
            ship1Pos = [ship1x ship1y];
            draw_object(mainAxis, ship1, ship1Pos);
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
end