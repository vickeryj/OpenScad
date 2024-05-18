include <BOSL2/std.scad>

$fn=64;

base_d = 100;
top_d = 150;
height = 28;
wall_w = 1.5;
oval_scale = 1.2;

difference() {

    xscale(oval_scale) cyl(d1=base_d, d2=top_d, h=height, anchor=BOTTOM, rounding=2);
    xscale(oval_scale) up(wall_w) cyl(d1=base_d-wall_w, d2=top_d-wall_w*8, h = height-wall_w+0.01, anchor=BOTTOM, rounding1=2, rounding2=-2);

}

screw_post_d = 6;
post_back = 9.5;
post_fwd = 22;
post_over = 40;
screw_hole_d = 2.5;
post_height = height-5;

up(wall_w) {
    for (coords = [
            [-base_d/2+post_back,-1.5],  
            [base_d/2-post_fwd-1.5, post_over-1.3],
            [base_d/2-post_fwd, -post_over+.5]]) 
    {
        back(coords[0]) right(coords[1]) {
            difference() {
                cyl(d=screw_post_d, h=post_height, anchor=BOTTOM, rounding1=-1);
                up(0.01) cyl(d=screw_hole_d, h=post_height, anchor=BOTTOM);
            }
        }
    }
}