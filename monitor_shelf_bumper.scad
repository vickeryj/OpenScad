margin = .2;
shelf_width = 16;
shelf_depth = 260;
shelf_height = 15.9;

module shelf_end() {
    cube([shelf_width+margin*2, shelf_depth+margin*2, shelf_height+margin*2]);
}

bumper_thickness = 1.5;

module bumper() {
    difference() {
        cube([bumper_thickness+shelf_width+margin*2, bumper_thickness*2+shelf_depth+margin*2, bumper_thickness*2+shelf_height+margin*2]);
        translate([bumper_thickness + .01, bumper_thickness, bumper_thickness])
            shelf_end();
    }
}

bumper();