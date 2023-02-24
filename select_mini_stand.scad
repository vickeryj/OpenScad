post_height = 50;
post_radius = 10;


rail_depth = 10;
rail_height = 20;
printer_feet_width = 217;
printer_feet_depth = 145;
front_rail_length = printer_feet_width;
side_rail_length = printer_feet_depth;

module post() {
    color("black", 1) cylinder(h = post_height, r = post_radius, center = false);
}

module rail(length) {
  cube([length, rail_depth, rail_height]);
}

module printer_feet() {
    color("green", 1)
        translate([0, 0, post_height]) cube([217, 145, 10]);
}

module mac_mini() {
    color("red", 1) translate([post_radius, post_radius, -.01]) cube([198,198, 37]);
}

module stand() {

    translate([0, printer_feet_depth, 0]) post(); 

    translate([rail_depth/2, 0, (post_height - rail_height)/2]) rotate([0, 0, 90]) rail(side_rail_length);

    post();

    translate([0, -post_radius/2, (post_height - rail_height)/2]) rail(front_rail_length);

    translate([printer_feet_width, 0, 0]) post();

    translate([front_rail_length+post_radius/2, 0, (post_height - rail_height)/2]) rotate([0, 0, 90]) rail(side_rail_length);

    translate([printer_feet_width, printer_feet_depth, 0]) post();
}

//stand();

module stand_with_cutout() {
    difference() {
        stand();
        mac_mini();
    }
}

//stand_with_cutout();

//printer_feet();
//mac_mini();

total_width = front_rail_length+post_radius+post_radius;
total_depth = side_rail_length+post_radius+post_radius;
total_height = post_height;
echo(total_width);
echo(total_depth);
echo(total_height);

//color("blue", .5) translate([-post_radius, -post_radius, 0]) cube([total_width, total_depth, total_height]);

module front_left_slice() {
    difference() {
        intersection() {
            stand_with_cutout();
            color("blue", .5) translate([-post_radius, -post_radius, -.01]) cube([100, 100, total_height+.02]);
        }
        color("blue", .5)  translate([100-40-post_radius, -rail_depth/2-.01, post_height/2]) cube([40+.01, rail_depth+.02, rail_height/2+.02]);
    }
}

module back_left_slice() {
    intersection() {
        stand_with_cutout();
        color("blue", .5) translate([-post_radius, -post_radius+100, -.01]) cube([100, 100, total_height+.02]);
    }
    translate([-rail_depth/2-2+.01, -post_radius+100-20, post_height/2-10]) cube([2, 40, rail_height]);
    translate([-rail_depth/2-2+.01, -post_radius+100-20, post_height/2-10-2]) cube([rail_depth+2, 40, 2]);

}

module front_right_slice() {
    difference() {
        intersection() {
            stand_with_cutout();
            color("blue", .5) translate([total_width-post_radius-100, -post_radius, -.01]) cube([100, 100, total_height+.02]);
        }
        color("blue", .5)  translate([total_width-post_radius-100-.01, -rail_depth/2-.01, post_height/2]) cube([20+.01, rail_depth+.02, rail_height/2+.02]);
        color("blue", .5)  translate([front_rail_length+post_radius/2-rail_depth-.01, 100-post_radius-20, post_height/2]) cube([rail_depth+.02, 20, rail_height/2+.02]);
    }     
}

module front_middle_slice() {
    difference() {
        intersection() {
            stand_with_cutout();
            color("blue", .1) translate([100-post_radius-40, -post_radius, -.01]) cube([total_width-post_radius*2-100-20, post_radius*2, total_height+.02]);
        }
        front_left_slice();
        front_right_slice();
    }
}

module back_right_slice() {
        intersection() {
            stand_with_cutout();
            color("blue", .5) translate([total_width-post_radius-100, 100-post_radius, -.01]) cube([100, 100, total_height+.02]);
        }
        translate([front_rail_length-post_radius/2, 100-post_radius-20-.01, (post_height - rail_height)/2+rail_height/2]) cube([rail_depth, 20+.02, rail_height/2]);
}


back_left_slice();
front_left_slice();
front_middle_slice();
front_right_slice();
back_right_slice();


