function [] = swars_copy(player)

global quitGame; global right_button; global left_button;
quitGame = false; right_button = false; left_button = false;

%------------------%
%    Constants     %
%------------------%
MOVING = 0;
SHIP_SPEED = 3.5;
TORPEDO_SPEED = 6;
velo = 0;

[mainAxis, ship, axisTitle, torpedo_object] = initialize_graphics();

%-------------------------------------------------------------------------%
%                          Setting up the ships                           %
%-------------------------------------------------------------------------%

ship1 = ship;
ship2 = ship;
ship2.patch = patch(NaN,NaN,'y');
set(ship2.patch,'LineWidth', 2);
set(ship2.patch,'EdgeColor', 'white');

%-------------------------------------------------------------------------%
%      Ensures that there are no left over values from last game          %
%-------------------------------------------------------------------------%
tempfid = fopen('1.txt', 'w'); fprintf(tempfid, '100 20'); fclose(tempfid);
tempfid = fopen('2.txt', 'w'); fprintf(tempfid, '100 300'); fclose(tempfid);

if player == 1
p1file = fopen('1.txt','w+');
p2file = fopen('2.txt','r');
fprintf(p1file, '100 20');
%fprintf(p2file, '100 300');
frewind(p1file); %frewind(p2file);
%fclose(p1file); fclose(p2file);
elseif player == 2
p1file = fopen('1.txt', 'r');
p2file = fopen('2.txt', 'w+');
fprintf(p2file, '100 300');
frewind(p2file);
end

%-------------------------------------------------------------------------%
%                Draw the ships at the starting points                    %
%-------------------------------------------------------------------------%

draw_object(mainAxis, ship, [100 20]); draw_object(mainAxis, ship2, [100 300]);

%-------------------------------------------------------------------------%
%     Ensuring that the game statistics start at the correct values       %
%-------------------------------------------------------------------------%
playerScoreFid = fopen('playerScores.txt', 'w');
fprintf(playerScoreFid, '0 0');
fclose(playerScoreFid);

shortFid = fopen('gameOverChecker.txt', 'w');
fprintf(shortFid, '0');
fclose(shortFid);

%--------------------------------------------------------%
% We want to delete any leftover torpedos from last game %
%--------------------------------------------------------%
%delete p1torps.txt p2torps.txt
fid = fclose(fopen('p1torps.txt', 'w')); fid = fclose(fopen('p2torps.txt', 'w'));
if player == 1
p1torpsfid = fopen('p1torps.txt', 'w+'); %fclose(fid);
p2torpsfid = fopen('p2torps.txt', 'r');
elseif player == 2
p2torpsfid = fopen('p2torps.txt', 'w+'); %fclose(fid);
p1torpsfid = fopen('p1torps.txt', 'r');
end

%-------------------------------------------------------------------------%
%            Pre-define the values that are going to be used              %
%-------------------------------------------------------------------------%
ship1Positions = [];
ship2Positions = [];

ship1pos = [];
ship2pos = [];

mousePos = [];

torpedo1Positions = [];
torpedo2Positions = [];

tempScores = [];

torpedo1 = [];
torpedo2 = [];

P1_HIT_P2 = 0;
P2_HIT_P1 = 0;

playerScores = [];

