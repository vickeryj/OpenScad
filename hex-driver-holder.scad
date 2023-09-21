include <BOSL2/std.scad>

width = 36.2;
depth = 25;
height = 25;

$fn=24;

difference() {
    cuboid([width, depth, height], rounding=2, anchor=BOTTOM+FRONT+LEFT);

    back(depth+.01) right(8.5) up(8.5) xrot(90) cylinder(h = depth + .02, d = 2.6);
    
    back(depth+.01) right(8.5+12.5) up(12.5) xrot(90) cylinder(h = depth + .02, d = 3.1);
    
    back(depth+.01) right(8.5+12.5+11) up(4) xrot(90) cylinder(h = depth + .02, d = 1.9);
 
}