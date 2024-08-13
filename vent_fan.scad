include <BOSL2/std.scad>
include <BOSL2/joiners.scad>

$slop = .11;

blank_width = 120;
lock_notch = 86;
lock_height = 9;

depth = 70;
height = 180;

fan_width = 139;
fan_depth = 25;
fan_diam = 135;
fan_padding = 20;


screw_diam = 4.5;
screw_inset = 7;

fan_mount_thickness = 3.5;

dovetail_width = depth/5*2;
dovetail_depth = dovetail_width/2;
dovetail_taper = -.6;
dovetail_rounding = 1;

louver_thickness = 2;
louver_rod_d = 4;
louver_overlap = 10;


module left_blank() {
    diff() cuboid([blank_width, depth, height]) {
        tag("remove") attach(RIGHT) dovetail("female", slide=height, width=dovetail_width, height=dovetail_depth, taper=dovetail_taper, radius=dovetail_rounding);
        tag("remove") position(BOTTOM+LEFT) down(.01) left(.01) cuboid([lock_notch, depth+.02, lock_height], anchor=BOTTOM+LEFT);
    }
}

module fan() {

    diff() cuboid([fan_width+fan_padding*2, depth, height]) {
        //attach(LEFT) dovetail("male", slide=height, width=dovetail_width, height=dovetail_depth, taper=dovetail_taper, radius=dovetail_rounding);
        //tag("remove") attach(RIGHT) dovetail("female", slide=height, width=dovetail_width, height=dovetail_depth, taper=dovetail_taper, radius=dovetail_rounding);
        tag("remove") fwd(.01) cuboid([fan_width, depth+.03, fan_width]);
        
        
        tag("keep") difference() {
            position(FRONT) back(fan_depth) cuboid([fan_width, fan_mount_thickness, fan_width], anchor=FRONT);
            xcyl(d=fan_diam, h=depth, spin=90);
            for(i=[[1,1],[1,-1], [-1, 1], [-1, -1]]) {
                down(i[0]*fan_width/2-i[0]*screw_inset) left(i[1]*fan_width/2-i[1]*screw_inset)
                    xcyl(d=screw_diam, h=depth, spin=90);
            }
        }
        
    }

}

module louver() {
    cuboid([fan_width+louver_overlap*2, louver_thickness, fan_width/4]) {
        attach(TOP) xcyl(d=louver_rod_d, h = fan_width+fan_padding*2);
    }
}

//left (blank_width/2 + fan_width ) left_blank();
fan();
//back(depth/2) louver();

// louvers
// wiring holes
// wiring box
// right width for the window
// right blank
// finger guards
// round corners on fan cutout

