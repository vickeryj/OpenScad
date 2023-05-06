
mount_depth = 70;
mount_thickness = 4;
wire_diameter = 2;
inset = 12.5;
wire_gap = 20;
mount_width = 65;// wire_gap+inset*2;

$fn = 120;

module top_mount() {
    difference() { 
        cube([mount_width, mount_depth, mount_thickness]);
        wires();
        translate([mount_width/2,mount_depth/4,0]) nut_hole();
        translate([mount_width/2,mount_depth/4*3,0]) nut_hole();
    }
}

module bottom_mount() {
    difference() {
        cube([mount_width, mount_depth, mount_thickness]);
        translate([0,0,mount_thickness]) wires();
        translate([mount_width/2,mount_depth/4,0]) bolt_hole();
        translate([mount_width/2,mount_depth/4*3,0]) bolt_hole();
    }
}

module wires() {
    for (i = [inset:wire_gap:mount_width]) {
        translate([i,-.01,0]) rotate([-90, 0, 0]) cylinder(h = mount_depth + .02, r = wire_diameter);
    }
}

nut_thickness = mount_thickness/2;
nut_diameter = 5;
bolt_thickness = 3;

module nut_hole() {
    translate([0,0,nut_thickness+.01]) cylinder(h = nut_thickness, d = nut_diameter, $fn = 6);
    translate([0,0,-.01]) cylinder(h = mount_thickness+.02, d = bolt_thickness);
}

bolt_head_diameter = 5;
bolt_head_thickness = 3;

module bolt_hole() {
    translate([0,0,-.01]) cylinder(h = nut_thickness, d = bolt_head_diameter);
    translate([0,0,.01]) cylinder(h = mount_thickness+.02, d = bolt_head_thickness);
}

slot_height = 7;
slot_inside_width = 34;
slot_front_inset = 24;
slot_bottom_width = 43.6;
slot_bottom_thickness = 4.3;
slot_thickener_start = 23;
slot_thickening = slot_height - 5.6;

module connector_without_cutouts() {
    cube([mount_width, mount_depth, mount_thickness]);
    translate([(mount_width - slot_inside_width)/2, slot_front_inset, -slot_height]) cube([slot_inside_width, mount_depth-slot_front_inset, slot_height]);
    translate([(mount_width - slot_bottom_width)/2, slot_front_inset, -slot_height-mount_thickness]) cube([slot_bottom_width, mount_depth-slot_front_inset, slot_bottom_thickness]);
    translate([(mount_width-slot_bottom_width)/2,slot_thickener_start+slot_front_inset,-slot_height]) cube([(slot_bottom_width-slot_inside_width)/2, mount_depth-slot_thickener_start-slot_front_inset, slot_thickening]);
    translate([(mount_width-slot_bottom_width)/2+slot_inside_width+(slot_bottom_width-slot_inside_width)/2,slot_thickener_start+slot_front_inset,-slot_height]) cube([(slot_bottom_width-slot_inside_width)/2, mount_depth-slot_thickener_start-slot_front_inset, slot_thickening]);
}

corner_cut_width = (slot_bottom_width - slot_inside_width)/2;
corner_cut_depth = 10;
center_cut_width = 23.4;
center_cut_depth = 8;

module connector() {
    difference( ) {
        connector_without_cutouts();
        translate([(mount_width - slot_bottom_width)/2 - .01,slot_front_inset-.01,-slot_height -mount_thickness-.01])
            cube([corner_cut_width+.01, corner_cut_depth, slot_bottom_thickness+.02]);
        translate([(mount_width - slot_bottom_width)/2 + slot_inside_width+ corner_cut_width,slot_front_inset-.01,-slot_height -mount_thickness-.01])
            cube([corner_cut_width+.01, corner_cut_depth, slot_bottom_thickness+.02]);
        translate([(mount_width-center_cut_width)/2, slot_front_inset-.01, -mount_thickness-slot_height-.01])
            cube([center_cut_width, center_cut_depth, slot_bottom_thickness+slot_height]);
    }
}

connector();
//translate([0,0, mount_thickness]) bottom_mount();

//top_mount();
//translate([0,0, -mount_thickness]) {
//    bottom_mount();
//}