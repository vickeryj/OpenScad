include <BOSL2/std.scad>
include <BOSL2/screws.scad>
include <BOSL2/rounding.scad>

//common
$slop=0.11;
$fn = 24;
wall_thickness = 1.7;
post_d = 6;
post_h = 3;
component_padding_w = 7;
power_wall_height = 6;

power_d = 20;
power_top_rail_center = 4;
power_bottom_lift = .7;


module slide(wall_height, width, depth, top_rail_center=5, bottom_rail_lift=0) {

    rail_thickness = 1;
    
    //#cuboid([width/3*2, depth, wall_height]);
    
    down(wall_height/2-rail_thickness/2) right(wall_thickness/2) {
        for(i = [-depth/2+rail_thickness/2, depth/2-rail_thickness/2]) {
            back(i) {
                for(j = [bottom_rail_lift, top_rail_center]) {
                    up(j) {
                        cuboid([width/3*2, rail_thickness, rail_thickness]);
                    }
                }
            }
        }
        
        back(depth/2-rail_thickness/2) up(top_rail_center-rail_thickness/2) back(rail_thickness/2) xrot(90) zrot(90) prismoid(size1=[rail_thickness*1.5, width/3*2], size2=[0,width/3*2], h=rail_thickness);
        
        fwd(depth/2+rail_thickness/2) up(top_rail_center-rail_thickness/2) back(rail_thickness/2) xrot(270) zrot(90) prismoid(size1=[rail_thickness*1.5, width/3*2], size2=[0,width/3*2], h=rail_thickness);
        
        
        
        for(i = [-depth/2-wall_thickness/2, depth/2+wall_thickness/2]) {
            up(wall_height/2-rail_thickness/2) back(i) 
                cuboid([width/3*2, wall_thickness, wall_height]);
        }
        up(wall_height/2-rail_thickness/2)
        left(width/3+wall_thickness/2)
        fwd(0)
            cuboid([wall_thickness, depth+wall_thickness*2, wall_height]);
    }
}


module post(post_h = post_h, screw_hole = "M3", screw_length = 4, slop = $slop) {
    difference() {
        cyl(d = post_d, h = post_h);
        up((post_h - screw_length)/2) screw_hole(screw_hole, length=screw_length, thread = true, $slop=slop);
    }
}

module plate(w,d,bottom = os_circle(r=0), top = os_circle(r=0)) {
    topbox = square([w,d], center=true);
    rtopbox = round_corners(topbox, method="circle", r=post_d/2);
    offset_sweep(rtopbox, 
                height=wall_thickness, 
                steps=22,
                bottom=bottom, 
                top=top);
}

module plate_screws(w,d) {
    for (i = [w/2 - post_d/2, -w/2 + post_d/2]) {
        for (j = [d/2-post_d/2, -d/2+post_d/2]) {
            left(i) fwd(j) yrot(180) screw_hole("M3,4", thread = false);
        }
    }
}

module cover_solid(w, d, corner_post_h) {
    plate(w, d, os_circle(r=0), os_circle(r=1));
    
    module walls() {
        down(corner_post_h/2) {
            for(i = [d/2 - wall_thickness/2, -d/2+wall_thickness/2]) {
                fwd(i) cuboid([w-post_d, wall_thickness, corner_post_h]);
            }
            for(i = [w/2-wall_thickness/2, -w/2+wall_thickness/2]) {
                left(i) cuboid([wall_thickness, d-post_d, corner_post_h]);
            }
        }
    }
    
    module corners(screw) {
        for (i = [w/2 - post_d/2, -w/2 + post_d/2]) {
            for (j = [d/2-post_d/2, -d/2+post_d/2]) {
                down(corner_post_h/2) left(i) fwd(j) yrot(180) {
                    if (screw) {
                         post(corner_post_h+.02);
                    }
                    else {
                        cyl(d = post_d, h = corner_post_h+.02);
                    }
                }
            }
        }
    }

    
    difference() {
        walls();
        corners(false);
    }
    corners(true);
}
