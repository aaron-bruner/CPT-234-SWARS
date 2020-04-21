function [] = swars(player)

global quitGame; global right_button; global left_button;
quitGame = false; right_button = false; left_button = false;

%Constants%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
MOVING = 0;
SHIP_SPEED = 3.5;
TORPEDO_SPEED = 5;
velo = 0;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[mainAxis, ship, axisTitle, torpedo_object] = initialize_graphics();

%-------------------------------------------------------------------------%
%                          Setting up the ships                           %
%-------------------------------------------------------------------------%
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
draw_object(mainAxis, ship, [100 20]); draw_object(mainAxis, ship2, [100 300]);
%-------------------------------------------------------------------------%

ship1Positions = [];
ship2Positions = [];

torpedo1Positions = [];
torpedo2Positions = [];

P1_HIT_P2 = [];
P2_HIT_P1 = [];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    function moveObject
        
        %-----------------------------------------------------------------%
        if player == 1
            %Ensuring that we have the correct positions by referencing the
            %file
            player1 = fopen('1.txt', 'r');
            ship1x = fscanf(player1, '%f', 1);
            ship1y = fscanf(player1, '%f', 1);
            ship1Positions(1:2) = [ship1x ship1y];
            fclose(player1);
        elseif player == 2
            player2 = fopen('2.txt', 'r');
            ship2x = fscanf(player2, '%f', 1);
            ship2y = fscanf(player2, '%f', 1);
            ship2Positions(1:2) = [ship2x ship2y];
            fclose(player2);
        end
        %-----------------------------------------------------------------%
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
            draw_object(mainAxis, ship1, ship1Positions(1:2));

            %Just draw player 2's ship while we determine where player 1 is
            %going
            player2 = fopen('2.txt', 'r');
            ship2x = fscanf(player2, '%f', 1);
            ship2y = fscanf(player2, '%f', 1);
            ship2Positions(1:2) = [ship2x ship2y];
            fclose(player2);
            draw_object(mainAxis, ship2, ship2Positions(1:2));
            if ship1Positions(1)+1.5 > ship1Positions(3) && ship1Positions(1) - 1.5 < ship1Positions(3) ...
                    && ship1Positions(2) + 1.5 > ship1Positions(4) && ship1Positions(2) - 1.5 < ship1Positions(4)
                MOVING = 0;
            end
        end
    elseif player == 2
        if right_button == true
            right_button = false;
            MOVING = 1;
            ship2Positions(3:4) = get_mouse_position(mainAxis);
            uv = (ship2Positions(3:4) - ship2Positions(1:2))/norm(ship2Positions(3:4) - ship2Positions(1:2));
            velo = SHIP_SPEED * uv;
        end
        if MOVING == 1
            ship2Positions(1:2) = ship2Positions(1:2) + velo;
            % Write the position to the file for player 2 %
            player2 = fopen('2.txt', 'w');
            fprintf(player2, '%f %f', ship2Positions(1), ship2Positions(2));
            fclose(player2);
            %                                             %
            draw_object(mainAxis, ship2, ship2Positions(1:2));

            %Just draw player 1's ship while we determine where player 1 is
            %going
            player1 = fopen('1.txt', 'r');
            ship1x = fscanf(player1, '%f', 1);
            ship1y = fscanf(player1, '%f', 1);
            ship1Positions(1:2) = [ship1x ship1y];
            fclose(player1);
            draw_object(mainAxis, ship1, ship1Positions(1:2));
            if ship2Positions(1)+1.5 > ship2Positions(3) && ship2Positions(1) - 1.5 < ship2Positions(3) ...
                    && ship2Positions(2) + 1.5 > ship2Positions(4) && ship2Positions(2) - 1.5 < ship2Positions(4)
                MOVING = 0;
            end
        end
    end
    end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    function torpedoCheck
    %-------------------------------------------------------------------------%
    % Detect if any of the torpedos went off the screen and then remove them  %
    %-------------------------------------------------------------------------%
    j = size(torpedo1Positions,1);
    while j > 0
        if torpedo1Positions(j,1) > 200 | torpedo1Positions(j,1) < 0 | ...
                torpedo1Positions(j,2) > 324 | torpedo1Positions(j,2) < 0
            torpedo1Positions(j,:) = [];
        end
        j = j-1;
    end
    k = size(torpedo2Positions,1);
    while k > 0
        if torpedo2Positions(k,1) > 200 | torpedo2Positions(k,1) < 0 | ...
                torpedo2Positions(k,2) > 324 | torpedo2Positions(k,2) < 0
            torpedo2Positions(k,:) = [];
        end
        k = k-1;
    end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    function moveTorpedos

        if left_button == true
            left_button = false;
            mousePos = get_mouse_position(mainAxis);
            if player == 1
                p1Ship = fopen('1.txt', 'r');
                ship1pos = fscanf(p1Ship, '%f %f');
                fclose(p1Ship);
        end
        if player == 1


            torpedoUV = (temptorpedo1Positions(3:4) - torpedoPos)/norm(temptorpedo1Positions(3:4) - torpedoPos);
            p1velo = TORPEDO_SPEED * torpedoUV;
            torpedo1Positions = [torpedo1Positions; torpedoPos(1) torpedoPos(2) p1velo(1) p1velo(2)];
            p1torp = fopen('p1torps.txt', 'w');
            fprintf(p1torp, '%f %f %f %f', torpedo1Positions');
            fclose(p1torp);
        elseif player == 2
            temptorpedo2Positions(3:4) = get_mouse_position(mainAxis);
            p2Ship = fopen('2.txt', 'r');
            torpedoPos = fscanf(p2Ship, '%f %f');
            fclose(p2Ship);
            torpedoUV = (temptorpedo2Positions(3:4) - torpedoPos)/norm(temptorpedo2Positions(3:4) - torpedoPos);
            p2velo = TORPEDO_SPEED * torpedoUV;
            torpedo2Positions = [torpedo2Positions; torpedoPos(1) torpedoPos(2) p2velo(1) p2velo(2)];
            p2torp = fopen('p2torps.txt', 'w');
            fprintf(p2torp, '%f %f %f %f', torpedo2Positions');
            fclose(p2torp);
        end
        %----------------------------------------------------------%
        
        if player == 1
            if size(torpedo1Positions,1) ~= 0
                torpedo1Positions(:,1:2) = torpedo1Positions(:,1:2) + torpedo1Positions(:,3:4);
                p1torp = fopen('p1torps.txt', 'w');
                fprintf(p1torp, '%f %f %f %f\n', torpedo1Positions');
                fclose(p1torp);
                draw_torpedos(torpedo1Positions(:,1:2), torpedo_object);
            end
        elseif player == 2
            if size(torpedo2Positions,1) ~= 0
                torpedo2Positions(:,1:2) = torpedo2Positions(:,1:2) + torpedo2Positions(:,3:4);
                p2torp = fopen('p2torps.txt', 'w');
                fprintf(p2torp, '%f %f %f %f\n', torpedo2Positions');
                fclose(p2torp);
                draw_torpedos(torpedo2Positions(:,1:2), torpedo_object);
            end
        end
    end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% function shoot
% 
%     if ~quitGame %no shooting if your dead
% 
%         %this makes delay between bullets so they dont shoot every frame
%         if bulletCounter > 0
%             bulletCounter = mod(bulletCounter + 1, BULLET_DELAY);
%         elseif left_button = true
%             left_button = false;
% 
%             if energy - ENERGY_DRAIN >= 0 %only shoot if have enough energy
%                 bullets(1, end+1) = heroPos(1) + (HERO_W / 2);
%                 bullets(2, end) = heroPos(2) + HERO_H;
%                 if superShoot > 0 %make 2 extra bullets if we have powerup.
%                     bullets(1, end+1) = heroPos(1) + (HERO_W / 2) + SUPER_SPACE;
%                     bullets(2, end) = heroPos(2) + HERO_H - SUPER_LAG;
%                     bullets(1, end+1) = heroPos(1) + (HERO_W / 2) - SUPER_SPACE;
%                     bullets(2, end) = heroPos(2) + HERO_H - SUPER_LAG;
%                 end
%                 bulletCounter = bulletCounter + 1;
%                 energy = energy - ENERGY_DRAIN; %each shot drains energy
%                 energyCounter = ENERGY_DELAY; %reset delay until restore enrgy
%                 if energy < 0
%                     energy = 0;
%                 end
%             end
% 
%         end
%     end
% 
% end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    function checkCollisions
        if player == 1
            p2id = fopen('2.txt', 'r');
            p2pos = fscanf(p2id, '%f %f');
            fclose(p2id);
            for i=1:size(torpedo1Positions,1)
                if torpedo1Positions(i,1)+ 3 > p2pos(1) && torpedo1Positions(i,1) ...
                        - 3 < p2pos(1) && torpedo1Positions(i,2) + 3 > p2pos(2) ...
                        && torpedo1Positions(i,2) - 3 < p2pos(2)
                    P1_HIT_P2 = P1_HIT_P2 + 1;
                end
            end
        elseif player == 2
            p1id = fopen('1.txt', 'r');
            p1pos = fscanf(p1id, '%f %f');
            fclose(p1id);
            for i=1:size(torpedo2Positions,1)
                if torpedo2Positions(i,1)+ 3 > p1pos(1) && torpedo2Positions(i,1) ...
                        - 3 < p1pos(1) && torpedo2Positions(i,2) + 3 > p1pos(2) ...
                        && torpedo2Positions(i,2) - 3 < p1pos(2)
                    P2_HIT_P1 = P2_HIT_P1 + 1;
                end
            end
            
        end
        
    end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
print_title(axisTitle, 'SWARS');
while ~quitGame
    torpedoCheck;
    moveTorpedos;
    moveObject;
    %shoot;
    checkCollisions;
    %updateBars
    %refreshPlots
    %COUNTER = COUNTER + 1;
    pause(0.025);
end % End while loop
print_title(axisTitle, 'GAME OVER');
end % End for swars function