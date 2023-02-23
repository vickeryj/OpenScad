width = 23.5;
height = 5;
depth = 5;
wall_thickness = .1;
cutout_edge_y = 1.3;
cutout_edge_x = 2;
wall_width = .75;
num_slats = 6;

module box_bottom(width, depth, height, wall_thickness) {
    difference() {
        cube([width, depth, height]);
        translate([wall_thickness, wall_thickness, (wall_thickness) + .001])
            cube([
                    width - (2 * wall_thickness), 
                    depth - (2 * wall_thickness), 
                    height - (3* wall_thickness)
                 ]);

    };
};


module box_side_cutouts(width, depth, height, wall_width) {
    //cut out top and bottom
    translate([wall_width, wall_width, -0.01])
        cube([width - wall_width*2, depth - wall_width*2, height + .02]);
    //cut out front and back
    translate([wall_width, -0.01, wall_width])
        cube([width - wall_width*2, depth+.02, height-wall_width*2]);
    //cut out sides
    translate([-.01, wall_width, wall_width])
        cube([width+.02, depth - wall_width*2, height-wall_width*2]);
};


module slats(num_slats) {
    space = (width - wall_width)/(num_slats+1);
    for (x = [space:space:width-wall_width]) {
        translate([x, 0, 0])
            cube([wall_width, depth, wall_thickness]);
    }
    for (x = [space:space:width-wall_width]) {
        translate([x, 0, 0])
            cube([wall_width, wall_thickness, height]);
        translate([x, depth-wall_thickness, 0])
            cube([wall_width, wall_thickness, height]);
    }
}

module slatted_box() {
    slats(num_slats);
    difference() {
        box_bottom(width, depth, height, wall_thickness);
        box_side_cutouts(width, depth, height, wall_width);
    }
}

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
            translate([0, wall_width, -.01])
                cube([width, depth+wall_thickness+.02, height+.02]);
        };
        translate([0, wall_thickness, -.01])
            cube([width, wall_width+.01, wall_thickness+.02]);
    };
    translate([width/3+width/3/2/2, 0, wall_thickness])
        cube([width/3/2, wall_width, 2*wall_thickness]);
}

module front_left_slice() {
    difference() {
        difference() {
            slice(left = true);
            translate([-.01, wall_width, -.01])
                cube([width, depth+wall_thickness+.02, height+.02]);
        }
        translate([0, wall_thickness, -.01])
            cube([width, wall_width, wall_thickness+.02]);
        translate([-.01, wall_thickness, 0])
            cube([wall_thickness+.02, wall_width+.01, height+.01]);
    }
    translate([wall_thickness, 0, wall_thickness])
        cube([width/3/2, wall_width, 2*wall_thickness]);

}

module side_left_slice() {
    difference() {
        slice(left = true);
        translate([wall_thickness, -0.01, -.01])
            cube([width, depth+.02, height+.02]);
    }
    translate([wall_thickness, wall_thickness, (height-3*wall_thickness)-.01])
        cube([wall_width, depth-2*wall_thickness, wall_thickness]);
    translate([wall_thickness, wall_width, height-2*wall_thickness])
        cube([wall_width, depth-2*wall_width, wall_thickness*2]);
    translate([wall_thickness, wall_width, wall_thickness])
        cube([wall_width, depth-2*wall_width, wall_thickness*2]);
}


//translate([0, -.5, 0])
//rotate([90,0,0])
//front_middle_slice();

translate([0, -.5, 0])
rotate([90,0,0])
front_left_slice();

translate([width/3, 0, 0])
rotate([0,-90,0])
side_left_slice();

//ride side slice
//translate([width, depth, 0])
//rotate([0,0,180])
//front_left_slice();


module bottom_middle_slice() {
    difference() {
        middle_slice();
        translate([0, -wall_thickness, wall_thickness])
            cube([width+.02, depth+wall_thickness+.02, height]);
    };
}
//bottom_middle_slice();


/* -- top
$fn=30;

r = (depth - (cutout_edge_y * 2))/2;

difference() {
    translate([0, -depth - 2, 0]) {
        difference() {
            cube([width, depth, wall_thickness]);
            translate([cutout_edge_x+r, cutout_edge_y + r, -.001])
                cylinder(wall_thickness + .002, r, r);
            translate([width - cutout_edge_x - r, cutout_edge_y + r, -.001])
                cylinder(wall_thickness + .002, r, r);
            translate([cutout_edge_x + r, cutout_edge_y, -.001])
                cube([width - (2 * cutout_edge_x) - 2 * r, 
                      depth - (2 * cutout_edge_y),
                      wall_thickness + .002]);
        };
    };
    translate([0, -depth - 2, 0])
    translate([width/2 + .001, -.001, -.001])    
        cube([width+.002, depth+.002, wall_thickness+.002]);

};

*/




/*
translate([0, -4, height + open_amount/2]) {
    translate([wall_thickness, wall_thickness, 0]) {
        difference() {
            cube([width - 2 * wall_thickness, depth - 2 * wall_thickness, 2*wall_thickness]);
            translate([2*wall_thickness, 2*wall_thickness, -.001])
                cube([width - (8 * wall_thickness), depth - 4 * wall_thickness, 2*wall_thickness + .002]);
        }
     }
}*/
