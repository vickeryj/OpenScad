include <BOSL2/std.scad>

$fn=64;

base_d = 100;
oval_scale = 1.2;
wall_w = 1.5;


module posts(post_height, screw_hole_d = 2.5, just_holes = false) {

    screw_post_d = 6;
    post_back = 9.5;
    post_fwd = 22;
    post_over = 40;

    for (coords = [
            [-base_d/2+post_back,-1.5],  
            [base_d/2-post_fwd-1.5, post_over-1.3],
            [base_d/2-post_fwd, -post_over+.5]]) 
    {
        back(coords[0]) right(coords[1]) {
            difference() {
                if (!just_holes) {
                    cyl(d=screw_post_d, h=post_height, anchor=BOTTOM, rounding1=-1);
                }
                up(0.01) cyl(d=screw_hole_d, h=post_height, anchor=BOTTOM);
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

    //cuboid vase values
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
        up(base_h-post_h) posts(post_h, 3.2, true);
        up(base_h-govee_s[2]+.01) cuboid(govee_s, anchor=BOTTOM, rounding = -1, edges=[TOP+FRONT,TOP+RIGHT, TOP+LEFT, TOP+BACK]);
    }


    


    
   
}

//base();

up(10) yrot(180) right(160) base();





module top() {

    base_d = 100;
    top_d = 150;
    height = 28;

    screw_post_d = 6;
    post_back = 9.5;
    post_fwd = 22;
    post_over = 40;
    screw_hole_d = 2.5;
    post_height = height-5;

    difference() {

        xscale(oval_scale) cyl(d1=base_d, d2=top_d, h=height, anchor=BOTTOM, rounding=2);
        xscale(oval_scale) up(wall_w) cyl(d1=base_d-wall_w, d2=top_d-wall_w*8, h = height-wall_w+0.01, anchor=BOTTOM, rounding1=2, rounding2=-2);

    }

    up(wall_w-.01) posts(post_height);

}

top();


