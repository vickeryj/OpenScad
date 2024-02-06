//use </Users/vickeryj/Code/OpenSCAD/day343_mathgrrl_hinge.scad>;

/* small roll
width = 232;
height = 50;
depth = 50;*/

$fn=70;

//big roll
width = 212;
height = 65;
depth = 70;
wall_thickness = 4;


cutout_edge_y = 13;
cutout_edge_x = 20;
num_slats = 5;
slat_thickness = 12;

module box_bottom(width, depth, height, wall_thickness) {
    difference() {
        cube([width+2*wall_thickness, depth+2*wall_thickness, height+2*wall_thickness]);
        translate([wall_thickness, wall_thickness, wall_thickness])
            cube([width, depth, height + wall_thickness*4]);

    }
    translate([width/2, wall_thickness, height+3]) {
        difference() {
            cube([8, 8, 4]);
            translate([4, 4, 2+.01])
            cylinder(h = 3, r = 2.5, center = false);
        }
    }
};

//color("red", .1) box_bottom(width, depth, height, wall_thickness);


module box_side_cutouts(width, depth, height, wall_thickness) {
    //cut out top and bottom
    translate([wall_thickness, wall_thickness, -wall_thickness])
        cube([width, depth, height + wall_thickness*4]);
    //cut out front and back
    translate([wall_thickness, -wall_thickness, wall_thickness])
        cube([width, depth + wall_thickness*4, height]);
    //cut out sides
    translate([-wall_thickness, wall_thickness, wall_thickness])
        cube([width + wall_thickness*4, depth, height]);
};

//box_side_cutouts(width, depth, height, wall_thickness);

module slats(num_slats) {
    space = (width +2*wall_thickness - slat_thickness)/(num_slats+1);
    for (x = [space:space:width-slat_thickness]) {
        translate([x, 0, 0])
            cube([slat_thickness, depth+wall_thickness*2, wall_thickness]);
    }
    for (x = [space:space:width-wall_thickness]) {
        translate([x, 0, wall_thickness])
            cube([slat_thickness, wall_thickness, height]);
        translate([x, depth+wall_thickness, wall_thickness])
            cube([slat_thickness, wall_thickness, height]);
    }
}

module slatted_box() {
    slats(num_slats);
    difference() {
        box_bottom(width, depth, height, wall_thickness);
        box_side_cutouts(width, depth, height, wall_thickness);
    }
}

//slatted_box();

num_slices = 3;
slice_size = (width+2*wall_thickness)/num_slices+.02;

module slice(s) {
    intersection() {
        box_bottom(width, depth, height, wall_thickness);
        translate([s*slice_size-.01, 0, 0]) cube(slice_size);
    }
}


module joiner(width, depth, height, thickness) {
    translate([0, 0, 0])
        cube([width,thickness, height]);    
    translate([0,thickness,0])
        cube([width,depth, thickness]);        
    translate([0, depth+thickness, 0])
        cube([width, thickness, height]);    
}

//slice(0);

module middle_base() {
    slice(1);
    translate([slice_size-10, wall_thickness, wall_thickness])
        joiner(20, depth-joiner_thickness*2, height-10, joiner_thickness);
    translate([slice_size*2-10, wall_thickness, wall_thickness])
        joiner(20, depth-joiner_thickness*2, height-10, joiner_thickness);    
    
    translate([slice_size+10, depth+.2, height+wall_thickness/2])
      male_hinge();
    translate([slice_size*2-10-tabWidth, depth+.2, height+wall_thickness/2])
      male_hinge();
}

tabThickness = 1.85;
tabWidth = wall_thickness+.02;
tabSeperation = 1.3;
backLength = 5;
pivotTolerance = 1;

module male_hinge() {
    translate([tabWidth+tabSeperation, tabThickness, backLength+tabThickness+pivotTolerance])
        rotate([270,0,90])
            insidePart();
}


//middle_base();

//slice(2);



// -- top

//color("red") cube([220-.01,78-.01,73]);

