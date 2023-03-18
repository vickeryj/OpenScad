
$fn = 30;

module magnet_test(hole_height, hole_diameter, height_step, diameter_step) {
    width_depth = hole_diameter * 6;
    height = hole_height + height_step + .3;
    
    module tester() {
        cube([width_depth, width_depth, height]);
    }
    
    module magnet_holes() {
        for (i = [-1 : 1 : 1]) {
            for (j = [-1 : 1 : 1]) {
                current_hole_height = hole_height + i * height_step;
                current_hole_diameter = hole_diameter + j * diameter_step;
                hole_x = width_depth/3*(i+1)+hole_diameter;
                hole_y = width_depth/3*(j+1)+hole_diameter;
                echo(str(hole_x, ",", hole_y, " h: ", current_hole_height, " dia: ", current_hole_diameter));
                translate([hole_x, hole_y, height-current_hole_height+.01])
                    cylinder(h = current_hole_height, d = current_hole_diameter, center = false);
                translate([hole_x, hole_y, -.2])
                    cylinder(h = height+.02, d = 2, center = false);


             }
         }
    }
    difference() {
        tester();
        magnet_holes();
    }

}


//magnet_test(3, 5.55, .2, .05);
//magnet_test(2.4, 5.40, .2, .05);
//magnet_test(2.8, 5.30, .2, .05);

// winner is 2.8 or 3.0, 5.30

//after EM tuning -- start with measured magnet size + padding
magnet_test(2.8, 5.2, .2, .05);

// 2.6, 5.2 at .24 layer hight