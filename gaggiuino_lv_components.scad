include <gaggiuino_common.scad>


base_w = 90;
base_d = 75;

component_back = 10;
componenet_offset = 3;

max_post = [15.8, 8];
blackpill_posts = [19, 7, 50];

ads_over = 28;
ads_fwd = 5;
ads_post_over = 21;
ads_post_h = 6;

power_over = 8;
power_w = 20;

corner_post_h = 22;
//
module base() {

    difference() {
        bottom_plate(base_w, base_d, os_circle(r=1));
        plate_screws(base_w, base_d);
    }
                
                
    up(wall_thickness-.01) fwd(base_d/2) left(base_w/2) {
        up(post_h/2)  {
            back(base_d) // back left
            right(component_padding_w) fwd(component_back-componenet_offset) //inset
            right(max_post[0]) fwd(max_post[1]) { // max post 
                post();
                right(ads_over)
                fwd(ads_fwd) {
                    for(i = [0, ads_post_over]) {
                        right(i) post(post_h=ads_post_h, screw_length=ads_post_h);
                    }
                }
            }
            
            right(component_padding_w) back(component_back+componenet_offset) { //inset
                for (right_i = [1,2]) {
                    back(blackpill_posts[0])
                    right(blackpill_posts[right_i])
                        post();
                }
                right(blackpill_posts[2] + power_w/2 - wall_thickness*2 + power_over) // right of blackpill
                down(post_h/2) up(power_wall_height/2)
                back(blackpill_posts[0])
                    slide(power_wall_height, power_w, power_d, power_top_rail_center, power_bottom_lift);
            }
        }
        
       right(strain_thickness/2) back(post_d + strain_width/2) strain_relief();

    }
    for (i = [0, 1, 2]) {
        back(base_d/2-strain_thickness/2) right(base_w/3-base_w/3*i) up(wall_thickness-.01) zrot(90) { 
            strain_relief();
        }
    }
}

module cover_with_cutouts() {
    difference() {
        cover_solid(base_w, base_d, corner_post_h);

        for (i = [0, 1, 2]) {
            back(base_d/2-wall_thickness/2) right(base_w/3-base_w/3*i) down(corner_post_h) zrot(90) { 
                strain_relief_cutout();
            }
        }
        
        thermo_w = 13;
        thermo_back_c = 16;
        screen_front_c = 13;
        thermo_h = 15;
        thermo_screw_back = 8;
        left(base_w/2-wall_thickness/2) {
            back(base_d/2-thermo_back_c) {
                down(thermo_h/2+wall_thickness) cuboid([wall_thickness+.01, thermo_w, thermo_h]);
                up(wall_thickness/2) right(thermo_w/ 2+ thermo_screw_back) xrot(90) cuboid([thermo_h, wall_thickness+.01, thermo_w]);
            }
            down(corner_post_h+.01) fwd(base_d/2 - screen_front_c) {
                strain_relief_cutout();
            }
        }
    }
}

base();
xrot(180) right(base_w+20) cover_with_cutouts();

//up(corner_post_h+wall_thickness) cover_with_cutouts();