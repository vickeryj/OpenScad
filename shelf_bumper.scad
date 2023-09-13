include <BOSL2/std.scad>
include <BOSL2/rounding.scad>

$fn = 64;

module bumper() {
    shelf_thickness = 16.5;
    length = 40;
    depth = 20;
    wall_thickness = 6;

    box = square(40);
    rbox = round_corners(box, cut=4);

    difference() {
        offset_sweep(rbox, shelf_thickness+wall_thickness*2, top=["for","offset_sweep","r",4], bottom=["for","offset_sweep","r",4]);
        back(depth) left(depth) down(0.01) offset_sweep(box, shelf_thickness+wall_thickness*2+.02);
        up(wall_thickness) back(wall_thickness) left(wall_thickness) offset_sweep(box, shelf_thickness);
    }
 }
 
xrot(90) bumper();