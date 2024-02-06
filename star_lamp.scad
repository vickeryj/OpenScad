include <BOSL2/std.scad>

point_base = 40;
point_height = 80;
wall_width = 2;

$fn=32;

module point() {
    module point(base, height) {
        prismoid(
            [base,base], 
            [1,1], 
            h=height,
            rounding1=1,
            rounding2=.5
        );
    }
    
    difference() {
        point(point_base, point_height);
        down(.01) point(point_base-wall_width, point_height-wall_width);
    }
}

point();