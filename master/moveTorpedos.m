function moveTorpedos(player, mainAxis)
%-Constants-%
speed = 1;
delta_t = 1;
%-----------%

mousePosition = get_mouse_position(mainAxis);
if player == 1
    p1Ship = fopen('1.txt', 'r');
    torpedoPos = fscanf(p1Ship, '%f %f');
    
    fclose(p1Ship);
%     torpedoPos = [mousePosition(1),mousePosition(2),p1ShipPos(1),p1ShipPos(2)];
elseif player == 2
    p2Ship = fopen('2.txt', 'r');
    torpedoPos = fscanf(p2Ship, '%f %f');
    fclose(p2Ship);
end
    
while isColliding(.) == false
    uv = (mousePosition - torpedoPos)./norm(mousePosition - torpedoPos);
    velo = speed .* uv;
    torpedoPos = torpedoPos + velo .* delta_t;
    if player == 1
        p1Torps = fopen('p1torps.txt', 'w');
        fprintf(p1Torps, '%f %f %f %f', torpedoPos, mousePosition);
        fclose(p1Torps);
    draw_torpedos(torpedoPos,torpedo_object);
    pause(0.025);
    isOffScreen(
end

end