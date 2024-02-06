use </Users/vickeryj/Code/OpenSCAD/threads.scad> //https://github.com/rcolyer/threads-scad
use </Users/vickeryj/Code/OpenSCAD/Chamfer.scad>  //https://github.com/SebiTimeWaster/Chamfers-for-OpenSCAD

$fn = 120;

magnet_height = 8.95;
shaft_height = 33;
screw_height = 7;
magnet_diameter = 20.1;
tamper_height = .5 + magnet_height + .5 + shaft_height + screw_height;

module tamper() {
    difference() {
        ScrewHole(14,screw_height, pitch = .75, position = [0,0,shaft_height-.01])
            chamferCylinder(h = tamper_height, r2 = 29/2, r = 31/2, ch = 0, ch2 = 2);
            
        translate([0,0,-.01]) cylinder(h = shaft_height, d = 20.2);
        
        translate([0,0,tamper_height-magnet_height - .5]) cylinder(h = magnet_height, d = magnet_diameter);    
        
        translate([0,0,-.01]) cylinder(h=16, d = 21.4);
    }
}

translate([0,0,tamper_height]) rotate([180, 0, 0]) tamper();
