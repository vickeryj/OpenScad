include <BOSL2/std.scad>
include <BOSL2/rounding.scad>
include <BOSL2/screws.scad>

wand_r = 25;
width = 220;
wall_width = 4;
shelf_space = 100;
shelf_depth = 80;
attach_d = 31.8;
attach_h = 10;

$fn=12;

module solid_shelf() {
    shelf_path = turtle([
        "arcright", wand_r+wall_width, 180,
        "move", shelf_space,
        "arcright", wall_width/2, 90,
        "move", shelf_depth,
        "arcright", wall_width/2, 180,
        "move", shelf_depth-wall_width,
        "arcleft", wall_width/2, 90,
        "move", shelf_space-wall_width,
        "arcleft", wand_r, 180,
        "arcright", wall_width/2, 179
    ]);

    offset_sweep(shelf_path, 
        height = width,
        bottom=os_circle(r=1.2),
        top=os_circle(r=1.2)
        );
}

module peg() {
    cyl(d = attach_d, h = attach_h);
}

module shelf_with_pegs_and_holes() {
    difference() {
        solid_shelf(); 
        left(shelf_space/2) fwd(wand_r*2+wall_width) up(width/4) xrot(90) yrot(180) screw_hole("#6,1/2",head="flat", anchor=TOP);
        left(shelf_space/2) fwd(wand_r*2+wall_width) up(width/4*3) xrot(90) yrot(180) screw_hole("#6,1/2",head="flat", anchor=TOP);
    }

    for(i = [1, 3, 5]) {
        left(shelf_space+wall_width/2+attach_h/2-.01) back(shelf_depth-wand_r*2-wall_width) fwd(shelf_depth/2) up(width/6*i) yrot(90) peg();
    }
}
//shelf_with_pegs_and_holes();


module test_hook() {
    shelf_path = turtle([
        "arcright", wand_r+wall_width, 180,
        "move", shelf_space,
        "arcright", wall_width/2, 90,
        "move", shelf_depth,
        "arcright", wall_width/2, 180,
        "move", shelf_depth-wall_width,
        "arcleft", wall_width/2, 90,
        "move", shelf_space-wall_width,
        "arcleft", wand_r, 180,
        "arcright", wall_width/2, 179
    ]);

    offset_sweep(shelf_path, 
        height = 10,
        bottom=os_circle(r=1.2),
        top=os_circle(r=1.2)
        );
}

module test_post() {
    base_w = 50;
    peg();
    down(attach_h/2+wall_width/2) cuboid([base_w,base_w,wall_width]);
}
//test_post();


module peg_shelf() {
    for(i = [0,1,2]) {
        right(attach_d*i) peg();
    }
}
peg_shelf();


//Not used anymore, original pegs were too small
//module peg_cover() {
//    difference() {
//        h_delta = 2;
//        d_delta = .8;
//        h_padding = -wall_width/2+.2;
//        d_padding = .1;
//        cyl(d = attach_d+d_delta, h = attach_h+h_delta);
//        down(h_delta-h_padding) cyl(d = attach_d + d_padding, h = attach_h);
//    }
//}
//
//xrot(180) peg_cover();