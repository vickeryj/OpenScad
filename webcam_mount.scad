include <BOSL2/std.scad>
include <BOSL2/rounding.scad>
include <BOSL2/walls.scad>
include <BOSL2/screws.scad>

use </Users/vickeryj/Code/OpenSCAD/balljoint.scad>;

camera_width=37;
camera_height=35;
plate_thickness=2;

module camera_backplate() {
    sparse_wall(h=camera_width, l=camera_height, thick=plate_thickness, strut=2, orient=LEFT);
    up(plate_thickness/2-.01) balljoint_seat();
}



module extrusion_mount() {
    thickness = 5.8;  
    module mount() {
        rotate([90,0,0])
            difference() {
                rotate([0,0,90]) translate([-80,-100,0]) import("/Users/vickeryj/Downloads/cable_frame_anchor_x6.stl");
                translate([0,0,0]) cube([9.5,20,10]);
            }
            
 
        
        translate([9.5,-2.9,10]) {
            rotate([0,-90,0]) {
                prismoid(
                    size1=[16,thickness], 
                    size2=[0,thickness], 
                    h=12,
                    shift=[8,0]);
                up(9.9) left(3) yrot(-38) screw("M7", length=10);
            }
        }
    }
    intersection() {
        mount();
        fwd(thickness) left(10) cube([50, thickness, 50]);
    }
}

module ball() {
    difference() {
        balljoint_ball();
        screw_hole("M7", length=10, thread=true, anchor=BOTTOM);
    }
}


module camera_clip() {
    clip_thickness = 2;
    clip_width = 4;
    camera_thickness = 2.5;
    padding = 0;
    top_lip = 4;
    back_hook_gap = 2.5;
    
    fwd(clip_thickness) right(clip_thickness+back_hook_gap) cube([clip_thickness, clip_thickness+ plate_thickness, clip_width]);
    
    fwd(clip_thickness) cube([clip_thickness+back_hook_gap,  clip_thickness, clip_width]);
    
    cube([clip_thickness, plate_thickness+camera_thickness+padding, clip_width]);
    
    back(plate_thickness+camera_thickness+padding) cube([top_lip + clip_thickness, clip_thickness, clip_width]);
    

}

$fn=32;
//camera_clip();
//left(20) camera_backplate();
//fwd(20) right(20) 
extrusion_mount();
right(30) ball();
fwd(30) balljoint_nut();