%-------------------------------------------------------------------------%
% Detect if any of the torpedos went off the screen and then remove them  %
%-------------------------------------------------------------------------%
    function moveObject
        
        if player == 1
            %---------------------------------------------------%
            % This checks to see if we need to re-draw our ship %
            %      because the other play's torpedo hit us      %
            %---------------------------------------------------%
            p1Test = fopen('p1HitCheck.txt', 'r');
            p1HitTest = fscanf(p1Test, '%d');
            if p1HitTest == 1
                %player1 = fopen('1.txt', 'r');
                randomShip1Position = [randi([50 150], 1), randi([15 75], 1)];
                fprintf(p1file, '%f %f', randomShip1Position(1), randomShip1Position(2));
                frewind(p1file);
                ship1Positions(1:2) = fscanf(p1file, '%f ', [2 inf])';
                frewind(p1file);
                %fclose(player1);
                draw_object(mainAxis, ship1, ship1Positions(1:2));
                fclose(p1Test);
                p1Test = fopen('p1HitCheck.txt', 'w');
                fprintf(p1Test, '0');
            end
            fclose(p1Test);
            %--------------------------------------------%
            % We need to ensure that we have the corret  %
            %  positions before we give them velocity    %
            %--------------------------------------------%
            %player1 = fopen('1.txt', 'r');
            ship1Positions(1:2) = fscanf(p1file, '%f ', [2 inf])';
            frewind(p1file);
            %fclose(player1);
            
        elseif player == 2
            %---------------------------------------------------%
            % This checks to see if we need to re-draw our ship %
            %      because the other play's torpedo hit us      %
            %---------------------------------------------------%
            p2Test = fopen('p2HitCheck.txt', 'r');
            p2HitTest = fscanf(p2Test, '%d');
            if p2HitTest == 1
                %player2 = fopen('2.txt', 'r');
                randomShip2Position = [randi([50 150], 1), randi([250 300], 1)];
                fprintf(p2file, '%f %f', randomShip2Position(1), randomShip2Position(2));
                frewind(p2file);
                ship2Positions(1:2) = fscanf(p2file, '%f ', [2 inf])';
                frewind(p2file);
                %fclose(player2);
                draw_object(mainAxis, ship2, ship2Positions(1:2));
                fclose(p2Test);
                p2Test = fopen('p2HitCheck.txt', 'w');
                fprintf(p2Test, '0');
            end
            fclose(p2Test);
            %--------------------------------------------%
            % We need to ensure that we have the corret  %
            %  positions before we give them velocity    %
            %--------------------------------------------%
            %player2 = fopen('2.txt', 'r');
            ship2Positions(1:2) = fscanf(p2file, '%f ', [2 inf])';
            frewind(p2file);
            %fclose(player2);
        end

%-------------------------------------------------------------------------%
%          This is the beginning of new movemnt calls (Right Click)       %
%-------------------------------------------------------------------------%
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
        %---------------------------------------------%
        % Write the position to the file for player 2 %
        %---------------------------------------------%
        %player1 = fopen('1.txt', 'w');
        fprintf(p1file, '%f %f', ship1Positions(1), ship1Positions(2));
        frewind(p1file);
        %fclose(player1);
        %----------------------------------------------------------%
        % Keep drawing the ship until we reach the mouse locaiton  %
        %----------------------------------------------------------%
        draw_object(mainAxis, ship1, ship1Positions(1:2));
        if ship1Positions(1)+ 2 > ship1Positions(3) && ship1Positions(1)...
                - 2 < ship1Positions(3) && ship1Positions(2) + 2 > ...
                ship1Positions(4) && ship1Positions(2) - 2 < ship1Positions(4)
            MOVING = 0;
        end
    end
%-----------------------------------------------------------------%
%  Just draw player 2's ship while we determine where player 1 is %
%-----------------------------------------------------------------%
    %player2 = fopen('2.txt', 'r');
    tempship2Positions = fscanf(p2file, '%f %f');
    frewind(p2file);
    %fclose(player2);
    draw_object(mainAxis, ship2, tempship2Positions);
%-------------------------------------------------------------------------%
%       This is the beginning of the new movement call for player 2       %
%       ( It is the same code but instead the files are switched )        %
%-------------------------------------------------------------------------%
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
        %---------------------------------------------%
        % Write the position to the file for player 2 %
        %---------------------------------------------%
        %player2 = fopen('2.txt', 'w');
        fprintf(p2file, '%f %f', ship2Positions(1), ship2Positions(2));
        frewind(p2file);
        %fclose(player2);
        %----------------------------------------------------------%
        % Keep drawing the ship until we reach the mouse locaiton  %
        %----------------------------------------------------------%
        draw_object(mainAxis, ship2, ship2Positions(1:2));
        if ship2Positions(1)+2 > ship2Positions(3) && ship2Positions(1) ...
                - 2 < ship2Positions(3) && ship2Positions(2) + 2 > ...
                ship2Positions(4) && ship2Positions(2) - 2 < ship2Positions(4)
            MOVING = 0;
        end
    end
    %---------------------------------%
    % Just draw player 1's ship while %
    % we determine where player 2 is. %
    %---------------------------------%
    %player1 = fopen('1.txt', 'r');
    tempShip1Positions = fscanf(p1file, '%f %f');
    frewind(p1file);
    %fclose(player1);
    draw_object(mainAxis, ship1, tempShip1Positions);
    %---------------------------------%
    end
    end
