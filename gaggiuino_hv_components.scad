include <BOSL2/std.scad>
include <BOSL2/screws.scad>

$slop=0.11;

base_w = 103;
base_d = 84;
wall_thickness = 2;
post_d = 6;
post_h = 4;
corner_post_h = 29;
dimmer_centers = [21.5, 47];
relay_centers = [21, 28];
ps_centers = [24.5, 60];

component_padding_w = 7;
component_back = 10;

snubber_back = 2;
snubber_wall_height = 9;
snubber_w = 31.5;
snubber_d = 14;

power_wall_height = 7;
power_w = 12;
power_d = 20.5;
power_top_rail_center = 4;

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
        up(snubber_wall_height/2) right(snubber_w/3+wall_thickness/2) back(snubber_d/2+wall_thickness) // bottom left
        right(dimmer_centers[0]+component_padding_w*1.5)
        back(relay_centers[1]+snubber_d+snubber_back)
            slide(snubber_wall_height, snubber_w, snubber_d);
            
        up(power_wall_height/2)
        right(component_padding_w+dimmer_centers[0]/2)
        back(base_d - power_d/2)
        zrot(90) 
            slide(power_wall_height, power_w, power_d, power_top_rail_center);
            
        up(ss_slot_height/2) 
        right(component_padding_w+dimmer_centers[0]/2)
        back(dimmer_centers[1]+component_back+ss_back)
            stepdown_slot();
    }
    

}

module post(post_h = post_h) {

    difference() {
        cyl(d = post_d, h = post_h);
        screw_hole("M3,4", thread = true);
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

module slide(wall_height, width, depth, top_rail_center=5) {
    rail_thickness = 1;
    
    //#cuboid([width/3*2, depth, wall_height]);
    
    down(wall_height/2-rail_thickness/2) right(wall_thickness/2) {
        for(i = [-depth/2+rail_thickness/2, depth/2-rail_thickness/2]) {
            back(i) {
                for(j = [0, top_rail_center]) {
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

//base();

test_section();
