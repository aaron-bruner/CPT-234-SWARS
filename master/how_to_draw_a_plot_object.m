%This code goes in initalize_graphics

%host torpedos
TORPEDO_1_FACE_COLOR = [0.1 0.7 0.1];
TORPEDO_1_EDGE_COLOR = [0.1 0.7 0.1];
TORPEDO_1_SHAPE = 'd';
TORPEDO_1_SIZE = 5;
torpedo_1 = plot(NaN,NaN);
set(torpedo_1, 'Marker', TORPEDO_1_SHAPE);
set(torpedo_1, 'MarkerFaceColor', TORPEDO_1_FACE_COLOR);
set(torpedo_1, 'MarkerEdgeColor', TORPEDO_1_EDGE_COLOR);
set(torpedo_1, 'MarkerSize', TORPEDO_1_SIZE);
set(torpedo_1, 'LineStyle', 'None');