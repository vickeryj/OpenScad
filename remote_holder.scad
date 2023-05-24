remote_width = 38;
remote_depth = 124;
remote_thickness = 6.3;

side_padding = 7;
top_padding = 5;
thickness_cutoff = 2;
holder_width = remote_width + 2*side_padding;
holder_depth = remote_depth + 2*top_padding;
wall_width = 3;
holder_thickness = wall_width;
wall_height = remote_thickness+wall_width-thickness_cutoff;

$fn = 24;

module remote() {
  cube([remote_width, remote_depth, remote_thickness]);
}

//translate([(holder_width - remote_width)/2,(holder_depth - remote_depth)/2, wall_width+.01]) color("red", .1)  remote();

module holder() {
    cube([holder_width, holder_depth, holder_thickness]);
    translate([0,0,holder_thickness]) {
        difference() {
            cube([holder_width, holder_depth, wall_height]);
            translate([wall_width, wall_width, .01])
                cube([holder_width - 2*wall_width, holder_depth - 2 * wall_width, wall_height+.01]);
        }
    }
}

//holder();


include <BOSL2/std.scad>
include <BOSL2/rounding.scad>
include <BOSL2/screws.scad>

smallbox = square([holder_width,holder_depth]);
roundbox = round_corners(smallbox, method="smooth", cut=2);
thickness=wall_width;
height=wall_height;
screw_spec="#6-20,1"; // this wasn't large enough


difference() {
    offset_sweep(roundbox, height=height, top=os_circle(r=1));
    up(thickness)
        offset_sweep(offset(roundbox, r = -thickness), 
                     bottom=os_circle(r=2.5), 
                     top=os_circle(r=-.5),
                     height=height-thickness+.01);
    translate([holder_width/2,holder_depth/4,thickness+.01]) screw_hole(screw_spec, head="flat",counterbore=1, anchor=TOP);
    translate([holder_width/2,holder_depth/4*3,thickness+.01]) screw_hole(screw_spec, head="flat",counterbore=1,anchor=TOP);
}



