
mount_depth = 72;
//mount_depth = 70-12;
mount_thickness = 8;
wire_diameter = 4;
inset = 12.5;
wire_gap = 20;
mount_width = 65;// wire_gap+inset*2;

$fn = 120;

module top_mount() {
    difference() { 
        cube([mount_width, mount_depth, mount_thickness]);
        wires();
        
        translate([mount_width/3,mount_depth/6,0]) nut_hole();
        translate([mount_width/3*2,mount_depth/6,0]) nut_hole();
        translate([mount_width/3,mount_depth/6*5,0]) nut_hole();
        translate([mount_width/3*2,mount_depth/6*5,0]) nut_hole();
    }
}

module bottom_mount() {
    difference() {
        cube([mount_width, mount_depth, mount_thickness]);
        translate([0,0,mount_thickness]) wires();
        
        translate([mount_width/3,mount_depth/6,0]) bolt_hole();
        translate([mount_width/3*2,mount_depth/6,0]) bolt_hole();
        translate([mount_width/3,mount_depth/6*5,0]) bolt_hole();
        translate([mount_width/3*2,mount_depth/6*5,0]) bolt_hole();
    }
}

module wires() {
    for (i = [inset:wire_gap:mount_width]) {
        translate([i,-.01,0]) rotate([-90, 0, 0]) cylinder(h = mount_depth + .02, r = wire_diameter);
    }
}

nut_thickness = 3.5;
nut_diameter = 8.1;
bolt_thickness = 4.1;

module nut_hole() {
    translate([0,0,mount_thickness-nut_thickness+.01]) cylinder(h = nut_thickness, d = nut_diameter, $fn = 6);
    translate([0,0,-.01]) cylinder(h = mount_thickness+.02, d = bolt_thickness);
}

bolt_head_diameter = 7.1;
bolt_head_thickness = 4.2;

module bolt_hole() {
    translate([0,0,-.01]) cylinder(h = nut_thickness, d = bolt_head_diameter);
    translate([0,0,.01]) cylinder(h = mount_thickness+.02, d = bolt_head_thickness);
}

slot_height = 7;
slot_inside_width = 33.6;
slot_front_inset = 22;
slot_bottom_width = 43.6;
slot_bottom_thickness = 4.3;
slot_thickener_start = 25;
slot_thickening = slot_height - 5.6;
slot_back_inset = 16;

module connector_without_cutouts() {
    //cube([mount_width, mount_depth, mount_thickness]);
    translate([(mount_width - slot_inside_width)/2, slot_front_inset, -slot_height]) cube([slot_inside_width, mount_depth-slot_front_inset-slot_back_inset, slot_height]);
    translate([(mount_width - slot_bottom_width)/2, slot_front_inset, -slot_height-slot_bottom_thickness]) 
        cube([slot_bottom_width, mount_depth-slot_front_inset-slot_back_inset, slot_bottom_thickness]);
    translate([(mount_width-slot_bottom_width)/2,slot_thickener_start+slot_front_inset,-slot_height]) 
        cube([(slot_bottom_width-slot_inside_width)/2, mount_depth-slot_thickener_start-slot_front_inset-slot_back_inset, slot_thickening]);
    translate([(mount_width-slot_inside_width)/2+slot_inside_width,slot_thickener_start+slot_front_inset,-slot_height]) 
        cube([(slot_bottom_width-slot_inside_width)/2, mount_depth-slot_thickener_start-slot_front_inset-slot_back_inset, slot_thickening]);
}

corner_cut_width = (slot_bottom_width - slot_inside_width)/2;
corner_cut_depth = 10;
//center_cut_width = 23.4;
center_cut_width = 24;
center_cut_depth = 8;


module connector() {
    difference( ) {
        connector_without_cutouts();
        translate([(mount_width - slot_bottom_width)/2 - .01,slot_front_inset-.01,-slot_height -slot_bottom_thickness-.01])
            cube([corner_cut_width+.01, corner_cut_depth, slot_bottom_thickness+.02]);
        translate([(mount_width - slot_bottom_width)/2 + slot_inside_width+ corner_cut_width,slot_front_inset-.01,-slot_height -slot_bottom_thickness-.01])
            cube([corner_cut_width+.01, corner_cut_depth, slot_bottom_thickness+.02]);
        translate([(mount_width-center_cut_width)/2, slot_front_inset-.01, -slot_bottom_thickness-slot_height-.01])
            cube([center_cut_width, center_cut_depth, slot_bottom_thickness+slot_height+.02]);
    }
}

connector();
//cube([mount_width, mount_depth, mount_thickness]);
bottom_mount();

//translate([0,0,mount_thickness]) top_mount();
//translate([0,0, -mount_thickness]) {
//    bottom_mount();
//}