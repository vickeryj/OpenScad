include <BOSL2/std.scad>
include <BOSL2/rounding.scad>

$fn = 32;

inner_r = 15;
wall_width = 2;

clip_width = 15;
clip_depth = 25;

nub = 2;

bow_angle = 20;

shelf_space = 100;
shelf_depth = 80;
attach_d = 31.8;
attach_h = 10;

    shelf_path = turtle([
        "arcright", inner_r+wall_width, 180,
        "left", bow_angle,
        "move", clip_depth/2,
        "arcright", wall_width, bow_angle*2,
        "move", clip_depth/2,
        "arcright", wall_width, 90,
        "move", wall_width + nub,
        "arcright", wall_width, 180,
        "arcleft", wall_width, 90,
        "move", clip_width/2,
        "arcleft", wall_width, bow_angle*2,
        "move", clip_depth/2,
        "right", bow_angle,
        "arcleft", inner_r-wall_width, 180,
        
        "move", clip_depth,
        "arcright", wall_width, 180,
    ]);
    
        offset_sweep(shelf_path, 
        height = clip_width,
        bottom=os_circle(r=1.2),
        top=os_circle(r=1.2)
        );