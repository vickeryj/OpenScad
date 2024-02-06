// (c) 2020 entrhopi - Alexander Freynik
// https://www.thingiverse.com/entrhopi/designs
// Parametric 2020 Extrusion Cover

$length = 130;

translate([0, $length, 0]) rotate(90, [1, 0, 0]) linear_extrude($length) polygon(
    points = [
        [0.0, 0.0],
        [7.2, 0.0],
        [7.2, 0.6],
        [6.6, 1.2],
        [6.6, 2.1],
        [7.0, 2.5],
        [7.0, 2.7],
        [6.8, 2.9],
        [5.8, 2.9],
        [5.8, 0.6],
        [1.4, 0.6],
        [1.4, 2.9],
        [0.4, 2.9],
        [0.2, 2.7],
        [0.2, 2.5],
        [0.6, 2.1],
        [0.6, 1.2],
        [0.0, 0.6]
    ]
);