%-------------------------------------------------------------------------%
% Detect if any of the torpedos went off the screen and then remove them  %
%-------------------------------------------------------------------------%
    function torpedoCheck
        %---------------------------------------------------%
        %          The J variable is for player 1           %
        %   To avoid referencing invalid values we instead  %
        %     start at the end of the matrix and then go    %
        %            back towards the beginning             %
        %---------------------------------------------------%
        j = size(torpedo1Positions,1);
        while j > 0
            if torpedo1Positions(j,1) > 200 || torpedo1Positions(j,1) < 0 || ...
                    torpedo1Positions(j,2) > 324 || torpedo1Positions(j,2) < 0
                torpedo1Positions(j,:) = [];
            end
            j = j-1;
        end
        %--------------------------------%
        % The K variable is for player 2 %
        %--------------------------------%
        k = size(torpedo2Positions,1);
        while k > 0
            if torpedo2Positions(k,1) > 200 || torpedo2Positions(k,1) < 0 || ...
                    torpedo2Positions(k,2) > 324 || torpedo2Positions(k,2) < 0
                torpedo2Positions(k,:) = [];
            end
            k = k-1;
        end
    end
%-------------------------------------------------------------------------%
% Move the torpedos similarly to how we did with the ships, instead now   %
%            we are letting them go until they go off screen              %
%-------------------------------------------------------------------------%
    function moveTorpedos
        
    if left_button == true
        left_button = false;
        %----------------------------------------------------%
        %   Regardless of whether it's player 1 or player 2  %
        %  we still need the mousePos. Then, we are going to %
        %     figure out exactly where the ship is. This     %
        %         depends on which player is playing         %
        %----------------------------------------------------%
        mousePos = get_mouse_position(mainAxis);
        if player == 1
            %p1Ship = fopen('1.txt', 'r');
            ship1pos = fscanf(p1file, '%f %f', [2 inf])';
            frewind(p1file);
            %fclose(p1Ship);
        elseif player == 2
            %p2Ship = fopen('2.txt', 'r');
            ship2pos = fscanf(p2file, '%f %f', [2 inf])';
            frewind(p2file);
            %fclose(p2Ship);
        end
        %--------------------------------------------------------%
        % Now, depending on which player it is, we want to add a %
        %  torpedo to the list. Notice how we're referencing the %
        %   end of the matrix. This makes managing the list much %
        %          easier when we want to delete torpedos.       %
        %--------------------------------------------------------%
        if player == 1
            torpedoUV = (mousePos - ship1pos)/norm(mousePos - ship1pos);
            p1velo = TORPEDO_SPEED * torpedoUV;
            torpedo1Positions(end+1, 1:2) = [ship1pos(1) ship1pos(2)];
            torpedo1Positions(end, 3:4) = [p1velo(1) p1velo(2)];
            %---------------------------------------------------------%
            % Putting the values in p1torps so that player 2 can draw %
            %               the torpedos on their screen              %
            %---------------------------------------------------------%
            writematrix(torpedo1Positions, 'p1torps.txt','Delimiter','space');
        elseif player == 2
            torpedoUV = (mousePos - ship2pos)/norm(mousePos - ship2pos);
            p2velo = TORPEDO_SPEED * torpedoUV;
            torpedo2Positions(end+1, 1:2) = [ship2pos(1) ship2pos(2)];
            torpedo2Positions(end, 3:4) = [p2velo(1) p2velo(2)];
            %---------------------------------------------------------%
            % Putting the values in p1torps so that player 2 can draw %
            %               the torpedos on their screen              %
            %---------------------------------------------------------%
            writematrix(torpedo2Positions, 'p2torps.txt','Delimiter','space');
        end
    end
     %----------------------------------------------------------%
     %          Depending on the player, we want to just        %
     %                draw the opponents torpedos               %
     %----------------------------------------------------------%
    if player == 1
        %p2fid = fopen('p2torps.txt', 'r');
        torpedo2 = fscanf(p2torpsfid, '%f', [4 inf])';
        frewind(p2torpsfid);
        %fclose(p2fid);
        if size(torpedo2,1) ~= 0
            draw_torpedos(torpedo2(:,1:2), torpedo_object);
        end
        %-------------------------------------------------%
        % If there are no torpedos don't try to draw them %
        %-------------------------------------------------%
        if size(torpedo1Positions,1) ~= 0
            torpedo1Positions(:,1:2) = torpedo1Positions(:,1:2) + ...
                torpedo1Positions(:,3:4);
            writematrix(torpedo1Positions, 'p1torps.txt','Delimiter','space');
            draw_torpedos(torpedo1Positions(:,1:2), torpedo_object);
        end
    elseif player == 2
        %p1fid = fopen('p1torps.txt', 'r');
        torpedo1 = fscanf(p1torpsfid, '%f', [4 inf])';
        frewind(p1torpsfid);
        %fclose(p1fid);
        if size(torpedo1,1) ~= 0
            draw_torpedos(torpedo1(:,1:2), torpedo_object);
        end
        %-------------------------------------------------%
        % If there are no torpedos don't try to draw them %
        %-------------------------------------------------%
        if size(torpedo2Positions,1) ~= 0
            torpedo2Positions(:,1:2) = torpedo2Positions(:,1:2) + ...
                torpedo2Positions(:,3:4);
            writematrix(torpedo2Positions, 'p2torps.txt','Delimiter','space');
            draw_torpedos(torpedo2Positions(:,1:2), torpedo_object);
        end
    end
    end
