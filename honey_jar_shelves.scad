include <BOSL2/std.scad>
include <BOSL2/rounding.scad>
//
//
jar_d = 50;  // add indent gap
jar_h = 70;  // add finger gap
spacing = 20;
shelf_h = 10;
indent_h = 6;
shelf_w = jar_d * 3 + spacing * 2.5; 
shelf_d = jar_d + spacing;
post_size = 6;
post_round = 1;
$slop = .11;
//
//$fn=64;
//
module shelf(cutout = false, legs = false) {
    
    module flat() {
        cuboid([shelf_w, shelf_d, shelf_h], rounding=2);
    }
    
    module indent() {
        up(shelf_h/2 - indent_h/2 + .01)
            cyl(h=indent_h, d = jar_d, rounding=-2);
    }
    
    
    module arc_post() {
        height = jar_h;
        depth = jar_d;
        r = 1;
        hook_path = turtle([
            "move", depth,
            "arcright", r, 180,
            "arcleft", jar_h/2-1, 180,
            "arcright", r, 180,
            "move", depth,
            "right", 90,
            "move", height

        ]);
        
        //stroke(hook_path);
        thickness = 6;
        rounding = 1;
        offset_sweep(hook_path, 
            height = thickness,
            bottom=os_circle(r=rounding),
            top=os_circle(r=rounding)
            );
    }
    
    module post_hole() {
        down(shelf_h/4+.01)
            rounded_prism(square(post_size+$slop*2), height=shelf_h/2, joint_top=0,
                joint_bot=0, joint_sides=post_round);
    }
    
    post_w_spacing = shelf_w/3 - post_size/2 - post_size/6;
    
    if (legs) {
        for(i = [post_w_spacing : post_w_spacing : shelf_w-post_w_spacing]) {
            back(shelf_d/2-post_size*1.5)
            left(shelf_w/2-post_size/2)
            right(i)
                xrot(90) yrot(90) arc_post();
        }
    }
        
    
    

    difference() {
        flat(); 
        for(i = [-1 : 1 : 1]) {
            right((i * jar_d)+spacing/1.5*i)
            indent();
        }
        if (cutout) {
            for(i = [0 : post_w_spacing : shelf_w]) {
                back(shelf_d/2-post_size*1.5)
                left(shelf_w/2-post_size/2)
                right(i)
                    post_hole();
            }
            
            for(i = [post_w_spacing : post_w_spacing: shelf_w-post_w_spacing]) {
                left(shelf_w/2-post_size/2)
                fwd(shelf_d/3)
                right(i)
                    post_hole();
            }
        }
    }
    }
    





shelf(legs=true);
//up(jar_h) shelf(cutout=true, legs=true);
//up(jar_h*2) shelf(cutout=true);