module top() {
    r = (depth - (cutout_edge_y * 2))/2;
    difference() {
        cube([width+wall_thickness*2, depth+wall_thickness, wall_thickness]);
        translate([cutout_edge_x+r+wall_thickness, cutout_edge_y + r + wall_thickness, -.001])
            cylinder(wall_thickness + .002, r, r);
        translate([width - cutout_edge_x - r, cutout_edge_y + r + wall_thickness, -.001])
            cylinder(wall_thickness + .002, r, r);
        translate([cutout_edge_x + r, cutout_edge_y + wall_thickness, -.001])
            cube([width - (2 * cutout_edge_x) - 2 * r, 
                  depth - (2 * cutout_edge_y),
                  wall_thickness + .002]);
        translate([slice_size+10+pivotTolerance/3, depth+wall_thickness-pivotTolerance+.01, -.01])
            negative_female();
        translate([slice_size*2-10-tabWidth+pivotTolerance/3, depth+wall_thickness-pivotTolerance+.01, -.01])
            negative_female();
        translate([width/2+4, wall_thickness*2+4, -1])
            cylinder(h = 3, r = 2.5, center = false);
    };
    translate([width/2, wall_thickness*2, - 1]) {
        difference() {
            cube([8, 8, 1]);
            translate([4, 4, -.01]) {
                cylinder(h = 3, r = 2.5, center = false);
            }
        }
    }
    
    translate([wall_thickness, wall_thickness, -wall_thickness]) cube([width/2 - 10, wall_thickness, wall_thickness]);
    translate([wall_thickness+width/2 + 10, wall_thickness, -wall_thickness]) cube([width/2 - 10, wall_thickness, wall_thickness]);
    
    translate([wall_thickness, wall_thickness*2, -wall_thickness]) cube([wall_thickness, depth-wall_thickness*2, wall_thickness]);
    translate([width, wall_thickness*2, -wall_thickness]) cube([wall_thickness, depth-wall_thickness*2, wall_thickness]);

}

//box_bottom(width, depth, height, wall_thickness);

//middle_base();
//translate([0, -wall_thickness, height + wall_thickness*2+0]) top_with_supports();
//rotate([180, 0, 0])
//top_middle_with_supports();
//translate([0, -depth-50, 0])



//translate([0,hinge_radius+gap,0]) bar();
//translate([0,-2*border-hinge_radius-gap,0]) bar();


module top_middle_with_supports() {
    intersection() {
        top();
        translate([1*slice_size-.01, 0, 0]) cube(slice_size);
    }

    translate([slice_size-15, 2*wall_thickness, -wall_thickness+.01])
    cube([30, 9, wall_thickness]);
    translate([slice_size*2-15, 2*wall_thickness, -wall_thickness+.01])
    cube([30, 9, wall_thickness]);
    translate([slice_size-15, depth-wall_thickness-pivotTolerance-tabThickness-2, -wall_thickness+.01])
    cube([30, 9, wall_thickness]);
    translate([slice_size*2-15, depth-wall_thickness-pivotTolerance-tabThickness-2, -wall_thickness+.01])
    cube([30, 9, wall_thickness]);

}

module top_with_hinge() {
    difference() {
        top();
        //top_middle_with_supports();
        //translate([slice_size-15-.01, -.01, -wall_thickness-.01]) cube([slice_size+30.02, 20, wall_thickness*2+.02]);
        translate([slice_size+(slice_size-55)/2, depth-wall_thickness, -.01]) cube([55, 20, wall_thickness+.02]);
    }
    translate([slice_size+(slice_size-55)/2, depth-wall_thickness/2+3.5+.01, wall_thickness/2-.01]) sphere(d = wall_thickness - 1);
    translate([slice_size*2-(slice_size-55)/2, depth-wall_thickness/2+3.5+.01, wall_thickness/2-.01]) sphere(d = wall_thickness - 1);
    
    difference() {
        translate([slice_size+(slice_size-55)/2+.5, depth-1+.01, -.01]) cube([54, 20, wall_thickness+.02]);
        translate([slice_size+(slice_size-55)/2, depth-wall_thickness/2+3.5+.01, wall_thickness/2-.01]) sphere(d = wall_thickness - .6);
        translate([slice_size*2-(slice_size-55)/2, depth-wall_thickness/2+3.5+.01, wall_thickness/2-.01]) sphere(d = wall_thickness - .6);
    }
    
}

/*rotate([180, 0, 0])
translate([0, 0, height+4])*/
top_with_hinge();



//rotate([180, 0, 0])
//top_hinge();

//top_middle_with_supports();

// left top
//    intersection() {
//      top();
//        translate([0*slice_size-.01, 0, 0]) cube(slice_size);
//    }



//        translate([slice_size*2-10-tabWidth, 0, height+wall_thickness])
module negative_female() {
    translate([0, tabThickness+tabSeperation, tabWidth/2]) 
            rotate([90,270,90])
                negativeOutsidePart();

}


/* thickness test
cube([20, 2, 20]);
translate([22, 0, 0])
cube([20, 3, 20]);
translate([44, 0, 0])
cube([20, 4, 20]);
*/