%-------------------------------------------------------------------------%
% Checking the torpedos positions to see if they have collided with the   %
%                            ship positions                               %
%-------------------------------------------------------------------------%
    function checkCollisions
        %-------------------------------------------------------%
        %  Since player 1 already knows where it's own torpedos %
        % are we are going to just use those values and compare %
        %           them to player 2's ship position.           %
        %-------------------------------------------------------%
        if player == 1
            %p2id = fopen('2.txt', 'r');
            p2pos = fscanf(p2file, '%f %f');
            frewind(p2file);
            %fclose(p2id);
            %--------------------------------%
            % Using a for loop to go through %
            %    each torpedo position and   %
            %  compare it to player 2's ship %
            %--------------------------------%
            for i=1:size(torpedo1Positions,1)
            if torpedo1Positions(i,1)+ 5 > p2pos(1) && torpedo1Positions(i,1) ...
                    - 5 < p2pos(1) && torpedo1Positions(i,2) + 5 > p2pos(2) ...
                    && torpedo1Positions(i,2) - 5 < p2pos(2)
                P1_HIT_P2 = P1_HIT_P2 + 1;
                %-----------------------------------------------------%
                %    We are double checking to see if player 2 has    %
                % already won. If so, there's no point in continuing. %
                %-----------------------------------------------------%
                scorefid = fopen('playerScores.txt', 'r');
                tempScores = fscanf(scorefid, '%d %d');
                fclose(scorefid);
                if tempScores(2) == 10
                    print_title(axisTitle, 'GAME OVER - PLAYER 2 WIN');
                    quitGame = true;
                end
                tempScores = [tempScores(1)+1, tempScores(2)];
                scorefid = fopen('playerScores.txt', 'w');
                fprintf(scorefid, '%d %d', tempScores(1), tempScores(2));
                fclose(scorefid);
                %-----------------------------------------------------%
                %       Move player 2's ship to a random position     %
                %-----------------------------------------------------%
%                 fid = fopen('2.txt', 'w');
%                 randomShip2Position = [randi([50 150], 1), randi([250 300], 1)];
%                 fprintf(p2file, '%f %f', randomShip2Position(1), randomShip2Position(2));
%                 frewind(p2file);
%                 fclose(fid);
                fid = fopen('p2hitCheck.txt', 'w');
                fprintf(fid, '1');
                fclose(fid);
            end
            end
        elseif player == 2
            %p1id = fopen('1.txt', 'r');
            p1pos = fscanf(p1file, '%f %f');
            frewind(p1file);
            %fclose(p1id);
            %--------------------------------%
            % Using a for loop to go through %
            %    each torpedo position and   %
            %  compare it to player 1's ship %
            %--------------------------------%
            for i=1:size(torpedo2Positions,1)
                if torpedo2Positions(i,1)+ 5 > p1pos(1) && torpedo2Positions(i,1) ...
                        - 5 < p1pos(1) && torpedo2Positions(i,2) + 5 > p1pos(2) ...
                        && torpedo2Positions(i,2) - 5 < p1pos(2)
                    P2_HIT_P1 = P2_HIT_P1 + 1;
                    %-----------------------------------------------------%
                    %    We are double checking to see if player 1 has    %
                    % already won. If so, there's no point in continuing. %
                    %-----------------------------------------------------%
                    scorefid = fopen('playerScores.txt', 'r');
                    tempScores = fscanf(scorefid, '%d %d');
                    fclose(scorefid);
                    if tempScores(1) == 10
                        print_title(axisTitle, 'GAME OVER - PLAYER 1 WIN');
                        quitGame = true;
                    end
                    tempScores = [tempScores(1), tempScores(2)+1];
                    scorefid = fopen('playerScores.txt', 'w');
                    fprintf(scorefid, '%d %d', tempScores(1), tempScores(2));
                    fclose(scorefid);
                    %-----------------------------------------------------%
                    %       Move player 1 ship to a random position       %
                    %-----------------------------------------------------%
