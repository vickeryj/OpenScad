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


$fn=12;

module hook() {


    hook_path = turtle([
        "arcright", wand_r+wall_width, 180, //bottom hook bottom
        "move", shelf_space, //back wall
        "arcright", (wall_width-cover_width)/2, 180, //flip around
        "move", shelf_space/3*2, //move to bump-out
        "left", 90,  // turn to bump-out
        "move", cover_width,
        "right", 90, //turn to continue
        
        "move", (shelf_space-cover_width)/3, //continue
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
            
        dovetail_width = 4;
        dovetail_depth = 2;
        dovetail_taper = -.6;
        dovetail_rounding = .1;

        //for (i = [10, hook_width-10]) {
            left(shelf_space-6) fwd(hook_d+wall_width+cover_width) up(hook_width/2) xrot(-90)
            dovetail("male", slide=hook_width, width=dovetail_width, height=dovetail_depth, taper=dovetail_taper, radius=dovetail_rounding);
        //}
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
    cuboid([shelf_space/3*2, cover_width, hook_width], rounding=1.2) {
    }
}
cover();
hook();