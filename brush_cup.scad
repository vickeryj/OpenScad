$fn = 60;

wall_width = 3;

module cup(w, h) {

    module outer_heart(w, h) {
        linear_extrude(height = h) {
            shape_size = w*2/3;
            
            circle(d = shape_size);
            translate([0, -shape_size/2, 0])
                square(shape_size);
            translate([shape_size/2,shape_size/2,0])
                circle(d = shape_size);
        }
    }

    
    module inner_heart(w, h) {
        linear_extrude(height = h + wall_width) {
            shape_size = (w-wall_width*2)*2/3;
            
            translate([wall_width/2/3, 0, 0])
                circle(d = shape_size);
            translate([wall_width/3*2, -shape_size/2, 0])
                square(shape_size);
            translate([shape_size/2+wall_width/3*2,shape_size/2+wall_width/2,0])
                circle(d = shape_size);
        }
    }
    difference() {
        outer_heart(w, h);
        translate([0,0,wall_width]) inner_heart(w,h);
    }
}


cup(w = 76, h = 89); 