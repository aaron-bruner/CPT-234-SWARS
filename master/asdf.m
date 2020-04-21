if player == 1
    if right_button == true
        right_button = false;
        MOVING = 1;
        ship1Positions(3:4) = get_mouse_position(mainAxis);
        uv = (ship1Positions(3:4) - ship1Positions(1:2))/norm(ship1Positions(3:4) - ship1Positions(1:2));
        velo = SHIP_SPEED * uv;
    end
    if MOVING == 1
        ship1Positions(1:2) = ship1Positions(1:2) + velo;
        % Write the position to the file for player 2 %
        player1 = fopen('1.txt', 'w');
        fprintf(player1, '%f %f', ship1Positions(1), ship1Positions(2));
        fclose(player1);
        %                                             %
        if ship1Positions(1)+1.5 > ship1Positions(3) && ship1Positions(1) - 1.5 < ship1Positions(3) ...
                && ship1Positions(2) + 1.5 > ship1Positions(4) && ship1Positions(2) - 1.5 < ship1Positions(4)
            MOVING = 0;
        end