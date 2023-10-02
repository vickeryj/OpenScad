include <BOSL2/std.scad>
include <BOSL2/rounding.scad>
include <BOSL2/screws.scad>

$slop=0.11; //trident


width_across = 260; // this will be the inside width of the handle

handle_width = 110; // the width of the handle part
handle_diameter = 24; // handle cylinder diameter, but the handle gets scaled up for easier printing
handle_clip_flat = .6; // how much is clipped off the top and bottom of the handle for easier printing

strap_depth = 140; // from the bottom of the strap to the inside top of the strap
strap_thickness = 6; // thickness being how far the strap extends from the bolt
strap_width = 15; // width being how far across the handle the strap spreads, it needs to be less than handle_diameter 

strap_insert_depth = 40; // how far into the the handle the strap inserts

strap_piece_width = (width_across-handle_width)/2 + strap_thickness; //calculated

strap_screw_length = 18; // how far into the bucket the screw will go
through_thickness = 8; // how much should be left unthreaded to better sit in the holes in the bucket
strap_screw = "M18"; // this should be a screw wider than strap_width

corner_r = 12; // the radius for the strap corner

module strap_piece() {

    handle_path = turtle([
                "turn", 90,
                "move", strap_depth,
                "arcright", corner_r,
                "move", strap_piece_width + strap_insert_depth,
                "turn", -90,
                "move", strap_thickness,
                "turn", -90,
                "move", strap_piece_width + strap_insert_depth - strap_thickness,
                "arcleft", corner_r,
                "move", strap_depth - strap_thickness,
                "turn", -90]);//,

    side_r = 1;
    
    difference() {
        offset_sweep(handle_path, height=strap_width, bottom=os_circle(r=side_r), top=os_circle(r=side_r));
    }
    
    
    intersection() {
        right(strap_screw_length/2+strap_thickness-.01) up(strap_width/2) back(strap_width) yrot(-90) screw(strap_screw, length = strap_screw_length, thread_len=strap_screw_length - through_thickness);
        right(strap_thickness) cube([strap_screw_length, 2*strap_width, strap_width]);
    }
 }
 
 
 module strap_piece_with_holes() {
    difference() {
        strap_piece();
        for( i = [1, 3]) {
                back(strap_depth+corner_r) up(strap_width/2) right(strap_piece_width + strap_insert_depth/4*i) screw_hole("M3", length=strap_thickness+.01, orient=BACK, anchor=TOP);
        }
    }
 }
 
 module strap_nut() {
    nut(strap_screw, nutwidth=25, thickness=strap_screw_length - through_thickness+2, bevel2=false);
    cylinder(d=25, h=2);
}
 
 insert_height = 4;
 
  module m3_insert() {
    cylinder(d2=5.59, d1=5.16, h=insert_height-.8); //d2 and d1 are a bit too larg on the trident
    down(0.8) cylinder(d=4.3, h=.8);
 }
 
 module handle_full() {
    difference() {
        intersection() {
            right(strap_piece_width) yrot(90) scale([1,1.25,1]) cyl(h = handle_width, d = handle_diameter*.85, anchor=BOTTOM, rounding = 4);
            right(strap_piece_width) fwd(handle_diameter/2-handle_clip_flat) down(handle_diameter/2) cube([handle_width, handle_diameter-handle_clip_flat*2, handle_diameter]);
        }
        
        scale([1, 1.02, 1.02]) fwd(strap_depth + handle_diameter/2 - strap_thickness/2) down(strap_width/2)  strap_piece();
        #scale([1, 1.02, 1.02]) fwd(strap_depth + handle_diameter/2 - strap_thickness/2) up(strap_width/2) right(width_across+strap_thickness*2) yrot(180) strap_piece();
        xrot(90) {
            for( i = [1,3]) {
                for( j = [0, handle_width-strap_insert_depth]) {
                    right(j + strap_piece_width + strap_insert_depth/4*i) {
                        screw_hole("M3", length=handle_diameter-3, head="socket", orient=DOWN);
                        up(handle_diameter/2-insert_height+.8-handle_clip_flat) m3_insert();
                    }
                }
            }
        }
    }
 }
 
       
 
 module handle_bottom() {
    difference() {
        xrot(90) handle_full();
        fwd(handle_diameter) cube(width_across);
    }
 }

 
 module handle_top() {
    difference() {
        xrot(90) handle_full();
        fwd(handle_diameter)  down(width_across) cube(width_across);
    }
 }
 
$fn=32;
 
//handle_full();
strap_piece_with_holes();
//up(handle_diameter/2 - handle_clip_flat) back(strap_depth) handle_bottom();
//handle_bottom();
//back(50) up(handle_diameter/2) xrot(180) handle_top();
//back(strap_depth) up(strap_width/2) xrot(-90) handle_top();
//handle_top();
//fwd(30) strap_nut();


 
 //cube(width_across);
//back(strap_depth+strap_thickness-20) right(strap_thickness) cube(width_across);
 
 /* todo
 - 1. heatset holes in handle top
 - 2. screw holes in handle bottom
 - 3. round handle edges
 - 4. screws on sides of straps
 - 6. nuts for inside of cans
 - 7. make clearance in handle for straps
 - 8. screw holes in straps
 */
 
