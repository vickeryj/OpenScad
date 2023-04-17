wall_thickness = 1.5;
divider_thickness = 5.1;
wall_height = 10;
wall_length = 15;

cube([2*wall_length+divider_thickness+2*wall_thickness, wall_thickness, wall_height]);
translate([0, divider_thickness+wall_thickness, 0]) 
    cube([wall_length+wall_thickness, wall_thickness, wall_height]);
translate([wall_length+divider_thickness+wall_thickness, divider_thickness+wall_thickness, 0]) 
    cube([wall_length+wall_thickness, wall_thickness, wall_height]);
translate([wall_length, 2*wall_thickness+divider_thickness, 0]) 
    cube([wall_thickness, wall_length, wall_height]);
translate([wall_length+divider_thickness+wall_thickness, 2*wall_thickness+divider_thickness, 0]) 
    cube([wall_thickness, wall_length, wall_height]);
translate([0, 0, wall_height]) 
    cube([2*wall_length+divider_thickness+2*wall_thickness, wall_thickness*2+divider_thickness, wall_thickness]);
translate([wall_length, 2*wall_thickness+divider_thickness, wall_height]) 
    cube([2*wall_thickness+divider_thickness, wall_length, wall_thickness]);