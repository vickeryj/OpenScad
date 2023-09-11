include <BOSL2/std.scad>
include <BOSL2/rounding.scad>

module clipped_pin() {
    rotate([90,0,0])
        difference() {
            rotate([0,0,90]) translate([-80,-100,0]) import("/Users/vickeryj/Code/OpenSCAD/cable_frame_anchor_x6.stl");
            translate([0,0,0]) cube([9.5,20,10]);
        }
}
clipped_pin();

thickness = 5.8;

module angled_base() {
    translate([9.5,-2.9,10])
        rotate([0,-90,0])
        prismoid(
            size1=[16,thickness], 
            size2=[0,thickness], 
            h=12,
            shift=[8,0]);
}
angled_base(); 


module clip() {

    clip_thickness = 1.5;
    clip_depth = 3.5;

    clip_path = turtle([
        "angle",45, "turn", "move",2, 
        "angle",-90, "turn", "move",4,
        "angle",45, "turn", "move",clip_depth,
        "angle",90, "turn", "move",19,
            "turn", "move",clip_depth,
        "angle",45, "turn", "move",4,
        "angle",-90, "turn", "move",2,
            "turn", "move",1,
            "turn", "move",1,
        
       "angle",90, "turn", "move",3.5,
        "angle",-45, "turn", "move",clip_depth+1.5,
        "angle",-90, "turn", "move",21,
            "turn", "move",clip_depth+1.5,
        "angle",-45, "turn", "move",3.5,
        "angle",90, "turn", "move",1,
        "angle",-90, "turn", "move",1
        ]);
    offset_sweep(smooth_path(clip_path), height=thickness,
        bottom=os_circle(r=.5), top=os_circle(r=.5));
}

rotate([90,-37,0]) translate([.4,-2,0]) clip();