include <gaggiuino_common.scad>

pm_width = 50;
pm_depth = 46;
pm_height = 23;

slot_thickness = wall_thickness;

mhz_width = 8.5;
mhz_height = 19.5;
mhz_depth = 40;
mhz_slot_height = 15;

pi_centers = [46.5, 11.5];

base_w = 60;
base_d = 133;

corner_post_h = 25;

module base() {

    difference() {
        bottom_plate(base_w, base_d, os_circle(r=1), os_circle(r=0));
        plate_screws(base_w, base_d);
    }
    
    up(wall_thickness - 0.01 + pm_height/4) 
        fwd(base_d/2) 
        back(mhz_depth + 5 + pm_depth/2) 
        left(-wall_thickness*2 - slot_thickness/2 + base_w/2)
        pm_slot();
        
    up(wall_thickness - 0.01 + mhz_slot_height/2)
        fwd(base_d/2) back(mhz_depth/2)
        right(15/2)
        mhz_slot();
        
    up(wall_thickness - 0.01 + post_h/2)
        fwd(base_d/4)
        left(10)
        post();
    
    up(wall_thickness - 0.01 + post_h/2)
        left(pi_centers[0]/2)
        fwd(base_d/2)
        back(pm_depth+mhz_depth+pi_centers[1]+5)
        posts(pi_centers, screw_hole = "M2");
    
}

module pm_slot() {
    cuboid([slot_thickness, pm_depth, pm_height/2]);
    right(pm_width + slot_thickness) cuboid([slot_thickness, pm_depth, pm_height/2]);
}

module mhz_slot() {
    slot_depth = 10;
    cuboid([slot_thickness, slot_depth, mhz_slot_height]);
    right(mhz_width + slot_thickness) cuboid([slot_thickness, slot_depth, mhz_slot_height]);
}


module top() {
    
    difference() {
        cover_solid(base_w, base_d, corner_post_h);
    }
}

base();

//right(base_w + 10) up(corner_post_h) top();