

include <gaggiuino_common.scad>

base_w = 103;
base_d = 86;

component_back = 11.5;

corner_post_h = 20;
dimmer_centers = [21.5, 47];
relay_centers = [21, 28];
ps_centers = [24.5, 60];

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
ss_slot_height = 4;
ss_slot_length = 6;
ss_back = 3.5;

module base() {

    difference() {
        bottom_plate(base_w, base_d, os_circle(r=1), os_circle(r=0));
        plate_screws(base_w, base_d);
    }
                
                
    up(wall_thickness-.01) {
        fwd(base_d/2) left(base_w/2) {
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
            right(component_padding_w+dimmer_centers[0]/2+2)
            back(base_d - power_d/2-2.5)
            zrot(90) 
                slide(power_wall_height, power_w, power_d, power_top_rail_center, power_bottom_lift);
                
            up(ss_slot_height/2) 
            right(component_padding_w+dimmer_centers[0]/2)
            back(dimmer_centers[1]+component_back+ss_back)
                stepdown_slot();
            
        }
        for (i = [0, 1, 2]) {
            back(base_d/2-wall_thickness/2) right(base_w/3-base_w/3*i) zrot(90) strain_relief();
        }
        back(-base_d/2+wall_thickness/2) right(base_w/3-base_w/3*2) zrot(90) strain_relief();
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

heatsink_w = 25;
heatsink_d = 16;
heatsink_back_from_center = 15.5;
heatink_left_from_center = 1;

wire_d = 5;

module cover_with_cutouts() {
    difference() {
        cover_solid(base_w, base_d, corner_post_h);
        
        up(wall_thickness/2)
        left(base_w/2) fwd(base_d/2) right(heatsink_w/2) back(heatsink_d/2) // start at bottom left
        right(component_padding_w) back(component_back) //ofset from corner the same as dimmer post  
        back(heatsink_back_from_center) left(heatink_left_from_center) //offset from bottom left post of dimmer
        cuboid([heatsink_w, heatsink_d, wall_thickness+.02]);
        
        for (i = [0, 1, 2]) {
            for (j = [base_d/2-wall_thickness/2, -base_d/2+wall_thickness/2]) {
                back(j) down(corner_post_h+.01) right(base_w/3-base_w/3*i) zrot(90) strain_relief_cutout();
            }
        }
    }
}

up(corner_post_h) up(wall_thickness) 
xrot(180) right(base_w+20)
cover_with_cutouts();

base();

//test_section();
