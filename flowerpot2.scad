
module ring(r, h) {
    n = 10;
    step = 360/n;
    points = [ for (t=[0:step:359.999]) [r*cos(t), r*sin(t)]];
    linear_extrude(height=h)
        polygon(points);
        
}

module pot(base) {
    for (level = [0:1:100]) {
        h = 1;
        translate([0, 0, level*h]) rotate([0, 0, level]) ring(base+level*.3, h);
    }
}

difference() {
    wall_width = 2.5;
    base = 50;
    pot(base);
    translate([0, 0, wall_width]) pot(base-wall_width);
    cylinder(h= 100, d = 6);
}