$fs = .4;

front_depth = 2;
back_depth = 5.64;

picture_thickness = .1;
clearance = .2;
tab_padding = 2.5;

picture_width = 60;
picture_height = 61;

module front(picture_width, picture_height, border = 4) {
    translate([-front_depth, 0, -front_depth])
        cube([front_depth, front_depth+back_depth, picture_height + 2*clearance + 2*front_depth]);
    translate([picture_width+clearance*2, 0, -front_depth])
        cube([front_depth, front_depth+back_depth, picture_height + 2*clearance + 2*front_depth]);
    translate([0, 0, -front_depth])
        cube([picture_width+clearance*2, front_depth+back_depth, front_depth]);
    translate([0, 0, picture_height+clearance*2])
        cube([picture_width + 2*clearance, front_depth+back_depth, front_depth]);
    difference() {
        cube([picture_width+clearance*2, front_depth, picture_height+clearance*2]);
        translate([border, -.01, border])
            cube([picture_width - border*2-clearance, front_depth+.02, picture_height - border*2-clearance]);
    }
}


back_border = 2;

module back(picture_width, picture_height) {

    module magnet_hole() {
        rotate([90, 0, 0]) 
        cylinder(h = 2.8, d = 5.3, center = false);
    }
    difference() {
        cube([picture_width, back_depth, picture_height]);
        
        /*translate([picture_width/7, -.01, picture_height/8])
            cube([picture_width/7*5, back_depth+.02, picture_height/4]);
        translate([picture_width/7, -.01, picture_height/1.6])
            cube([picture_width/7*5, back_depth+.02, picture_height/4]);*/

        translate([picture_width/3, back_depth+.01, picture_height/2+back_border])
            magnet_hole();
        translate([picture_width/3*2, back_depth+.01, picture_height/2+back_border])
            magnet_hole();
    }
}

//back(picture_width, picture_height);


//front(picture_width, picture_height);


translate([picture_width + 10, picture_height, 0]) rotate([90,0,0]) color("red", 1) front(picture_width, picture_height);
translate([0, picture_height, 0]) rotate([90,0,0]) back(picture_width, picture_height);