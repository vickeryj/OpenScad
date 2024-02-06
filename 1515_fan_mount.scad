include <BOSL2/std.scad>
include <BOSL2/rounding.scad>
include <BOSL2/screws.scad>

fan_depth = 30;
bolts_across = 24.3;
depth=34;
thickness = 3.8;
height = 10.5;

offset_to_inset = 3.5;
inset_height = 3;
inset_thickness = 1;

fan_mount_width = 8;
fan_mount_thickness = 3.98;

fan_cutout_d = 29.5;

insert_height = 4;
insert_top_d = 5.1;

fan_bolt_inset = (fan_depth - bolts_across)/2;

$fn=64;

 module m3_insert() {
    up(0.8) cylinder(d2=insert_top_d, d1=insert_top_d-.4, h=insert_height-.8); //d2 and d1 taken down .09,.06
    cylinder(d=4.3, h=.81);
 }

module mount() {
    module solid_mount() {
        cube([thickness, depth, height]);

        left(inset_thickness-.01) up(offset_to_inset) 
            cuboid([inset_thickness, depth , inset_height], 
                   anchor=LEFT+FRONT,
                   chamfer=.4, edges=[TOP+FRONT,TOP+LEFT,BOTTOM+FRONT,BOTTOM+BACK, BOTTOM+LEFT, FRONT+LEFT, BACK+LEFT, BACK+TOP]);
                   
        up(height-fan_mount_thickness) right(thickness) 
            cuboid([fan_mount_width, depth, fan_mount_thickness], 
            anchor=BOTTOM+LEFT+FRONT,
            rounding=2, edges=[RIGHT+FRONT, RIGHT+BACK]);
    }

    difference() {
        solid_mount();
        for(b = [fan_bolt_inset+(depth-fan_depth)/2, depth-fan_bolt_inset-(depth-fan_depth)/2]) {
            #right(thickness+3) up(height-insert_height+.01) back(b)  m3_insert();
        }
        back((depth-fan_cutout_d)/2) right(fan_cutout_d/2+thickness+(fan_depth-fan_cutout_d)+.8) up(height-fan_mount_thickness-.01)
            cylinder(h = fan_mount_thickness+.02, d = fan_cutout_d, anchor = FRONT+BOTTOM);
        up(offset_to_inset) back(depth/2) right(.3)
            #screw_hole("M3", length=4+.02, head="socket", orient=RIGHT);
    }
}

yrot(180) mount();

//mount();