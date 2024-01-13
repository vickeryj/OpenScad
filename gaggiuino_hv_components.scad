include <BOSL2/std.scad>
include <BOSL2/screws.scad>
include <BOSL2/rounding.scad>

$slop=0.11;

$fn = 24;

base_w = 103;
base_d = 84;
wall_thickness = 1.7;
post_d = 6;
post_h = 3;
corner_post_h = 29;
dimmer_centers = [21.5, 47];
relay_centers = [21, 28];
ps_centers = [24.5, 60];

component_padding_w = 7;
component_back = 10;

snubber_back = 6;
snubber_wall_height = 9;
snubber_w = 31.5;
snubber_d = 14;

power_wall_height = 6;
power_w = 14;
power_d = 20;
power_top_rail_center = 4;
power_bottom_lift = .7;

ss_slot_width = 5;
ss_slot_height = 3;
ss_slot_length = 6;
ss_back = 6;

module base() { 
    cuboid([base_w,base_d,wall_thickness]);
    up(wall_thickness/2) fwd(base_d/2) left(base_w/2) {
        up(post_h/2) right(component_padding_w) back(component_back) {
            posts(dimmer_centers);
            right(component_padding_w*1.5+dimmer_centers[0]) {
                posts(relay_centers);
                right(component_padding_w*1.5+relay_centers[0]) posts(ps_centers);
            }
        }
        up(snubber_wall_height/2) back(snubber_d/2+wall_thickness)
        right(dimmer_centers[0]+component_padding_w+relay_centers[0])
        back(relay_centers[1]+snubber_d+snubber_back)
        zrot(90)
            slide(snubber_wall_height, snubber_w, snubber_d);
            
        up(power_wall_height/2)
        right(component_padding_w+dimmer_centers[0]/2)
        back(base_d - power_d/2)
        zrot(90) 
            slide(power_wall_height, power_w, power_d, power_top_rail_center, power_bottom_lift);
            
        up(ss_slot_height/2) 
        right(component_padding_w+dimmer_centers[0]/2)
        back(dimmer_centers[1]+component_back+ss_back)
            stepdown_slot();
    }
    

}

module post(post_h = post_h) {
    difference() {
        cyl(d = post_d, h = post_h);
        up(post_h/2-2) screw_hole("M3,4", thread = true);
    }
}

module posts(centers) {
    for(i = [0, centers[0]]) {
        right(i) post();
        for(j = [0, centers[1]]) {
            right(i) back(j) post();
        }
    }
}


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

module stepdown_slot() {
    cuboid([ss_slot_length, wall_thickness, ss_slot_height]);
    back(ss_slot_width) cuboid([ss_slot_length, wall_thickness, ss_slot_height]);
}

module test_section() {
    intersection() {
        #base();
        left(55) fwd(8) cube([68, 78, 30]);
    }
}

module cover() {
    //cuboid([base_w,base_d,wall_thickness], rounding = .5);
    
    topbox = square([base_w,base_d,wall_thickness], center=true);
    rtopbox = round_corners(topbox, method="circle", r=post_d/2);
    offset_sweep(rtopbox, 
                height=wall_thickness, 
                steps=22,
                top=os_circle(r=1));
    
    down(corner_post_h/2) {
        for(i = [base_d/2 - wall_thickness/2, -base_d/2+wall_thickness/2]) {
            fwd(i) cuboid([base_w-post_d, wall_thickness, corner_post_h]);
        }
        for(i = [base_w/2-wall_thickness/2, -base_w/2+wall_thickness/2]) {
            left(i) cuboid([wall_thickness, base_d-post_d, corner_post_h]);
        }
    }
    
    for (i = [base_w/2 - post_d/2, -base_w/2 + post_d/2]) {
        for (j = [base_d/2-post_d/2, -base_d/2+post_d/2]) {
            down(corner_post_h/2) left(i) fwd(j) yrot(180) post(corner_post_h);
        }
    }
}

up(corner_post_h) cover();

//base();

//test_section();
