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

module air_holes() {
    hole_width = base_w/2;
    hole_height = 2;
    margin = 3*wall_thickness;
    for (y = [margin:hole_height*2:corner_post_h]) {
        up(y)
            cuboid([hole_width, wall_thickness+0.02, hole_height]);
    }
}

screen_w = 26;
screen_d = 15;
module screen_hole() {
    cuboid([screen_w, screen_d, wall_thickness+0.02]);
}


module top() {
    
    screen_hole_back = 30;
    screen_hole_l = 22;
    
    difference() {
        cover_solid(base_w, base_d, corner_post_h);
        down(corner_post_h) {
            fwd(base_d/2-wall_thickness/2) air_holes();
            back(base_d/2-wall_thickness/2) air_holes(); 
        }
        fwd(base_d/2-screen_hole_back) left(base_w/2-screen_hole_l) up(wall_thickness/2)
            screen_hole();
            
            
        plug_w = 12;
        plug_h = 6.5;
        right(base_w/2-wall_thickness/2) back(base_d/2) down(corner_post_h)
            fwd(25) up(8.5)
            #cuboid([wall_thickness+.02, plug_w, plug_h]);
    }
    screen_spacer_h = 1.5;
    screen_spacer_d = 3.5;
    screen_spacer_center = 24;
    spacer_offset = 4.5/2;
    
    down(screen_spacer_h/2-.01)
    fwd(base_d/2-screen_hole_back+spacer_offset) left(base_w/2-screen_hole_l) {
        for (x = [1, -1]) {
            for (y = [1,-1]) {
                left(x*(screen_spacer_center/2))
                fwd(y*(screen_spacer_center/2)) {
                    #cyl(d=screen_spacer_d, h=screen_spacer_h);
                    down(screen_spacer_h-.01) cyl(d=1.8, h = 2);
                }
            }
        }
    }
    
}

module test_clip() {
    xrot(180) intersection() {
        top();
        fwd(38) left(8) cuboid(35);
    }
}

//test_clip();


//base();

//right(base_w + 10) up(corner_post_h) 
xrot(180) top();

