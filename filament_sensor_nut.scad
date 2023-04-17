use </Users/vickeryj/Code/OpenSCAD/threads.scad>

nut_diameter = 3;
tolerance = 0.4;
opening_width = 6.5;
clearance_width = 12;

module insert() {
    difference() {
        cube([opening_width, clearance_width, NutThickness(nut_diameter)+1]);
        translate([opening_width/2, clearance_width/2, 1.01]) rotate([0,0,30]) cylinder(h=NutThickness(nut_diameter), d=6+tolerance, $fn=6);
        translate([opening_width/2, clearance_width/2, -.01]) cylinder(h=NutThickness(nut_diameter)+1, d = 3.5, $fn=60);
    }
}



module threaded() {
    ScrewHole(nut_diameter, NutThickness(nut_diameter)+1.01, position=[opening_width/2, clearance_width/2, -.01]) 
        cube([opening_width, clearance_width, NutThickness(nut_diameter)+1]);
}

threaded();

translate([10, 0, 0]) insert();