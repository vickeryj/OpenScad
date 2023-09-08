include <BOSL2/std.scad>
include <BOSL2/rounding.scad>
include <BOSL2/hinges.scad>

//big roll
width = 212;
height = 65;
depth = 70;
wall_thickness = 4;
y_cutout = 23 * 2;
x_cutout = 28 * 2;
cut = 2;
tolerance = 0.1;
hinge_width = 20;

box = square([width+wall_thickness*2,depth+wall_thickness*2]);
rbox = round_corners(box, method="smooth", cut=cut);

module bottom() {
    difference(){
      offset_sweep(rbox, height=height, check_valid=false, steps=22,
                   bottom=os_teardrop(r=2));
      up(wall_thickness)
        offset_sweep(offset(rbox, r=-wall_thickness, closed=true,check_valid=false),
                     height=height-2+.01, steps=22, check_valid=false,
                     bottom=os_circle(r=4));
    }
    hinge_padding = .5;
    right(width/3*2+hinge_padding/2) up(height) hinge(hinge_width-hinge_padding);
    right(width/3-hinge_width+hinge_padding/2) up(height) hinge(hinge_width-hinge_padding);
}

module top() {
    cutout = square([
                    width+wall_thickness*2 - x_cutout,
                    depth+wall_thickness*2 - y_cutout]);
    rcutout = round_corners(cutout, method="smooth", cut=4);
    difference() {
        offset_sweep(rbox, height = wall_thickness, top=os_circle(r=2));
        right(x_cutout/2) back(y_cutout/2) down(.01)
            offset_sweep(rcutout, height = wall_thickness+.02, top=os_circle(r=-2), bottom=os_circle(r=-2));
        right(width/3*2) hinge(hinge_width, slop=.1);
        right(width/3-hinge_width) hinge(hinge_width, slop=.1);
    }
    
    lip = square([width-tolerance*2,depth-tolerance*2]);
    rlip = round_corners(lip, method="smooth", cut=cut);
    lip_cut = square([
                        width-tolerance*2-wall_thickness*2,
                        depth-tolerance*2-wall_thickness*2]);
    move([wall_thickness+tolerance, wall_thickness+tolerance, -wall_thickness])
        difference() {
            offset_sweep(rlip, height = wall_thickness);
            back(wall_thickness) right(wall_thickness) down(0.01)
                offset_sweep(lip_cut, height = wall_thickness+.02);
        }


}

module hinge(len, slop=get_slop()) {
    back(depth+.3)
    up(.04)
    down(wall_thickness)
        snap_lock(thick=wall_thickness, 
                  snapdiam=wall_thickness,
                  snaplen=len, 
                  orient=UP, 
                  anchor=LEFT,
                  $slop=slop);
}

/*
$fn = 6;
up(height) top();
up(height) back(depth) yrot(90) #cylinder(h = width, d = 4);
//up(depth+height+wall_thickness*2) back(depth+wall_thickness) xrot(-90) top();
//bottom();

*/

$fn=32;
xrot(180) 
intersection() {
    right(40) back(65) down(10) cube(45);
    top();
}

xrot(90) back(20)
intersection() {
    right(40) back(depth+wall_thickness+.01) up(50) cube(40);
    bottom();
}

