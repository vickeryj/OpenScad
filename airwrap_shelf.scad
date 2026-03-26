include <BOSL2/std.scad>
include <BOSL2/rounding.scad>
include <BOSL2/screws.scad>

wand_r = 25;
//width = 220;
width = 170;
wall_width = 4;
shelf_space = 100;
shelf_depth = 80;
attach_d = 31.8;
attach_h = 10;

$fn=64;

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

setoff = 10;
wall_space = 40;

module solid_hook() {
    hook_path = turtle([
        "arcright", wand_r+wall_width, 180,
        "arcleft", wall_width/2, 90,
        "move", setoff,
        "arcright", wall_width/2, 90,
        "move", wall_space,
        "arcright", wall_width/2, 180,
        "move", wall_space-wall_width,
        "arcleft", wall_width/2, 90,
        "move", setoff,
        "arcright", wall_width/2, 90,
        "move", wall_width,
        "arcleft", wand_r, 180,
        "arcright", wall_width/2, 179

    ]);

    //stroke(hook_path);
    offset_sweep(hook_path, 
        height = width,
        bottom=os_circle(r=1.2),
        top=os_circle(r=1.2)
        );
}
difference() {
    solid_hook();
    spec = screw_info("#8,1/2",head="round");
    newspec = struct_set(spec,["head_size",11]);
    left(wall_space/2+wall_width*1.5) fwd(wand_r*2+wall_width+2.5+setoff) up(width/4) xrot(90) yrot(180) screw_hole(newspec, anchor=TOP);
    left(wall_space/2+wall_width*1.5) fwd(wand_r*2+wall_width+2.5+setoff) up(width/4*3) xrot(90) yrot(180) screw_hole(newspec, anchor=TOP);

}
right(3.5) fwd(wand_r*2+setoff+3.5) up(width/2) xrot(90) yrot(229) prismoid(size1=[setoff*2,width], size2=[0,width], h=setoff);


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

module wire_hook() {

    hook_width = 30;

    hook_path = turtle([
        "arcright", wand_r+wall_width, 180, //bottom hook bottom
        "move", shelf_space, //back wall
        "arcright", wall_width/2, 180, //flip around
        "move", shelf_space/2, //move to top hook
        "arcleft", wand_r, 180, //top hook top 
        "arcright", wall_width/2, 180, //flip around
        "arcright", wand_r+wall_width, 150, //top hook bottom
        "left", 150, "move",35,
        "arcleft", wand_r, 179, //bottom hook top
        "arcright", wall_width/2, 190, //flip around

    ]);
    
    //stroke(hook_path);
    
    module hook() {
        offset_sweep(hook_path, 
            height = hook_width,
            bottom=os_circle(r=1.2),
            top=os_circle(r=1.2)
            );
    }
    difference() {
        hook();
        for (i = [shelf_space/8, shelf_space/8*6]) {
            fwd(wand_r*2+wall_width-0.01) left(i) up(hook_width/2) xrot(270) #screw_hole("#6,1/2",head="flat", anchor=TOP);
        }
    }
}

//wire_hook();

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
//peg_shelf();


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