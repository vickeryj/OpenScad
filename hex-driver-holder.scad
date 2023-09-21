include <BOSL2/std.scad>

width = 36.2;
depth = 25;
height = 22.5;

$fn=24;

difference() {
    cuboid([width, depth, height], rounding=2, anchor=BOTTOM+FRONT+LEFT);

    back(depth+.01) right(7) up(7) xrot(90) cylinder(h = depth + .02, d = 2.75);
    
    back(depth+.01) right(8.5+12.5) up(11.5) xrot(90) cylinder(h = depth + .02, d = 3.3);
    
    back(depth+.01) right(8.3+12.5+11) up(4.2) xrot(90) cylinder(h = depth + .02, d = 2.18);
 
}
