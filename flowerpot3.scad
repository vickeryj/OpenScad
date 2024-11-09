include <BOSL2/std.scad>

$fn = 32;

height = 90;
base_d = 80;
top_d =105;
wall_thickness = 2.5;
hole_d = 6;

module pot() {
    difference() {
        cyl(d1=base_d, d2=top_d, h=height, rounding1=2,
            texture="trunc_ribs", tex_size=[10,1], tex_taper=40);
        up(wall_thickness) 
            cyl(d1=base_d - wall_thickness, 
                d2=top_d - wall_thickness, 
                h=height,
                rounding1=2);
        down(wall_thickness+.01) cyl(h=height + 0.08, d = hole_d);
    }
}

saucer_gap = 1;
saucer_height = 12;
saucer_slant = 10;
drain_gap = 5;
drain_height = 4;

module saucer() {
    up(saucer_height/2) difference() {
        cyl(d1=base_d+saucer_gap, d2=base_d+saucer_slant, h=saucer_height, rounding1=2,
            texture="trunc_ribs", tex_size=[10,1], tex_taper=40);
        up(wall_thickness) cyl(d1=base_d+saucer_gap-wall_thickness, d2=base_d+saucer_slant-wall_thickness, h=saucer_height, rounding1=2);
    }
    up(drain_height/2+wall_thickness-.01) difference() {
        cyl(d=base_d-10, h=drain_height, rounding2=1, rounding1=-1);
        cyl(d=base_d-15, h=drain_height + 0.01, rounding2=-1, rounding1=1);
        down(drain_height/2) fwd(base_d/2) cube([drain_gap, base_d, drain_height + 0.01]);
    }
}

//up((height/2) - (saucer_height/2) + drain_height + wall_thickness+5) pot();
up(height/2) pot();
left(top_d) saucer();
//saucer();