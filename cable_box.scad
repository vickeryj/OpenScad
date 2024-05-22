include <BOSL2/std.scad>
include <BOSL2/rounding.scad>
include <BOSL2/hinges.scad>

//big roll
width = 212;
height = 65;
depth = 70;
wall_thickness = 2.5;
y_cutout = 23 * 2;
x_cutout = 28 * 2;
cut = 2;
tolerance = .3;
hinge_width = 20;

//even bigger roll
width = 225;
height = 83;
depth = 83;

//cable organizer
width = 235;
depth = 180;
height = 100;

$fn = 12;

box = square([width+wall_thickness*2,depth+wall_thickness*2]);
rbox = round_corners(box, method="smooth", cut=cut);

module bottom() {
    ibox = square([width,depth]);
    ribox = round_corners(ibox, method="smooth", cut=cut);
    difference(){
        offset_sweep(rbox, 
                    height=height, 
                    steps=22,
                    bottom=os_teardrop(r=2));
        right(wall_thickness) back(wall_thickness) up(wall_thickness)
            offset_sweep(ribox,
                        height = height,
                        steps=22,
                        bottom=os_circle(r=4));
    }
    hinge_padding = .2;
//        right(width/3*2+hinge_padding/2) up(height) hinge(hinge_width-hinge_padding);
//        right(width/3-hinge_width+hinge_padding/2) up(height) hinge(hinge_width-hinge_padding);
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
        back(depth+wall_thickness) top_mask();
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

module top_mask() {
    difference() {
        right(.01) back(wall_thickness/2) cube([width+wall_thickness*2-.02, wall_thickness/2, wall_thickness]);
        up(wall_thickness/2) back(wall_thickness/2) yrot(90)
            cylinder(h = width+wall_thickness*2, d = wall_thickness);

    }
}

module cable_box_with_cutouts(print = false) {
    cutout_width = 40;
    rounding = print ? -wall_thickness/3 : 0;

    difference() {
        bottom();
        for (i = [1, 3, 5] ) {
            right(cutout_width*i) back(depth/5) down(.01) {
                cyl(d = cutout_width, h = wall_thickness+.02, anchor=BOTTOM, rounding=rounding);
                cuboid([cutout_width, depth/5*3, wall_thickness+.02], anchor=BOTTOM+FRONT, rounding = rounding);
                back(depth/5*3) cyl(d = cutout_width, h = wall_thickness+.02, anchor=BOTTOM,  rounding = rounding);
            }
        }
    }
}

/* print */
//up(wall_thickness) xrot(180) top();
//back(10) bottom();
//$fn = 24;
//printing = true;
printing = false;
cable_box_with_cutouts(printing);


/* assembled
up(height) up(3) top();
bottom();
*/


/* test fit
xrot(180) 
intersection() {
    right(0) back(-2) down(10) cube(85);
    top();
}

down(height-5) back(10)
intersection() {
    right(0) back(-2) up(60) cube(80);
    bottom();
}
*/
