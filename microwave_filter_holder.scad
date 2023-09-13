include <BOSL2/std.scad>
include <BOSL2/walls.scad>
include <BOSL2/sliders.scad>

width = 80;
height = 40;
thickness = 20;
wall_thickness = 2;

module holder() {
    up(wall_thickness) sparse_wall(h=width, l=height, thick=wall_thickness, strut=2, orient=RIGHT, anchor=[-1,-1,-1]);

    sparse_wall(h=thickness, l=height, thick=wall_thickness, strut=2, orient=UP, anchor=[-1,-1,-1]);
    
    back(wall_thickness) sparse_wall(h=thickness, l=width, thick=wall_thickness, strut=2, orient=UP, spin=-90, anchor=[-1,-1,-1]);
    
    right(width - wall_thickness) sparse_wall(h=thickness, l=height, thick=wall_thickness, strut=2, orient=UP, anchor=[-1,-1,-1]);

    up(thickness) sparse_wall(h=width, l=height, thick=wall_thickness, strut=2, orient=RIGHT, anchor=BOTTOM+FRONT);
}

//xrot(90) holder();

holder();