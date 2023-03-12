$fn = 60;


module shelf(wall_width, shelf_depth, shelf_height, shelf_width, gap) {
    module walls() {
        translate([0, 0, 0]) cube([shelf_width, shelf_depth, wall_width]);
        translate([0, 0, wall_width]) cube([wall_width, shelf_depth, shelf_height]);
        translate([0, 0, shelf_height+wall_width]) cube([30, shelf_depth, wall_width]);
        translate([wall_width, shelf_depth-wall_width, wall_width]) cube([shelf_width-wall_width, wall_width, shelf_height/2]);
    }
    difference() {
        walls();
        translate([wall_width+15/2, 15, shelf_height+wall_width-.01]) 
            keyhole();
        translate([wall_width+15/2, shelf_depth - 15, shelf_height+wall_width-.01]) 
            keyhole();
    }
}

//big laptop
laptop_width_1 = 390;
laptop_depth_1 = 250;
laptop_height_1 = 17;

shelf_height_1 = 30;
shelf_depth = 45;

wall_width = 4;
side_gap = 1;
top_gap = 10;



module shelf_1() {
    shelf_gap = laptop_height_1+wall_width;
    difference() {

            cube([laptop_width_1, laptop_depth_1, laptop_height_1]);


            shelf(wall_width, 250, shelf_gap, shelf_depth, 8);
        }
        translate([-.01, -.01, -shelf_height_1*2+4]) cube([wall_width+.02, 35, laptop_height_1-2]);

}


shelf_length = 150;

laptop_width_2 = 330;
laptop_depth_2 = 215;
laptop_height_2= 11;

shelf_2_width = laptop_width_2+side_gap*2+wall_width*2;

module mba_foot() {
    cylinder(h = 2.3, d = 22, center = false);
}

module mba() {
    cube([laptop_width_2, laptop_depth_2, laptop_height_2]);
    translate([14.5+21/2, 14.5+21/2, -2.3]) mba_foot();
    translate([14.5+21/2, laptop_depth_2-14.5-21/2, -2.3]) mba_foot();
    color("red", 1) translate([laptop_width_2+.01, 14.8, 4]) cube([.1, 46.7, 4]);
    translate([-14.5-21/2+laptop_width_2, 14.5+21/2, -2.3]) mba_foot();
    translate([-14.5-21/2+laptop_width_2, laptop_depth_2-14.5-21/2, -2.3]) mba_foot();
}

module shelf_2() {
    shelf_gap = laptop_height_2+top_gap;

/*    difference() {
        shelf( wall_width, shelf_length, shelf_gap, shelf_depth, 8);
        translate([-.01, 10, wall_width+3.5]) 
            cube([wall_width+.02, 53, laptop_height_2-4]);
    }*/
    translate([0, laptop_depth_2-shelf_length+wall_width, 0])
        shelf( wall_width, shelf_length, shelf_gap, shelf_depth, 8);
        
}


module guide_1(shelf_gap) {
    translate([wall_width, shelf_length-30, shelf_gap+wall_width-2])
        cube([30, laptop_depth_2-shelf_length-30, 2]);
    translate([wall_width, shelf_length-30, shelf_gap+wall_width-2-10])
        cube([2, laptop_depth_2-shelf_length-30, 10]);
    translate([15, 65, shelf_gap+wall_width])
        cylinder(h = wall_width+.02, r = 11/2, center = false);
    translate([15, 150, shelf_gap+wall_width])
        cylinder(h = wall_width+.02, r = 11/2, center = false);    
}

module guide_2_1(shelf_gap) {
    translate([wall_width, 0, shelf_gap+wall_width-2])
        cube([shelf_2_width/2-wall_width, 30, 2]);
    translate([wall_width, 0, shelf_gap+wall_width-2-10])
        cube([2, 30, 10]);
    translate([15, 15, shelf_gap+wall_width])
        cylinder(h = wall_width+.02, r = 11/2, center = false);
        
    translate([wall_width+shelf_2_width/2-wall_width-10, 0, shelf_gap+wall_width-4])
        cube([20, 30, 2]);    
    translate([wall_width+shelf_2_width/2-wall_width-10, -2, shelf_gap+wall_width-4])
        cube([20, 2, 4]);
    translate([wall_width+shelf_2_width/2-wall_width-10, 30, shelf_gap+wall_width-4])
        cube([20, 2, 4]);

}

module guide_2_2(shelf_gap) {
     translate([wall_width+shelf_2_width/2-wall_width, 0, shelf_gap+wall_width-2])
        cube([shelf_2_width/2-wall_width, 30, 2]);
    translate([wall_width+shelf_2_width-wall_width*2-2, 0, shelf_gap+wall_width-2-10])
        cube([2, 30, 10]);
    translate([shelf_2_width-15, 15, shelf_gap+wall_width])
        cylinder(h = wall_width+.02, r = 11/2, center = false);

}

module keyhole() {
    cylinder(h = wall_width+.02, d = 11.6, center = false);
    translate([10, 0, 0]) cylinder(h = wall_width+.02, r = 4.1/2, center = false);
    translate([0, -4.1/2, 0]) cube([10, 4.1, wall_width+.02]); 
}

intersection() {
//shelves();
//translate([-.01, -.01, -shelf_height_1*2-wall_width*2]) cube(80);
//translate([laptop_width_1-80+20, -.01, -shelf_height_1*2-wall_width*2]) cube(80);
}

module brace(width, height) {
    brace_depth = 10;
    length = sqrt(width^2 + height^2);
    rotate([0, 45, 0]) cube([wall_width, brace_depth, length]);
}

module left_shelves() {
    //translate([gap, 0, -shelf_height_1]) 
    //translate([0, 0, -shelf_height_1]) shelf_1();
    //translate([0, 63, -shelf_height_1]) brace(shelf_height_1, shelf_height_1);
    //translate([0, 0, -shelf_height_1*2]) brace(shelf_height_1, shelf_height_1);
    shelf_2();
}

module right_shelves() {
    translate([shelf_2_width, 0, 0]) 
        mirror([1, 0, 0])
            left_shelves();
}

module shelves() {
left_shelves();
right_shelves();
}

difference() {
    shelves();
    translate([wall_width+side_gap, -1, wall_width]) mba();
}
//translate([wall_width+side_gap, -1, wall_width]) color("red", .1) mba();
//translate([60, 0, 0]) guide_1(laptop_height_2+top_gap);
//translate([60, -60, 0]) guide_2_1(laptop_height_2+top_gap);
//translate([-60, 0, 0]) guide_2_2(laptop_height_2+top_gap);
