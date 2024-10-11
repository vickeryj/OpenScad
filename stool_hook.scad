include <BOSL2/std.scad>
include <BOSL2/rounding.scad>
include <BOSL2/screws.scad>
include <BOSL2/joiners.scad>


hook_d = 36;
wand_r = hook_d/2;
wall_width = 7;
cover_width = 3;
hook_width = 70;
shelf_space = 60;
attach_d = 31.8;
attach_h = 10;
rounding = 1.2;

dovetail_width = 4;
dovetail_depth = 1.5;
dovetail_taper = -.6;
dovetail_rounding = .1;

dovetail_back = 6;

$slop = 0.11;

$fn=64;

module hook() {


    hook_path = turtle([
        "arcright", wand_r+wall_width, 180, //bottom hook bottom
        "move", shelf_space/3, //back wall
        "right", 90, //flip around
        "move", wall_width,
        "right", 90,
        "move", shelf_space/3,         
        "arcleft", wand_r, 180, //bottom hook top
        "arcright", wall_width/2, 175, //flip around

    ]);
    
    
    //stroke(hook_path);
    
    module hook() {
        offset_sweep(hook_path, 
            height = hook_width,
            bottom=os_circle(r=rounding),
            top=os_circle(r=rounding)
            );
            
       back_wall_w = wall_width - cover_width;
    

       fwd(hook_d+wall_width*2-back_wall_w/2) up(hook_width/2) left(shelf_space/3*2) 
           cuboid([shelf_space/3*2,back_wall_w,hook_width], rounding=rounding,
           edges=[TOP+LEFT, TOP+FRONT, BOTTOM+LEFT, BOTTOM+FRONT]);
            
       fwd(hook_d+wall_width/2+wall_width) up(hook_width/2) left(shelf_space/3-rounding)
           cuboid([rounding*2, wall_width, hook_width], rounding=rounding,
           edges=[TOP+BACK, TOP+FRONT, BOTTOM+BACK, BOTTOM+FRONT]);

       left(shelf_space-dovetail_back) fwd(hook_d+wall_width+cover_width) up(hook_width/2) xrot(-90)
        dovetail("male", slide=hook_width, width=dovetail_width, height=dovetail_depth, taper=dovetail_taper, radius=dovetail_rounding);
    }
        
        
        
    difference() {
        hook();
        for (i = [hook_width/4, hook_width/4*3]) {
            fwd(wand_r*2+wall_width+cover_width-0.01) up(i) left(shelf_space/4*2) xrot(270) #screw_hole("#6,1/2",head="flat", anchor=TOP);
        }
        fwd(wand_r*2+wall_width+cover_width-0.01) up(hook_width/2) left(shelf_space/4*3) xrot(270) #screw_hole("#6,1/2",head="flat", anchor=TOP);
    }
    

    
}

module cover() {
    diff() cuboid([shelf_space/3*2-$slop*2, cover_width, hook_width], rounding=rounding,
    edges=[TOP+BACK, TOP+LEFT, LEFT+BACK, BOTTOM+BACK, BOTTOM+LEFT] ) {
        #tag("remove") attach(FRONT) left(shelf_space/3-dovetail_back) dovetail("female", slide=hook_width, width=dovetail_width, height=dovetail_depth, taper=dovetail_taper, radius=dovetail_rounding, spin=180);
    }
}

fwd(hook_d+wall_width+cover_width/2) up(hook_width/2) left(shelf_space/3*2) back(10) cover();
hook();