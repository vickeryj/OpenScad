$fn = 60;

height = 39;
width = 90;
center_depth = 80;
center_width = 96;
foot_d = 13;
wall_thickness = 6;
wall_height = 4;

module frame() {
    cylinder(h = height, d = foot_d);
    translate([0, -wall_thickness/2, 0]) cube([center_width, wall_thickness, wall_height]);
    translate([center_width, 0, 0]) cylinder(h = height, d = foot_d);
    translate([center_width-wall_thickness/2, 0, 0]) cube([wall_thickness, center_depth, wall_height]);
    translate([center_width, center_depth, 0]) cylinder(h = height, d = foot_d);
    translate([0, center_depth-wall_thickness/2, 0]) cube([center_width, wall_thickness, wall_height]);
    translate([0, center_depth, 0]) cylinder(h = height, d = foot_d);
    translate([-wall_thickness/2, 0, 0]) cube([wall_thickness, center_depth, wall_height]);
}

module cutout() {
    cutout_diameter = 9;
    cutout_depth = 2;
    translate([0, 0, -cutout_diameter/2+cutout_depth])
        sphere(d = cutout_diameter);
}

difference() {
    frame();
    cutout();
    translate([center_width, 0, 0])  cutout();
    translate([center_width, center_depth, 0]) cutout();
    translate([0, center_depth, 0]) cutout();
}