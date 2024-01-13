include <gaggiuino_common.scad>


base_w = 90;
base_d = 75;


max_post = [15.8, 8];
blackpill_posts = [19, 7, 43.2];

ads_over = 28;
ads_fwd = 7;
ads_post_over = 23.5;

power_over = 12;
power_w = 18;

corner_post_h = 16;

wire_d = 4;

module base() {

    difference() {
        plate(base_w, base_d, os_circle(r=1));
        plate_screws(base_w, base_d);
    }
                
                
    up(wall_thickness/2) fwd(base_d/2) left(base_w/2) {
        up(post_h/2)  {
            back(base_d) // back left
            right(component_padding_w) fwd(component_back) //inset
            right(max_post[0]) fwd(max_post[1]) { // max post 
                post();
                right(ads_over)
                fwd(ads_fwd) {
                    post();
                    right(ads_post_over) post();
                }
            }
            
            right(component_padding_w) back(component_back) { //inset
                for (right_i = [1,2]) {
                    back(blackpill_posts[0])
                    right(blackpill_posts[right_i])
                        post();
                }
                right(blackpill_posts[1] + blackpill_posts[2] + power_over) // right of blackpill
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
            for (j = [base_d/2-wall_thickness/2, -base_d/2+wall_thickness/2]) {
                back(j) down(corner_post_h/3) right(base_w/3-base_w/3*i) xrot(90) cyl(h = wall_thickness+.02, d = wire_d);
            }
        }
    }
}

//base();

cover_with_cutouts();