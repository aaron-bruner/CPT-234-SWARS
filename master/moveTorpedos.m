function [torpedoPositions] = moveTorpedos(player, mainAxis, torpedoPositions, torpedo_object)
%-Constants-%
speed = 2;
delta_t = 1;

torpedos.w = 7;
torpedos.h = 20;
TORPEDOS_SHAPE = [1 0 1 2; 0 2 4 2];
xTorpScale = torpedos.w / max(TORPEDOS_SHAPE(1,:));
yTorpScale = torpedos.h / max(TORPEDOS_SHAPE(2,:));

torpedos.outline = [TORPEDOS_SHAPE(1,:) .* xTorpScale; TORPEDOS_SHAPE(2,:) .* yTorpScale];

torpedos.patch = patch(NaN,NaN,'g');
set(torpedos.patch,'LineWidth', 1);
set(torpedos.patch,'EdgeColor', 'green');
global left_button;
%-----------%
if left_button == true
    left_button = false;
    if player == 1
        mousePosition = get_mouse_position(mainAxis);
        p1Ship = fopen('1.txt', 'r');
        torpedoPos = fscanf(p1Ship, '%f %f');
        fclose(p1Ship);
        torpedoPositions = [torpedoPositions; torpedoPos(1) torpedoPos(2) mousePosition(1) mousePosition(2)];
    elseif player == 2
        mousePosition = get_mouse_position(mainAxis);
        p2Ship = fopen('2.txt', 'r');
        torpedoPos = fscanf(p2Ship, '%f %f');
        fclose(p2Ship);
        torpedoPositions = [torpedoPositions; torpedoPos(1) torpedoPos(2) mousePosition(1) mousePosition(2)];
    end
    j=0;i=0;
    while j == 0
        for torpedoNum = 1:size(torpedoPositions,1)
            if size(torpedoNum, 1) == 0
                j = 1;
            end
            while i == 0
                uv = (torpedoPositions(torpedoNum, 3:4) - torpedoPositions(torpedoNum, 1:2))/norm(torpedoPositions(torpedoNum,3:4) - torpedoPositions(torpedoNum, 1:2));
                velo = speed * uv;
                i=1;
            end
            torpedoPositions(torpedoNum,1:2) = torpedoPositions(torpedoNum,1:2) + velo * delta_t;
            offScreenCheck = isOffScreen(torpedoPositions(torpedoNum,1:2));
            %isCollidingCheck = isColliding(torpedoPositions(torpedoNum,1:2));
            if offScreenCheck == 1
                torpedoPositions(torpedoNum,:) = [];
            end
            %if isCollidingCheck == 1
            %    pause(
            if size(torpedoPositions,1) ~= 0
                draw_torpedos(torpedoPositions(:,1:2), torpedo_object);
                pause(0.025);
            elseif size(torpedoPositions, 1) == 0
                j = 1;
            end
            
            %         if left_button == true
            %             left_button = false;
            %             j = 1;
            %             break
            %         end
        end
    end
end
%         if player == 1
%             p1Torps = fopen('p1torps.txt', 'w');
%             fprintf(p1Torps, '%f %f %f %f', torpedoPos, mousePosition);
%             fclose(p1Torps);
%             draw_torpedos(torpedoPos,torpedo_object);
%             pause(0.025);
%             isOffScreen(
%         end