//slice with circle cutouts
/*cutout_r = min(width, depth)/2.5;
module slice_with_holes() {
difference() {
slice(0);



//left
translate([-0.01, depth/2+wall_thickness, height/2+wall_thickness])
rotate([0, 90, 0])
cylinder(h=wall_thickness+.02, r = cutout_r, center = false);

//bottom
translate([slice_size/2,depth/2+wall_thickness+.01,0])
rotate([0, 0, 90])
cylinder(h=wall_thickness+.02, r = cutout_r, center = false);

//front
translate([slice_size/2,wall_thickness+.01,height/2+wall_thickness])
rotate([90, 0, 0])
cylinder(h=wall_thickness+10, r = cutout_r, center = false);

//back
translate([slice_size/2,depth+2*wall_thickness+.01,height/2+wall_thickness])
rotate([90, 0, 0])
cylinder(h=wall_thickness+.02, r = cutout_r, center = false);

}
}

slice_with_holes();
*/


joiner_thickness = 2;
//translate([slice_size/2+slice_size/4, wall_thickness, wall_thickness])
//    joiner(slice_size/2, depth-joiner_thickness*2, height, joiner_thickness);


/*
flat printing
module slice(left = false, center = false, right = false) {
   difference() {
       slatted_box();
       if (!left) {
            translate([-.001, -.001, -.001])
                cube([width/3 + .001, depth + .002, height + .002]);
       }
       if (!center) {
            translate([width/3, -.001, -.001])
                cube([width/3 + .001, depth + .002, height + .002]);
       }
       if (!right) {    
            translate([width/3*2, -.001, -.001])
                cube([width/3 + .001, depth + .002, height + .002]);
       }

   }
}


module front_middle_slice() {
    difference (){
        difference() {
            slice(center = true);
            translate([0, wall_thickness, -.01])
                cube([width, depth+wall_thickness+.02, height+.02]);
        };
        translate([0, wall_thickness, -.01])
            cube([width, wall_thickness+.01, wall_thickness+.02]);
    };
    translate([width/3+width/3/2/2, 0, wall_thickness])
        cube([width/3/2, wall_thickness, 2*wall_thickness]);
}

module front_left_slice() {
    difference() {
        difference() {
            slice(left = true);
            translate([-.01, wall_thickness, -.01])
                cube([width, depth+wall_thickness+.02, height+.02]);
        }
        translate([0, wall_thickness, -.01])
            cube([width, wall_thickness, wall_thickness+.02]);
        translate([-.01, wall_thickness, 0])
            cube([wall_thickness+.02, wall_thickness+.01, height+.01]);
    }
    translate([wall_thickness, 0, wall_thickness])
        cube([width/3/2, wall_thickness, 2*wall_thickness]);

}

module side_left_slice() {
    difference() {
        slice(left = true);
        translate([wall_thickness, -0.01, -.01])
            cube([width, depth+.02, height+.02]);
    }
    translate([wall_thickness, wall_thickness, (height-3*wall_thickness)-.01])
        cube([wall_thickness, depth-2*wall_thickness, wall_thickness]);
    translate([wall_thickness, wall_thickness, height-2*wall_thickness])
        cube([wall_thickness, depth-2*wall_thickness, wall_thickness*2]);
    translate([wall_thickness, wall_thickness, wall_thickness])
        cube([wall_thickness, depth-2*wall_thickness, wall_thickness*2]);
}

module bottom_middle_slice() {
    difference() {
        middle_slice();
        translate([0, -wall_thickness, wall_thickness])
            cube([width+.02, depth+wall_thickness+.02, height]);
    };
};

module back_left_slice() {
    difference() {
        difference() {
            slice(left = true);
            translate([-0.01, -wall_thickness-wall_thickness, -0.01])
                cube([width+.02, depth+wall_thickness-0.01, height+.02]);;
        }
        translate([0, depth - wall_thickness - wall_thickness, -.01])
            cube([width, wall_thickness, wall_thickness+.02]);
        translate([-.01, depth - wall_thickness - wall_thickness, 0])
            cube([wall_thickness+.02, wall_thickness+.01, height+.01]);
    }
    translate([wall_thickness, depth-wall_thickness-wall_thickness, wall_thickness])
        cube([width/3/2, wall_thickness, 2*wall_thickness]);
}



module back_right_side_slice() {
    translate([width, depth, 0])
    rotate([0,0,180])
    front_left_slice();
};

*/

//translate([0, -.5, 0])
//rotate([90,0,0])
//front_middle_slice();
/*
translate([0, -5, 0])
rotate([90,0,0])
front_left_slice();

translate([width/3, 0, 0])
rotate([0,-90,0])
side_left_slice();
*/

//back_left_slice();

//back_right_side_slice();



//bottom_middle_slice();

