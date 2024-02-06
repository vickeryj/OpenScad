h = 90;
d = 210;
wall_thickness = 3;
reinforcement = 5;
$fn = 120;

difference() {
    cylinder(h = h, d = d + wall_thickness*2);
    translate([0,0,wall_thickness+.01]) cylinder(h = (h-wall_thickness), d = d);
//    translate([0,0,wall_thickness]) cylinder(h = (h-wall_thickness)/5*2, d = d);
//    translate([0,0,(h-wall_thickness)/5*3]) cylinder(h = h/5*3+wall_thickness, d = d);
    translate([0, -d/2-5, -.01]) cube([d+10, d+10, h+.02]);
}