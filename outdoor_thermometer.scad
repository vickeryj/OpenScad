include <BOSL2/std.scad>

$fn=64;

base_d = 100;
oval_scale = 1.2;
wall_w = 1.5;

post_back = 9.5;
post_fwd = 22;
post_over = 40;

post_locations = [
        [-base_d/2+post_back,-1.5],  
        [base_d/2-post_fwd-1.5, post_over-1.3],
        [base_d/2-post_fwd, -post_over+.5]];


module posts(post_height, post_d, foot_rounding = -1) {
    for (coords = post_locations) {
        back(coords[0]) right(coords[1]) cyl(d=post_d, h=post_height, anchor=BOTTOM, rounding1=foot_rounding);
    }
}

module post_holes(hole_d=2.5, post_height) {
    for (coords = post_locations) {
        back(coords[0]) right(coords[1]) down(0.01) cyl(d=hole_d, h=post_height+.02, anchor=BOTTOM);
    }
}

module insert_holes() {
    for (coords = post_locations) {
        back(coords[0]) right(coords[1]) up (post_height-4.49) m3_insert();
    }
}

module base() {
    flange_d = 120;
    base_h = 10;
    post_h = 5;
    govee_s = [60, 22, 5];
    platform_lift = 10;

    //cuboid base values
    base_y = base_h+platform_lift; //translates to base_height
    base_x = govee_s[0]+wall_w*2; // translate to base start
    h = govee_s[1]+wall_w*2;
    top_y = base_h;
    
    module platform() {
        difference() {
            xscale(oval_scale) cyl(d1 = flange_d, d2 = base_d, h = base_h, anchor=BOTTOM, rounding2=2);
            down(wall_w) xscale(oval_scale) cyl(d1 = flange_d, d2 = base_d, h = base_h-wall_w, anchor=BOTTOM);
        }
        //down(platform_lift) cuboid([govee_s[0]+wall_w*2, govee_s[1]+wall_w*2, base_h+platform_lift], anchor=BOTTOM);
        down(wall_w) back(govee_s[1]/2+wall_w) xrot(90) //yrot(270) //xrot(90) 
           prismoid(
                size1=[base_x, base_y], 
                size2=[base_x, top_y], h=h, 
                shift=[0,(base_y-top_y)/2], anchor=BOTTOM);
    }
    

    screw_hole_d = 3.2;

    difference() {
        platform();
        up(base_h-post_h) posts(post_h, screw_hole_d, true);
        up(base_h-govee_s[2]+.01) cuboid(govee_s, anchor=BOTTOM, rounding = -1, edges=[TOP+FRONT,TOP+RIGHT, TOP+LEFT, TOP+BACK]);
    }
   
}

module top() {

    base_d = 100;
    top_d = 150;
    height = 20;

    screw_post_d = 6;
    post_back = 9.5;
    post_fwd = 22;
    post_over = 40;
    post_height = height;

    difference() {

        xscale(oval_scale) cyl(d1=base_d, d2=top_d, h=height, anchor=BOTTOM, rounding1=2);
        up(wall_w) xscale(oval_scale) cyl(d1=base_d-wall_w, d2=top_d-wall_w, h = height, anchor=BOTTOM, rounding1=2, rounding2=-2);

    }

    up(wall_w-.01) posts(post_height=post_height, foot_rounding=0);

}

module middle(post_d = 6, inserts = false, solid = false) {
    top_d = 130;
    height = 18;

    screw_post_d = 6;
    post_back = 9.5;
    post_fwd = 22;
    post_over = 40;
    screw_hole_d = 2.5;
    post_height = height-wall_w;

    module outer_louver() {
        difference() {
            xscale(oval_scale) cyl(d1=base_d, d2=top_d, h=height, anchor=BOTTOM);
            up(wall_w) xscale(oval_scale) cyl(d1=base_d-wall_w, d2=top_d-wall_w, h = height, anchor=BOTTOM);
            if (!solid) {
                down(0.01) xscale(oval_scale) cyl(d=base_d-hole_inset, h=wall_w+.02, anchor=BOTTOM);
            }
        }
        
    }
    
    module inner_louver() {
        inner_d_start = base_d - wall_w;
        inner_d_end = inner_d_start-28;
        inner_h = height-wall_w;
        up(wall_w) {
            difference() {
                xscale(oval_scale) cyl(d1=inner_d_start, d2=inner_d_end, h=inner_h, anchor=BOTTOM);
                down(.01) xscale(oval_scale) cyl(d1=inner_d_start-wall_w, d2=inner_d_end-wall_w, h = inner_h+.02, anchor=BOTTOM);
            }

        }
    }
    
    module posted_louvers() {
        outer_louver();
        inner_louver();
        posts(post_height=post_height, post_d=post_d, foot_rounding=0);
    }
    hole_inset = 6;
    difference() {
        posted_louvers();
        down(height-post_height-wall_w) post_holes(post_height = post_height);
    }
}
 
module m3_insert() {
    insert_height = 4;
    up(1.3) cyl(d2=5.53, d1=5.16, h=insert_height-.8, chamfer2=-.3, anchor=BOTTOM);
    up(.51) cyl(d=4.3, h=.8, anchor=BOTTOM);
    cyl(d=0.8, h=.5, anchor=BOTTOM);
}

//m3_insert();
//right(200) top();
//up(10) yrot(180) right(160) base();

//middle(post_d = 9, inserts = true);
//right(200) 
//middle(solid=true);
middle(solid=true);
right(200) middle();
