include <BOSL2/std.scad>
include <BOSL2/rounding.scad>




module guide(floor_gap, door_gap, door_thickness) {

    post_thickness = 7;
    post_height = 30;
    door_depth = door_thickness;
    angled_post_hypotenuse = post_height/sin(80);
    angled_post_thickness = sqrt(angled_post_hypotenuse^2-post_height^2);
    rounding = 2;
    guide_depth = door_depth*2+door_gap+post_thickness*2+angled_post_thickness*2+rounding*4;
    guide_width = 30;
    base_height = floor_gap;

    
    
        left_post_path = turtle([
        "left", 180,
        "move", angled_post_thickness,
        "right", 100,
        "move", angled_post_hypotenuse,
        "right", 80,
        "move", post_thickness,
        "arcright", rounding, 90,
        "move", post_height-rounding]);
              
    center_post_path = turtle(["left", 90,
        "move", post_height,
        "arcright", rounding, 90,
        "move", door_gap,
        "arcright", rounding, 90,
        "move", post_height,
        "left", 90]);

    right_post_path = turtle(["left", 90,
        "move", post_height,
        "arcright", rounding, 90,
        "move", post_thickness,
         "right", 80,
        "move", angled_post_hypotenuse]);
        
    guide_path = path_join([left_post_path, 
                            turtle(["move", door_depth]),
                            center_post_path,
                            turtle(["move", door_depth]),
                            right_post_path,
                            turtle(["right", 89.99,
                                "move", base_height,
                                "right", 90,
                                "move", guide_depth,
                                "right", 90,
                                "move", base_height])
                            ]);
    
    
    
//    stroke(guide_path);
    
    offset_sweep(guide_path, 
        height = guide_width,
        bottom=os_circle(r=rounding),
        top=os_circle(r=rounding)
        );
    
}

//deana_closet floor_gap, door_gap, door_width
//maybe too much for the door width and door_gap, everythign looks good
//guide(25, 10, 40);

//front closet, try tighter 9, 9, 38
 guide(9, 9, 38);

//guide();