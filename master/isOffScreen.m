function [offScreenCheck] = isOffScreen(torpedoPositions)

if torpedoPositions(1) < -5 || torpedoPositions(1) > 205 || torpedoPositions(2) < -5 || torpedoPositions(2) > 329
    offScreenCheck = 1;
else
    offScreenCheck = 0;
    
end
