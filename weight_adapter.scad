include <BOSL2/std.scad>
include <BOSL2/rounding.scad>
include <BOSL2/screws.scad>

//threaded_rod(d=25, height=20, pitch=2, $fa=1, $fs=1);

$fn = 60;

plate_thickness = 32;
plate_hole_diameter = 52;
wall_thickness = 11;
cap_thickness = 6;
cap_diameter = plate_hole_diameter + 20;
screw_spec = str("M",(plate_hole_diameter - wall_thickness),"x3,",plate_thickness);
inner_bar_diameter = 28;
shank_length = 8;

module female_half() {

    module outer() {
        module unscrewed() {
            join_prism(circle(d=plate_hole_diameter,$fn=60),base="plane", length=12, fillet=3, n=12);
            translate([0,0,-cap_thickness])
                cylinder(h = cap_thickness, d = cap_diameter, $fn = 6);
            cylinder(h = plate_thickness, d = plate_hole_diameter);
        }

        difference() {
            unscrewed();
            screw_hole(screw_spec, thread=true, anchor=BOTTOM, thread_len = plate_thickness-shank_length, tolerance="6G");
        }
    }
    difference() {
        outer();
        translate([0,0,-cap_thickness-.01]) 
            cylinder(plate_thickness+cap_thickness, d = inner_bar_diameter);
    }
}

module female_half_with_hole() {
    difference() {
        female_half();
        cylinder(plate_thickness+cap_thickness, d = inner_bar_diameter);
    }
}

undersize_by = .5;

module male_half() {
    module outer() {
        translate([0,0,0]) {
            join_prism(circle(d=plate_hole_diameter - wall_thickness - undersize_by*2,$fn=60),base="plane",length=4, fillet=3, n=12);
            cylinder(h = cap_thickness, d = cap_diameter, $fn = 6, anchor=TOP);
        }
        translate([0,0,plate_thickness]) rotate([180,0,0]) screw(screw_spec, anchor=BOTTOM, bevel=false, thread_len = plate_thickness - shank_length, shaft_undersize=undersize_by);
    }
    difference() {
        outer();
        translate([0,0,-cap_thickness-.01])
            cylinder(plate_thickness+cap_thickness+.02, d = inner_bar_diameter);
    }
}

translate([0,0,0]) female_half();
//translate([cap_diameter+10,0,plate_thickness+cap_thickness]) male_half();//rotate([0,180,0]) male_half();

//#color("red", 0.1) female_half();
translate([cap_diameter+10,0,0]) male_half();