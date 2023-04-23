$fn = 120;

outer_diameter = 40.8;
thickness = 2.5;
cutoff = 28.5;
height = 15.5;

difference() {
    cylinder(h = height , d = outer_diameter);
    translate([0,0,-0.01]) cylinder(h = 16.02, d = outer_diameter - thickness);
    translate([-outer_diameter/2, -outer_diameter/2-cutoff, -.01]) cube([outer_diameter, outer_diameter, height+.02]);
}

plug_diameter = 4.68;
plug_height = 4.65;

translate([0,outer_diameter/2+plug_height-.01,plug_diameter/2+5.82]) rotate([90,0,0]) cylinder(h=plug_height, d = plug_diameter);