include <BOSL2/std.scad>
include <BOSL2/joiners.scad>

$slop = .11;

blank_width = 120;
lock_notch = 86;
lock_height = 9;

depth = 70;
height = 180;

fan_width = 140;
fan_depth = 26;
fan_diam = 135;
fan_padding = 20;
fan_mount_d = 20;

screw_diam = 4.5;
screw_inset = 7;

fan_mount_thickness = 4;

dovetail_width = depth/5*2;
dovetail_depth = dovetail_width/2;
dovetail_taper = -.6;
dovetail_rounding = .1;

louver_thickness = 1;
louver_rod_d = 4;
louver_overlap = 10;
louver_socket_h = 5;
louver_socket_slop = .6;
louver_flap_slop = 1;
louver_socket_wall = 2;
louver_socket_cap_w = 1;

wire_cut_d = 15;


module left_blank() {
    diff() cuboid([blank_width, depth, height]) {
        tag("remove") attach(RIGHT) ycopies(height/2,2) dovetail("female", slide=depth, width=dovetail_width, height=dovetail_depth, taper=dovetail_taper, radius=dovetail_rounding, spin=270);
        tag("remove") position(BOTTOM+LEFT) down(.01) left(.01) cuboid([lock_notch, depth+.02, lock_height], anchor=BOTTOM+LEFT);
    }
}

module fan() {

    diff() cuboid([fan_width+fan_padding*2, depth, height]) {
        attach(LEFT) ycopies(height/2,2) dovetail("male", slide=depth, width=dovetail_width, height=dovetail_depth, taper=dovetail_taper, radius=dovetail_rounding, spin=270);
        tag("remove") attach(RIGHT) ycopies(height/2,2) dovetail("female", slide=depth, width=dovetail_width, height=dovetail_depth, taper=dovetail_taper, radius=dovetail_rounding, spin=270);
        tag("remove") fwd(.01) cuboid([fan_width, depth+.03, fan_width]);
        
            
        tag("keep") {
            for(i=[[1,1],[1,-1], [-1, 1], [-1, -1]]) {
                down(i[0]*fan_width/2-i[0]*screw_inset) left(i[1]*fan_width/2-i[1]*screw_inset) fwd(depth/2 - fan_mount_thickness/2-fan_depth) {
                    difference() {
                        xcyl(d=fan_mount_d, h=fan_mount_thickness, spin=90);
                        xcyl(d=screw_diam, h=fan_mount_thickness+.02, spin=90);
                    }
                }
            }
        }
        
        tag("remove") {
            wire_cut_h = (height-fan_width)*2;
            down(height/2-wire_cut_h/2+wire_cut_d) fwd(depth/2-fan_depth/2-fan_mount_thickness) {
                right(fan_width/2) yrot(125) cyl(h=wire_cut_h, d=wire_cut_d);
                left(fan_width/2) yrot(-125) cyl(h=wire_cut_h, d=wire_cut_d);
            }
        }
    }

}

louver_height = fan_width/4+1;

module louver() {
    $fn=64;
    cuboid([fan_width+louver_overlap*2, louver_thickness, louver_height-louver_rod_d/2]) {
        back(louver_rod_d/2-louver_thickness/2) attach(TOP) xcyl(d=louver_rod_d, h = fan_width+fan_padding*2-louver_socket_cap_w*4);
    }
}

louver_grill_thickness = 3;

module louver_bracket() {
    $fn=64;
    diff() cuboid([fan_width+fan_padding*2, louver_grill_thickness, height]) {
    
         tag("remove") fwd(.01) cuboid([fan_width, depth+.03, fan_width]);
         
         for(i = [0,1,2,3]) {
            for (j = [-1,1]) {
                up(fan_width/2-(louver_height+louver_flap_slop)*i) {
                    tag("keep") left(j*(fan_width/2+fan_padding-louver_socket_h/2)) back(louver_rod_d/2) attach(BACK) {
                        tube(h=louver_socket_h, id=louver_rod_d + louver_socket_slop, wall = louver_socket_wall, orient=LEFT);
                        right(((louver_socket_h/2)-(louver_socket_cap_w/2))*j) cyl(h=louver_socket_cap_w, d=louver_rod_d + louver_socket_slop+louver_socket_wall*2, orient=LEFT);
                    }
                    //xrot(0) tag("keep") down(louver_height/2) back(3/2+louver_thickness/2) louver();
                }
            }
            tag("keep") up(fan_width/2) down(i*(louver_height+louver_flap_slop)) cuboid([fan_width, louver_grill_thickness, louver_socket_h+louver_socket_wall*2]);
        }
    }
    
}

//left (200) louver();

//left (blank_width/2 + fan_width ) left_blank();
//fan();
//back(depth/2+louver_grill_thickness/2-.01) louver_bracket();

module pieces() {
    left (blank_width/2 + fan_width ) left_blank();
    fan();
    back(depth/2+louver_grill_thickness/2-.01) louver_bracket();
}

//pieces();

module dovetail_test() {

    intersection() {
        pieces();
        #left(120) back(35) cuboid([100,15,140]);
    }
}

dovetail_test();


//back(3/2+louver_thickness/2) louver();
//back(depth/2+louver_thickness/2) louver();

//back(depth/2) down(louver_height+.2) louver();


// - louvers
// - louvers on fan box
// - rotate dovetails for printing
// rotate dovetails so they fit together with the grill in place
// make fan cutout larger so it isn't such a tight fit
// - move fan mount to posts for faster printing
// wiring holes
// wiring box
// right width for the window
// right blank
// finger guards
// round corners on fan cutout

