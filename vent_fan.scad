include <BOSL2/std.scad>
include <BOSL2/joiners.scad>

$slop = .11;

blank_width = 120;
lock_notch = 86;
lock_height = 9;

depth = 70;
height = 100;

fan_width = 100;

dovetail_width = depth/5*3;
dovetail_depth = dovetail_width/2;
dovetail_taper = -.6;
dovetail_rounding = 1;


module left_blank() {
    diff() cuboid([blank_width, depth, height]) {
        tag("remove")attach(RIGHT) dovetail("female", slide=height, width=dovetail_width, height=dovetail_depth, taper=dovetail_taper, radius=dovetail_rounding);
        tag("remove") position(BOTTOM+LEFT) down(.01) left(.01) cuboid([lock_notch, depth+.02, lock_height], anchor=BOTTOM+LEFT);
    }
}

module fan() {

    diff() cuboid([fan_width, depth, height]) {
        attach(LEFT) dovetail("male", slide=height, width=dovetail_width, height=dovetail_depth, taper=dovetail_taper, radius=dovetail_rounding);
        tag("remove")attach(RIGHT) dovetail("female", slide=height, width=dovetail_width, height=dovetail_depth, taper=dovetail_taper, radius=dovetail_rounding);
    }

}

left (blank_width/2 + fan_width ) left_blank();
//fan();