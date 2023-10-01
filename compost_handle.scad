include <BOSL2/std.scad>
include <BOSL2/rounding.scad>
include <BOSL2/screws.scad>

$slop=0.11; //trident


width_across = 260;

handle_width = 110;
handle_diameter = 24;
handle_clip_flat = .6;

strap_depth = 140;
strap_thickness = 6;
strap_width = 15;

strap_insert_depth = 40;

strap_piece_width = (width_across-handle_width)/2;

strap_screw_length = 12;
through_thickness = 4;
strap_screw = "M18";

corner_r = 12;

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
    nut(strap_screw, nutwidth=25, thickness=strap_screw_length - through_thickness+1, bevel2=false);
    cylinder(d=25, h=2);
}
 
 insert_height = 4;
 
  module m3_insert() {
    cylinder(d2=5.59, d1=5.16, h=insert_height-.8);
    down(0.8) cylinder(d=4.3, h=.8);
 }
 
 module handle_full() {
    difference() {
        intersection() {
            right(strap_piece_width) yrot(90) cyl(h = handle_width, d = handle_diameter, anchor=BOTTOM, rounding = 4);
            right(strap_piece_width) fwd(handle_diameter/2-handle_clip_flat) down(handle_diameter/2) cube([handle_width, handle_diameter-handle_clip_flat*2, handle_diameter]);
        }
        
        scale([1, 1.02, 1.02]) fwd(strap_depth + handle_diameter/2 - strap_thickness/2) down(strap_width/2)  strap_piece();
        scale([1, 1.02, 1.02]) fwd(strap_depth + handle_diameter/2 - strap_thickness/2) up(strap_width/2) right(width_across) yrot(180) strap_piece();
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
//down(strap_depth + handle_diameter/2) back(strap_width/2) xrot(90) strap_piece();
strap_piece_with_holes();
up(handle_diameter/2 - handle_clip_flat) handle_bottom();
//handle_bottom();
//back(50) up(handle_diameter/2) xrot(180) handle_top();
//handle_top();
//fwd(30) strap_nut();


 
 //cube(width_across);
 
 /* todo
 - 1. heatset holes in handle top
 - 2. screw holes in handle bottom
 - 3. round handle edges
 - 4. screws on sides of straps
 - 6. nuts for inside of cans
 - 7. make clearance in handle for straps
 - 8. screw holes in straps
 */
 
