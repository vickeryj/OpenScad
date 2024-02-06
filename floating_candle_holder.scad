include <BOSL2/std.scad>
include <BOSL2/rounding.scad>

module ring(r, h) {
    n = 200;
    step = 360/n;
    points = [ for (t=[0:step:359.999]) [r*cos(t), r*sin(t)]];
    linear_extrude(height=h)
        polygon(points);
        
}

module pot(base) {
    for (level = [0:.2:20]) {
        h = 1;
        //translate([0, 0, level*h]) rotate([0, 0, level]) ring(base+level*.1, h);
        translate([0, 0, level*h]) ring(base+level*.3, h);
    }
}


wall_width = 1.5;
base = 45;
top = 80;
height = 25;
$fn=60;
difference() {
    //pot(base);
    //translate([0, 0, wall_width]) pot(base-wall_width);
}
difference() {
//    cylinder(h = height, d1 = base, d2 = top);
//    translate([0, 0, wall_width])
//        cylinder(h = height, d1 = base-wall_width, d2 = top-wall_width);
}

difference() {
    cyl(l=height, d1=base, d2=top, rounding1=1.5, rounding2=0);
    translate([0, 0, wall_width])
        cyl(l=height, d1=base-wall_width, d2=top-wall_width, rounding1=1.5);
}

t_diameter = wall_width*2;

translate([0,0,height/2+.3])    torus(od=top, id=top-wall_width*2.35);