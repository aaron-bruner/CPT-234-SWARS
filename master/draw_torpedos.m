function [] = draw_torpedos(torpedos,torpedoplot)
%draw torpedos
%Input arguments
%   torpedos - an nx2 array of torpedo positions
%   plot - plot object for the torpedo
%Output arguments
%   none

if size(torpedos, 1) > 0
  set(torpedoplot, 'XData', torpedos(:,1), 'YData', torpedos(:,2));
else
  set(torpedoplot, 'XData', NaN, 'YData', NaN);
end