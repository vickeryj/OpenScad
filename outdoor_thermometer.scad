include <BOSL2/std.scad>

$fn=64;

base_d = 100;
oval_scale = 1.2;
wall_w = 1.5;


module posts(post_height, screw_hole_d = 2.5, just_holes = false, inserts = false, post_d = 6) {

    screw_post_d = post_d;
    post_back = 9.5;
    post_fwd = 22;
    post_over = 40;

    for (coords = [
            [-base_d/2+post_back,-1.5],  
            [base_d/2-post_fwd-1.5, post_over-1.3],
            [base_d/2-post_fwd, -post_over+.5]]) 
    {
        back(coords[0]) right(coords[1]) {
            if (just_holes) {
                down(0.01) cyl(d=screw_hole_d, h=post_height, anchor=BOTTOM);
            } else {
                difference() {
                    cyl(d=screw_post_d, h=post_height, anchor=BOTTOM, rounding1=-1);
                    up(0.01) cyl(d=screw_hole_d, h=post_height, anchor=BOTTOM);
                    if(inserts) {
                        up (post_height-4.49) m3_insert();
                    }
                }
            }
        }
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

//base();

//up(10) yrot(180) right(160) base();





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

    up(wall_w-.01) posts(post_height);

}

right(200) top();

module middle(post_d = 6, inserts = false) {
    top_d = 130;
    height = 18;

    screw_post_d = 6;
    post_back = 9.5;
    post_fwd = 22;
    post_over = 40;
    screw_hole_d = 2.5;
    post_height = height;

    module platform() {
        difference() {
            xscale(oval_scale) cyl(d1=base_d, d2=top_d, h=height, anchor=BOTTOM, rounding1=2);
            up(wall_w) xscale(oval_scale) cyl(d1=base_d-wall_w, d2=top_d-wall_w, h = height, anchor=BOTTOM, rounding1=2, rounding2=-2);
        }
        up(wall_w-.01) posts(post_height, post_d=post_d, inserts = inserts);
    }
        
    hole_inset = 30;
    difference() {
        platform();
        down(height-post_height) posts(post_height, just_holes=true);
        down(0.01) xscale(oval_scale) cyl(d=base_d-hole_inset, h=height, anchor=BOTTOM);
    }

}

middle(post_d = 9, inserts = true);

insert_height = 4;
 
module m3_insert() {
    up(1.3) cyl(d2=5.59, d1=5.16, h=insert_height-.8, chamfer2=-.3, anchor=BOTTOM); //d2 and d1 are a bit too larg on the trident
    up(.51) cyl(d=4.3, h=.8, anchor=BOTTOM);
    cyl(d=0.8, h=.5, anchor=BOTTOM);
}

//m3_insert();