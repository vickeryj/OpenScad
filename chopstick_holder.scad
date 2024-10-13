include <BOSL2/std.scad>
include <BOSL2/rounding.scad>
include <BOSL2/hinges.scad>

//interior
//50x24x246
width = 246;
height = 50;
depth = 24;
wall_thickness = 3;
cut = 2;
finger_cut = 40;

$fn = 24;
steps = 24;
//steps =  6;
//$fn=6;

box = square([width+wall_thickness*2,depth+wall_thickness*2]);
rbox = round_corners(box, method="smooth", cut=cut, $fn=32);

module box() {
    ibox = square([width,depth]);
    ribox = round_corners(ibox, method="smooth", cut=cut, $fn=32);
    difference(){
        offset_sweep(rbox, 
                    height=height, 
                    steps=steps,
                    bottom=os_teardrop(r=2), top=os_circle(r=2));
        right(wall_thickness) back(wall_thickness) up(wall_thickness)
            offset_sweep(ribox,
                        height = height-wall_thickness+.01,
                        steps=steps,
                        top=os_circle(r=-2),
                        bottom=os_circle(r=4));
                        
                        
        outset = 1;
        rounding_extra = 4;
        cutout_start = wall_thickness+rounding_extra;
        cutout_height = height-cutout_start;
                        
        cutout = square([
                    finger_cut,
                    wall_thickness]);
                   

        right(width/2-finger_cut/2) up(cutout_start) fwd(.01) 
            offset_sweep(cutout, height = cutout_height, top=os_circle(r=-2));



        
        right(width/2) 
        up(cutout_start+cutout_height/2)
        back(wall_thickness/2)
        xrot(90)
            cuboid([finger_cut, cutout_height, wall_thickness+.02], rounding=-2,
            edges=[TOP+RIGHT, TOP+LEFT, BOTTOM+RIGHT, BOTTOM+LEFT, TOP+FRONT]);
            
    }
}

box();