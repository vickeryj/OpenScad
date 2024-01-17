include <gaggiuino_common.scad>


base_w = 90;
base_d = 75;

component_back = 10;

max_post = [15.8, 8];
blackpill_posts = [19, 7, 50.2];

ads_over = 28;
ads_fwd = 5;
ads_post_over = 23.5;

power_over = 8;
power_w = 20;

corner_post_h = 22;

wire_d = 4;

module base() {

    difference() {
        plate(base_w, base_d, os_circle(r=1));
        plate_screws(base_w, base_d);
    }
                
                
    up(wall_thickness-.01) fwd(base_d/2) left(base_w/2) {
        up(post_h/2)  {
            back(base_d) // back left
            right(component_padding_w) fwd(component_back) //inset
            right(max_post[0]) fwd(max_post[1]) { // max post 
                post();
                right(ads_over)
                fwd(ads_fwd) {
                    for(i = [0, ads_post_over]) {
                        right(i) post(screw_hole="M2", post_h=6, screw_length=6, slop=0.05);
                    }
                }
            }
            
            right(component_padding_w) back(component_back) { //inset
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
    }
}

module cover_with_cutouts() {
    difference() {
        cover_solid(base_w, base_d, corner_post_h);
        for (i = [0, 1, 2]) {
            back(base_d/2-wall_thickness/2) down(corner_post_h/3) right(base_w/3-base_w/3*i) xrot(90) { 
                cyl(h = wall_thickness+.02, d = wire_d)
                fwd(wire_d*4/2) cuboid([wire_d, wire_d*4, wall_thickness+02]);
            }
        }
        thermo_w = 13;
        thermo_back_c = 17;
        screen_front_c = 13;
        left(base_w/2-wall_thickness/2) {
            back(base_d/2-thermo_back_c) down(corner_post_h/2 + wall_thickness/2) 
                cuboid([wall_thickness+.01, thermo_w, corner_post_h - wall_thickness +.01]);
            down(corner_post_h/3) fwd(base_d/2 - screen_front_c) {
                yrot(90) cyl(h = wall_thickness+.02, d = wire_d);
                down(wire_d*4/2) cuboid([wall_thickness+02, wire_d, wire_d*4]);
            }
        }
    }
}

module test_m2_posts() {
    post_height = 6; 
    slops = [0, .05, $slop];
    for (slop_idx = [0:2]) {
        right(10*slop_idx) post(screw_hole="M2", screw_length = post_height, post_h=post_height, slop=slops[slop_idx]);
        down(post_height/2) fwd(6) right(slop_idx*10-3.4) text3d(format_float(slops[slop_idx]), size = 3);
        fwd(10) right(10*slop_idx) post(screw_hole="M3", screw_length = post_height, post_h=post_height, slop=slops[slop_idx]);
    }
    wall_thickness = 1;
    right(10) fwd(5) down(post_height/2+wall_thickness/2-.01) cuboid([30,20,wall_thickness]);
}

//test_m2_posts();


base();
xrot(180) right(base_w+20)
cover_with_cutouts();