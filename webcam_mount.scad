include <BOSL2/std.scad>
include <BOSL2/rounding.scad>
include <BOSL2/walls.scad>
include <BOSL2/screws.scad>


camera_width=37;
camera_height=35;
plate_thickness=2;

module camera_backplate() {
    sparse_wall(h=camera_width, l=camera_height, thick=plate_thickness, strut=2, orient=LEFT);
    down(plate_thickness/2) small_seat();
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

mount_thickness = 5.8;
module extrusion_mount() {
    module mount() {
        rotate([90,0,0])
            difference() {
                rotate([0,0,90]) translate([-80,-100,0]) import("/Users/vickeryj/Code/OpenSCAD/cable_frame_anchor_x6.stl");
                translate([0,0,0]) cube([9.5,20,10]);
            }
            
 
        
        translate([9.5,-2.9,10]) {
            rotate([0,-90,0]) {
                prismoid(
                    size1=[16,mount_thickness], 
                    size2=[0,mount_thickness], 
                    h=12,
                    shift=[8,0]);
                up(9.9) left(3) yrot(-38) screw("M7", length=10);
            }
        }
    }
    intersection() {
        mount();
        fwd(mount_thickness) left(10) cube([50, mount_thickness, 50]);
    }
}

ball_diameter = 13;
shaft_height = 2;

module small_ball() {
    module outer() {
        cylinder(h = shaft_height + ball_diameter/2, d = ball_diameter*.7);
        up(shaft_height+ball_diameter/2) sphere(d = ball_diameter);
    }
    difference() {
        outer();
        down(0.01) screw_hole("M7", length=shaft_height+2, thread=true, anchor=BOTTOM);
    }

}

wall_width = 2;
nut_pitch = 2;
module small_seat() {

    difference() {
        threaded_rod(d = ball_diameter + 2*wall_width, l = ball_diameter*.7, pitch = 2, anchor=BOTTOM, bevel1="reverse");
        up(wall_width*2) cylinder(h = ball_diameter, d = ball_diameter-wall_width);
        up(ball_diameter/2 + wall_width) sphere(d=ball_diameter);
        up(ball_diameter/3) fwd(ball_diameter/2+wall_width*2) cube([wall_width, ball_diameter+wall_width*4, ball_diameter]);
        zrot(90) up(ball_diameter/3) fwd(ball_diameter/2+wall_width*2) cube([wall_width, ball_diameter+wall_width*4, ball_diameter]);
    }
}

gap = 1;
module small_ball_nut() {
    threaded_nut(nutwidth=20, id=ball_diameter, h=ball_diameter*.7-gap, pitch=2, anchor=BOTTOM);
    
    difference() {
        up(ball_diameter*.7-wall_width-gap) cylinder(d = ball_diameter+2*wall_width, h=wall_width);
        up(ball_diameter*.7-wall_width*2-gap) sphere(d = ball_diameter);
    }
}

//camera_clip();
//$fn=32;
/* assembled
up(plate_thickness/2) small_ball_nut();
xrot(180) down(ball_diameter+shaft_height+wall_width-plate_thickness) small_ball();
camera_backplate();*/

//print plate
up(ball_diameter*.7-gap) xrot(180) small_ball_nut();
right(20) up(shaft_height + ball_diameter) down(ball_diameter+shaft_height+wall_width-plate_thickness) small_ball();
//up(mount_thickness) fwd(15) xrot(90) extrusion_mount();
fwd(30) right(40) camera_backplate();
