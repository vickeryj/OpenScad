include <BOSL2/std.scad>


base_d = 92;
top_d = 140;
height = 18;
wall_w = 1.5;
oval_scale = 1.5;

difference() {

    xscale(oval_scale) cyl(d1=base_d, d2=top_d, h=height, anchor=BOTTOM, rounding=2);
    xscale(oval_scale) up(wall_w) cyl(d1=base_d-wall_w, d2=top_d-wall_w*8, h = height-wall_w+0.01, anchor=BOTTOM, rounding1=2, rounding2=-2);

}

screw_post_d = 6;
post_back = 8;
post_fwd = 20;
post_over = 41;

up(wall_w) {
    for (coords = [
            [-base_d/2+post_back,0],  
            [base_d/2-post_fwd, post_over],
            [base_d/2-post_fwd, -post_over]]) 
    {
        back(coords[0]) right(coords[1]) cyl(d=screw_post_d, h=height/2, anchor=BOTTOM);
    }
}