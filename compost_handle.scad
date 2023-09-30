include <BOSL2/std.scad>
include <BOSL2/rounding.scad>
include <BOSL2/screws.scad>


width_across = 256;
handle_width = 110;
strap_depth = 140;
strap_thickness = 3;
strap_width = 10;
handle_diameter = 20;
strap_insert_depth = 40;

strap_piece_width = (width_across-handle_width)/2;


module strap_piece() {

corner_r = 12;
    function handle_path() =
        turtle([
                "turn", 90,
                "move", strap_depth,
                //"turn", -90,
                "arcright", corner_r,
                "move", strap_piece_width + strap_insert_depth,
                "turn", -90,
                "move", strap_thickness,
                "turn", -90,
                "move", strap_piece_width + strap_insert_depth - strap_thickness,
                //"turn", 90,
                "arcleft", corner_r,
                "move", strap_depth - strap_thickness,
                "turn", -90]);//,
                //"move", strap_thickness]);

    //stroke(handle_path, width=1, closed=true);

    side_r = 1;
    offset_sweep(handle_path(), height=strap_width, bottom=os_circle(r=side_r), top=os_circle(r=side_r));
 }
 
 //handle_strip();
 
 insert_height = 4;
 
  module m3_insert() {
    cylinder(d2=5.59, d1=5.16, h=insert_height-.8);
    down(0.8) cylinder(d=4.3, h=.8);
 }
 
 module handle_full() {
    difference() {
        right(strap_piece_width) yrot(90) cyl(h = handle_width, d = handle_diameter, anchor=BOTTOM, rounding = 4);
        fwd(strap_depth + handle_diameter/2) down(strap_width/2) strap_piece();
        fwd(strap_depth + handle_diameter/2) up(strap_width/2) right(width_across) yrot(180) strap_piece();
        xrot(90) {
            for( i = [1,3]) {
                for( j = [0, handle_width-strap_insert_depth]) {
                    right(j + strap_piece_width + strap_insert_depth/4*i) {
                        screw_hole("M3", length=handle_diameter-3, head="socket", orient=DOWN);
                        up(handle_diameter/2-insert_height+.8) m3_insert();
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
        back(handle_diameter) cube(width_across);
    }
 }
 
 handle_full();
 strap_piece();
 //handle_bottom();
 //handle_top();
 
 //cube(width_across);
 
 /* todo
 - 1. heatset holes in handle top
 - 2. screw holes in handle bottom
 - 3. round handle edges
 4. screws on sides of straps
 6. nuts for inside of cans
 */
 
