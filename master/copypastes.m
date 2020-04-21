moveTorpedos copy pastes
        ----------------------------------------------------------%
        if left_button == true
            left_button = false;
            numTorps = numTorps +1;
            if player == 1
                mousePos = get_mouse_position(mainAxis);
                ship1fid = fopen('1.txt', 'r');
                tempShip1Positionx = fscanf(ship1fid, '%f', 1);
                tempShip1Positiony = fscanf(ship1fid, '%f', 1);
                tempShip1Positions = [tempShip1Positionx, tempShip1Positiony];
                fclose(ship1fid);
                temp1uv = (mousePos - tempShip1Positions)/norm(mousePos - tempShip1Positions);
                tempvelo = TORPEDO_SPEED * temp1uv;
                torp1Velo = [torp1Velo; tempvelo];
                torpedo1Positions = [torpedo1Positions; tempShip1Positions]
            end
        end
        if numTorps > 0
            torpedo1Positions = torpedo1Positions + torp1Velo;
           draw_torpedos(torpedo1Positions, torpedo_object);
        end
        j = numTorps;
        while j >= 0
            if torpedo1Positions(j,1) > 200 | torpedo1Positions(j,1) < 0 | torpedo1Positions(j,2) > 324 | torpedo1Positions(j,2) < 0
                torpedo1Positions(j,:) = [];
                numTorps=numTorps-1;
            end
            j=j-1;
        end
        
    end