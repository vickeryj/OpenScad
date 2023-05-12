mount_depth = 113.4;
mount_thickness = 5.4;
wire_diameter = 4.1;
inset = 12.5;
wire_gap = 20;
mount_width = 65;

$fn = 120;

module top_mount() {
    difference() { 
        cube([mount_width, mount_depth, mount_thickness]);
        wires();
        
        translate([mount_width/3,mount_depth/6*2.5,0]) nut_hole();
        translate([mount_width/3*2,mount_depth/6*2.5,0]) nut_hole();
    }
}

module bottom_mount() {
    difference() {
        cube([mount_width, mount_depth, mount_thickness]);
        translate([0,0,mount_thickness]) wires();
        
        translate([mount_width/3*2,mount_depth/6*2.5,-mount_thickness*3]) cylinder(h = mount_thickness*4+.02, d = bolt_thickness);
        translate([mount_width/3,mount_depth/6*2.5,-mount_thickness*3]) cylinder(h = mount_thickness*4+.02, d = bolt_thickness);
    }
}

module wires() {
    for (i = [inset:wire_gap:mount_width]) {
        translate([i,-.01,0]) rotate([-90, 0, 0]) cylinder(h = mount_depth + .02, d = wire_diameter);
    }
}

nut_thickness = 3.5;
nut_diameter = 8.3;
bolt_thickness = 4.3;

module nut_hole() {
    translate([0,0,mount_thickness-nut_thickness+.01]) cylinder(h = nut_thickness, d = nut_diameter, $fn = 6);
    translate([0,0,-mount_thickness*3-.01]) cylinder(h = mount_thickness*4+.02, d = bolt_thickness);
}

bolt_head_diameter = 7.1;
bolt_head_thickness = 4.2;
bolt_length = 22.3; // m18

module bolt_hole(length = bolt_length) {
    translate([0,0,-.01]) cylinder(h = bolt_head_thickness, d = bolt_head_diameter);
    translate([0,0,.01]) cylinder(h = length, d = bolt_thickness);
}

slot_height = 7;
slot_inside_width = 33.6;
slot_front_inset = 22;
slot_bottom_width = 43.6;
slot_bottom_thickness = 4.3;
slot_thickener_start = 25;
slot_thickening = slot_height - 5.6;
slot_back_inset = 16;
connector_depth = 72 - slot_front_inset - slot_back_inset;



module connector_without_cutouts() {
    //cube([mount_width, mount_depth, mount_thickness]);
    translate([(mount_width - slot_inside_width)/2, slot_front_inset, -slot_height]) cube([slot_inside_width, connector_depth, slot_height]);
    translate([(mount_width - slot_bottom_width)/2, slot_front_inset, -slot_height-slot_bottom_thickness]) 
        cube([slot_bottom_width, connector_depth, slot_bottom_thickness]);
    translate([(mount_width-slot_bottom_width)/2,slot_thickener_start+slot_front_inset,-slot_height]) 
        cube([(slot_bottom_width-slot_inside_width)/2, connector_depth - slot_thickener_start, slot_thickening]);
    translate([(mount_width-slot_inside_width)/2+slot_inside_width,slot_thickener_start+slot_front_inset,-slot_height]) 
        cube([(slot_bottom_width-slot_inside_width)/2, connector_depth - slot_thickener_start, slot_thickening]);
}

corner_cut_width = (slot_bottom_width - slot_inside_width)/2;
corner_cut_depth = 10;
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

module connector_with_bolt_holes() {
    difference() {
        connector();
        #translate([mount_width/3,mount_depth/6*2.5,-slot_bottom_thickness-slot_height]) bolt_hole();
        #translate([mount_width/3*2,mount_depth/6*2.5,-slot_bottom_thickness-slot_height]) bolt_hole();
    }
}


module mount_test_print() {
    intersection() {
        translate([5,30,0]) cube(24);
        bottom_mount();
    }
    translate([30,0,0]) {
        intersection() {
            translate([5,30,0]) cube(24);
            translate([0,0,mount_thickness]) top_mount();
        }
    }
}


connector_slot_width = 52;
connector_slot_bottom_height = 5.2;
connector_slot_bottom_thickness = 5.2;
connector_slot_height = connector_slot_bottom_height+connector_slot_bottom_thickness;
connector_slot_depth = 32;
connector_slot_plate = 7;
connector_slot_thickener_start = 10;

connector_slot_inside_width = 35.7;
connector_slot_bottom_width = 43.7;
connector_slot_thickening = 1;

thickener_width = (connector_slot_bottom_width-connector_slot_inside_width)/2;


module connector_slot() {
    difference() {
        cube([connector_slot_width, connector_slot_depth+connector_slot_plate, connector_slot_height]);
        translate([(connector_slot_width-connector_slot_bottom_width)/2, -.01, -.01])
            cube([connector_slot_bottom_width, connector_slot_depth, connector_slot_bottom_thickness+.02]);
        translate([(connector_slot_width-connector_slot_inside_width)/2, -.01, connector_slot_bottom_thickness-.01])
            cube([connector_slot_inside_width, connector_slot_depth, connector_slot_bottom_height+.02]);
        
    }
    translate(
                [(
                    connector_slot_width-connector_slot_bottom_width)/2,
                    connector_slot_thickener_start,
                    connector_slot_bottom_thickness-connector_slot_thickening+.01
                ]) 
            cube([thickener_width, connector_slot_depth - connector_slot_thickener_start, connector_slot_thickening]);
    translate(
                [
                    connector_slot_width - (connector_slot_width-connector_slot_bottom_width)/2-thickener_width,
                    connector_slot_thickener_start,
                    connector_slot_bottom_thickness-connector_slot_thickening+.01
                ]) 
            cube([thickener_width, connector_slot_depth - connector_slot_thickener_start, connector_slot_thickening]);
}

module connector_slot_with_bolt_holes() {
    translate([connector_slot_width,0,connector_slot_height]) rotate([180,0,180]) connector_slot();
    difference() {
        translate([0,0, connector_slot_height]) cube([connector_slot_width, connector_slot_depth+connector_slot_plate, connector_slot_plate]);
        #translate([connector_slot_width/7*2.04,(connector_slot_depth + connector_slot_plate)/2,connector_slot_height]) bolt_hole(18);
        #translate([connector_slot_width/7*4.95,(connector_slot_depth + connector_slot_plate)/2,connector_slot_height]) bolt_hole(18);
    }
}

module short_top_mount() {
    intersection() {
        translate([0, (mount_depth - connector_slot_depth)/2.7, 0]) cube([mount_width, connector_slot_depth, mount_thickness]);
        top_mount();
    }
}


module display_connector_slot() {
    connector_slot_with_bolt_holes();
    translate([-6.5,-27.9,connector_slot_height+connector_slot_plate]) {
        bottom_mount();
        translate([0, 0, mount_thickness]) short_top_mount();
    }
}


module display_slot() {
    translate([80, 0, 10]) {
        connector_with_bolt_holes();
        bottom_mount();
        translate([0,0,mount_thickness])top_mount();
    }

}

module print_mounts() {
    short_top_mount();
    translate([80, 0, 0]) top_mount();
}

//display_connector_slot();

connector_slot_with_bolt_holes();