%                     fid = fopen('1.txt', 'w');
%                     randomShip1Position = [randi([50 150], 1), randi([15 75], 1)];
%                     fprintf(p1file, '%f %f', randomShip1Position(1), randomShip1Position(2));
%                     frewind(p1file);
%                     fclose(fid);
                    fid = fopen('p1hitCheck.txt', 'w');
                    fprintf(fid, '1');
                    fclose(fid);
                end
            end
        end
    end
%-------------------------------------------------------------------------%
%            Keep the scoreboard updated with the current score           %
%-------------------------------------------------------------------------%
    function scoreboard
        
        pscore = fopen('playerScores.txt', 'r');
        playerScores = fscanf(pscore, '%d %d', [1 inf]);
        fclose(pscore);
        
        gameTitle = sprintf('SWARS');
        player1Score = sprintf('P1:%2d', playerScores(1));
        player2Score = sprintf('P2:%2d', playerScores(2));
        print_title(axisTitle, [player1Score, '  ',gameTitle, '  ', player2Score]);
        
    end
%-------------------------------------------------------------------------%
%                        Check for score > 10                             %
%-------------------------------------------------------------------------%
    function scoreCheck

        if P1_HIT_P2 >= 10
            %----------------------------------%
            % We have to tell P2 that we won   %
            %----------------------------------%
            fid = fopen('gameOverChecker.txt', 'w');
            fprintf(fid, '1');
            fclose(fid);
            quitGame = true;
            print_title(axisTitle, 'GAME OVER - PLAYER 1 WIN');
        elseif P2_HIT_P1 >= 10
            %----------------------------------%
            % We have to tell P1 that we won   %
            %----------------------------------%
            fid = fopen('gameOverChecker.txt', 'w');
            fprintf(fid, '1');
            fclose(fid);
            quitGame = true;
            print_title(axisTitle, 'GAME OVER - PLAYER 2 WIN');
        elseif P1_HIT_P2
        end
    end
%-------------------------------------------------------------------------%
%                           MAIN FUNCTION                                 %
%-------------------------------------------------------------------------%
while ~quitGame
    torpedoCheck; % Check to see if torpedos are off screen
    moveTorpedos; % Draw the torpedos across the screen
    moveObject; % Move the ships on the screen
    checkCollisions; % Check to see if the torpedos have collided with ships
    scoreboard; % Keep the scoreboard displaying the right score
    scoreCheck; % Check to see if a player has won
    pause(0.025); % Pause for frames
    %---------------------------------------------------%
    % We want to double check that P1/P2 hasn't won yet %
    %---------------------------------------------------%
    shortFid = fopen('gameOverChecker.txt', 'r');
    gameChecker = fscanf(shortFid, '%d', 1);
    fclose(shortFid);
    if gameChecker == 1
        fid = fopen('playerScores.txt', 'r');
        playerScoresTest = fscanf(fid, '%d %d', [2 inf])';
        fclose(fid);
        if playerScoresTest(1) > playerScoresTest(2)
            print_title(axisTitle, 'GAME OVER - PLAYER 1 WIN');
            quitGame = true;
        elseif playerScoresTest(2) > playerScoresTest(1)
            print_title(axisTitle, 'GAME OVER - PLAYER 2 WIN');
            quitGame = true;
        end
    elseif quitGame == true%This would imply that the user quit early
        fid = fopen('gameOverChecker.txt', 'w');
        fprintf(fid, '1');
        fclose(fid);
        print_title(axisTitle, 'GAME OVER - NO WINNER');
    end
end % End main while loop
fclose(p1file); fclose(p2file); fclose(p1torpsfid); fclose(p2torpsfid);
end % End swars function
%-------------------------------------------------------------------------%