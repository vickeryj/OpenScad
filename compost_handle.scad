include <BOSL2/std.scad>
include <BOSL2/rounding.scad>

width_across = 256;
handle_width = 110;
strap_depth = 140;
strap_thickness = 3;
strap_width = 10;

handle_piece_width = (width_across-handle_width)/2;


module handle_piece() {
    top = square([handle_piece_width, strap_thickness]);
    rtop = round_corners(top, method="smooth", cut=.5, k=0.7, $fn=36);
    end_spec = os_smooth(cut=0.5, k=0.7, steps=22);
    
    join_prism(rtop, base="plane",
           length=strap_width, fillet=3, n=12);
    //offset_sweep(rtop, height=strap_width, bottom=end_spec, top=end_spec);
    
    side = square([strap_thickness, strap_depth]);
    rside = round_corners(side, method="smooth", cut=.5, k=0.7, $fn=36);
    offset_sweep(rside, height=strap_width, bottom=end_spec, top=end_spec);
}

//handle_piece();

module handle_piece_2() {
    overt = [[0,strap_depth],[0,0]];
    ohoriz = [[0,0],[handle_piece_width,0]];
    outside = path_join([overt, ohoriz],joint=6,$fn=16);
    ihoriz = [[handle_piece_width, strap_thickness], [0, strap_thickness]];
    ivert = [[strap_thickness, strap_thickness], [strap_thickness, strap_depth]];
    offset_sweep(path_join([outside, [[handle_piece_width, 0], [handle_piece_width, strap_thickness]], ihoriz], joint=2, $fn=16), height=10);
    
}

//handle_piece_2();

 /*

cube([handle_piece_width, strap_thickness, strap_width]);

left(strap_thickness) cube([strap_thickness, strap_depth, strap_width]);

//right(handle_piece_width+handle_width) cube([handle_piece_width, strap_thickness, strap_width]);

*/

corner_r = 12;
handle_path = turtle([
        "turn", 90,
        "move", strap_depth,
        //"turn", -90,
        "arcright", corner_r,
        "move", handle_piece_width,
        "turn", -90,
        "move", strap_thickness,
        "turn", -90,
        "move", handle_piece_width - strap_thickness,
        //"turn", 90,
        "arcleft", corner_r,
        "move", strap_depth - strap_thickness,
        "turn", -90]);//,
        //"move", strap_thickness]);

//stroke(handle_path, width=1, closed=true);

side_r = 1;
offset_sweep(handle_path, height=strap_width, bottom=os_circle(r=side_r), top=os_circle(r=side_r));