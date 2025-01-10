include <BOSL2/std.scad>

module base() {
    import("/Users/vickeryj/Code/touch-id-base.stl");
}

$fn=32;

base();

start_up = 3.51;
slot_width = 12.2;

back(52.4) right(16.5) up(6.6) cuboid([3,27.5,3.1], rounding=3, edges = [BACK+RIGHT]);
back(44) right(16.5) up(3.6) cuboid([3,3,3.2]);


difference() {

    back(55) right(14.2) up(start_up) cuboid([3,20,3]);

    back(54.7) right(11.51) up(start_up) cuboid([10.2, slot_width, 3.01]);
    
    hole_space = 15.5;
    first_hole = 47;

    back(first_hole) right(15) up(start_up) xrot(90) yrot(90) cyl(d=.7, h=4);
    back(first_hole+hole_space) right(15) up(start_up) xrot(90) yrot(90) cyl(d=.7, h=4);
}