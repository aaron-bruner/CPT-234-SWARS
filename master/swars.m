function [] = swars(player)

global quitGame; global right_button; global left_button;
quitGame = false; right_button = false; left_button = false;
COUNTER = []; COUNTER = 0;
MOVING = 0;
SHIP_SPEED = 3.5;
SHIP_W = 15;
SHIP_H = 20;
PLOT_W = 200;
PLOT_H = 324;
torpedoPositions = [];
TORPEDO_SPEED = 2;
velo = 0;

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
draw_object(mainAxis, ship, [100 20]); draw_object(mainAxis, ship2, [100 300]);

ship1Positions = [];
ship2Positions = [];

print_title(axisTitle, 'SWARS');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    function moveObject
        
        %------------------------------------------------------------------%
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
        %------------------------------------------------------------------%
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
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%     function checkCollisions
%         if ship1Pos(1)+2 > mousePos(1) && ship1Pos(1) - 2 < mousePos(1) && ship1Pos(2) + 2 > mousePos(2) && ship1Pos(2) - 2 < mousePos(2)
%             
%         end
%     end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%     function moveTorpedos
%         
%         torpedos.w = 7;
%         torpedos.h = 20;
%         TORPEDOS_SHAPE = [1 0 1 2; 0 2 4 2];
%         xTorpScale = torpedos.w / max(TORPEDOS_SHAPE(1,:));
%         yTorpScale = torpedos.h / max(TORPEDOS_SHAPE(2,:));
%         
%         torpedos.outline = [TORPEDOS_SHAPE(1,:) .* xTorpScale; TORPEDOS_SHAPE(2,:) .* yTorpScale];
%         
%         torpedos.patch = patch(NaN,NaN,'g');
%         set(torpedos.patch,'LineWidth', 1);
%         set(torpedos.patch,'EdgeColor', 'green');
%         %-----------%
%         if left_button == true
%             left_button = false;
%             if player == 1
%                 mousePosition = get_mouse_position(mainAxis);
%                 p1Ship = fopen('1.txt', 'r');
%                 torpedoPos = fscanf(p1Ship, '%f %f');
%                 fclose(p1Ship);
%                 torpedoPositions = [torpedoPositions; torpedoPos(1) torpedoPos(2) mousePosition(1) mousePosition(2)];
%             elseif player == 2
%                 mousePosition = get_mouse_position(mainAxis);
%                 p2Ship = fopen('2.txt', 'r');
%                 torpedoPos = fscanf(p2Ship, '%f %f');
%                 fclose(p2Ship);
%                 torpedoPositions = [torpedoPositions; torpedoPos(1) torpedoPos(2) mousePosition(1) mousePosition(2)];
%             end
%             j=0;i=0;
%             while j == 0
%                 for torpedoNum = 1:size(torpedoPositions,1)
%                     if size(torpedoNum, 1) == 0
%                         j = 1;
%                     end
%                     while i == 0
%                         uv = (torpedoPositions(torpedoNum, 3:4) - torpedoPositions(torpedoNum, 1:2))/norm(torpedoPositions(torpedoNum,3:4) - torpedoPositions(torpedoNum, 1:2));
%                         velo = TORPEDO_SPEED * uv;
%                         i=1;
%                     end
%                     torpedoPositions(torpedoNum,1:2) = torpedoPositions(torpedoNum,1:2) + velo * delta_t;
%                     offScreenCheck = isOffScreen(torpedoPositions(torpedoNum,1:2));
%                     %isCollidingCheck = isColliding(torpedoPositions(torpedoNum,1:2));
%                     if offScreenCheck == 1
%                         torpedoPositions(torpedoNum,:) = [];
%                     end
%                     %if isCollidingCheck == 1
%                     %    pause(
%                     if size(torpedoPositions,1) ~= 0
%                         draw_torpedos(torpedoPositions(:,1:2), torpedo_object);
%                         pause(0.025);
%                     elseif size(torpedoPositions, 1) == 0
%                         j = 1;
%                     end
%                     
%                     %         if left_button == true
%                     %             left_button = false;
%                     %             j = 1;
%                     %             break
%                     %         end
%                 end
%             end
%         end
%     end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    function moveBullets
        
        %use a while loop to make a reverse for loop
        %we need to count down so we dont try to access
        %items at higher index than exist after removal
        k = size(bullets,2);
        while k > 0
            if bullets(2,k) > PLOT_H
                %remove any bullets past top of plot from bullets list
                %miraculously this works even when k is 0 or end
                bullets = [bullets(:,1:k-1), bullets(:,k+1:end)];
            end
            k = k-1;
        end
        
        if size(bullets, 2) > 0
            bullets(2,:) = bullets(2,:) + BULLET_SPEED;
        end
        
    end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    function shoot
        
        if ~gameOver %no shooting if your dead
            
            %this makes delay between bullets so they dont shoot every frame
            if bulletCounter > 0
                bulletCounter = mod(bulletCounter + 1, BULLET_DELAY);
            elseif left_button = true
                left_button = false;
                
                if energy - ENERGY_DRAIN >= 0 %only shoot if have enough energy
                    bullets(1, end+1) = heroPos(1) + (HERO_W / 2);
                    bullets(2, end) = heroPos(2) + HERO_H;
                    if superShoot > 0 %make 2 extra bullets if we have powerup.
                        bullets(1, end+1) = heroPos(1) + (HERO_W / 2) + SUPER_SPACE;
                        bullets(2, end) = heroPos(2) + HERO_H - SUPER_LAG;
                        bullets(1, end+1) = heroPos(1) + (HERO_W / 2) - SUPER_SPACE;
                        bullets(2, end) = heroPos(2) + HERO_H - SUPER_LAG;
                    end
                    bulletCounter = bulletCounter + 1;
                    energy = energy - ENERGY_DRAIN; %each shot drains energy
                    energyCounter = ENERGY_DELAY; %reset delay until restore enrgy
                    if energy < 0
                        energy = 0;
                    end
                end
                
            end
        end
        
    end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



while ~quitGame
    moveObject;
    %moveTorpedos;
    %shoot
    %checkCollisions
    %updateBars
    %refreshPlots
    %COUNTER = COUNTER + 1;
    pause(0.025);
end % End while loop
print_title(axisTitle, 'GAME OVER');

end % End for swars function