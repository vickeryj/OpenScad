include <BOSL2/std.scad>
include <BOSL2/rounding.scad>
include <BOSL2/screws.scad>

//threaded_rod(d=25, height=20, pitch=2, $fa=1, $fs=1);

$fn = 8;

plate_thickness = 31;
plate_hole_diameter = 52;
wall_thickness = 16;
cap_thickness = 4;
cap_diameter = plate_hole_diameter + 30;
screw_spec = str("M",(plate_hole_diameter - wall_thickness),",",plate_thickness);
inner_bar_diameter = 26;

module female_half() {

    module outer() {
        translate([0,0,-cap_thickness])
            cylinder(h = cap_thickness, d = cap_diameter);

        difference() {
            cylinder(h = plate_thickness, d = plate_hole_diameter, $fn = 60);
            screw_hole(screw_spec, thread=true, anchor=BOTTOM);
        }
    }
    difference() {
        outer();
        translate([0,0,-cap_thickness-.01]) 
            cylinder(plate_thickness+cap_thickness, d = inner_bar_diameter, $fn=60);
    }
}

module female_half_with_hole() {
    difference() {
        female_half();
        cylinder(plate_thickness+cap_thickness, d = inner_bar_diameter);
    }
}


module male_half() {
    module outer() {
        screw(screw_spec, anchor=BOTTOM, bevel=false);
        translate([0,0,plate_thickness])
            cylinder(h = cap_thickness, d = cap_diameter);
    }
    difference() {
        outer();
        translate([0,0,-.01])
            cylinder(plate_thickness+cap_thickness+.02, d = inner_bar_diameter, $fn=60);
    }
}

translate([0,0,cap_thickness]) female_half();
translate([cap_diameter+10,0,plate_thickness+cap_thickness]) rotate([0,180,0]) male_half();

//female_half();
//male_half();