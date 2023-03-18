$fs = .4;

front_depth = 2;
back_depth = 5.64;

picture_thickness = .1;
clearance = .2;
tab_padding = 2.5;



module front(picture_width, picture_height, border = 2) {
    difference() {
        cube([picture_width-clearance*2, front_depth-2*picture_thickness, picture_height-clearance*2]);
        translate([border, -.01, border])
            cube([picture_width - border*2-clearance, front_depth+.02, picture_height - border*2-clearance]);
    }
    module tab_sphere() {
        sphere(d = back_depth - front_depth - tab_padding - .3);
    }
    module tabs() {
        translate([0, front_depth/2-picture_thickness, picture_height/2-clearance]) tab_sphere();
        translate([picture_width-clearance*2, front_depth/2-picture_thickness, picture_height/2-clearance]) tab_sphere();
        translate([picture_width/2-clearance, front_depth/2-picture_thickness, 0]) tab_sphere();
        translate([picture_width/2-clearance, front_depth/2-picture_thickness, picture_height-clearance*2]) tab_sphere();
    }
    tabs();
}

back_border = 2;

module back(picture_width, picture_height) {
    module frame() {
        difference() {
            cube([picture_width+back_border*2, back_depth, picture_height+back_border*2]);
            translate([back_border, -.01, back_border])
                cube([picture_width, front_depth+picture_thickness+.02, picture_height]);
        }
    }
    module tab_sphere() {
        sphere(d = back_depth - front_depth - tab_padding);
    }
    module tab_slots() {
        translate([back_border, (front_depth+picture_thickness)/2, picture_height/2+back_border]) tab_sphere();
        translate([picture_width + back_border, (front_depth+picture_thickness)/2, picture_height/2+back_border]) tab_sphere();
        translate([picture_width/2+back_border, (front_depth+picture_thickness)/2, back_border]) tab_sphere();
        translate([picture_width/2+back_border, (front_depth+picture_thickness)/2, picture_height+back_border]) tab_sphere();
    }
    module magnet_hole() {
        rotate([90, 0, 0]) 
        cylinder(h = 3, d = 5.6, center = false);
    }
    difference() {
        frame();
        translate([0, -picture_thickness, 0]) tab_slots();
        translate([picture_width/2+back_border+8, back_depth+.01, picture_height/2+back_border])
            magnet_hole();
        translate([picture_width/2+back_border-8, back_depth+.01, picture_height/2+back_border])
            magnet_hole();
    }
}



picture_width = 54.5;
picture_height = 86.5;


translate([picture_width + 10, picture_height, 0]) rotate([90,0,0]) color("red", 1) front(picture_width, picture_height);
translate([0, 0, back_depth]) rotate([-90,0,0]) back(picture_width, picture_height);