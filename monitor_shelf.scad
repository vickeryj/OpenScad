
module shelf(laptop_width, laptop_depth, laptop_height, wall_width, shelf_depth, shelf_height, shelf_width, gap) {
    translate([0, 0, 0]) rotate([0, 90, 0]) cube([wall_width, shelf_depth, shelf_height+wall_width]);
    translate([0, 0, -shelf_height]) cube([wall_width, shelf_depth, shelf_height]);
    translate([0, 0, -shelf_height-wall_width]) cube([wall_width + shelf_width, shelf_depth, wall_width]);
}

//big laptop
laptop_width_1 = 360;
laptop_depth_1 = 250;
laptop_height_1 = 17;
shelf_height_1 = 30;

wall_width = 4;
gap = 8;

module shelf_1() {
    difference() {
        translate([0, 0, -shelf_height_1]) {
            //translate([gap, 0, -shelf_height_1]) cube([laptop_width_1, laptop_depth_1, laptop_height_1]);

            shelf(laptop_width_1, laptop_depth_1, laptop_height_1, wall_width, 250, shelf_height_1, shelf_height_1, 8);
            translate([laptop_width_1 + gap*2, laptop_depth_1, 0]) rotate([0, 0, 180]) shelf(laptop_width_1, laptop_depth_1, laptop_height_1, 4, 250, shelf_height_1, shelf_height_1, 8);
        }
        translate([-.01, -.01, -shelf_height_1*2]) cube([wall_width+.02, 30, laptop_height_1]);
        translate([laptop_width_1+gap*2-wall_width-.01, -.01, -shelf_height_1*2]) cube([wall_width+.02, 30, laptop_height_1]);
    }

}

laptop_width_2 = 300;
laptop_depth_2 = 220;
laptop_height_2= 11;

module shelf_2() {
    translate([(laptop_width_1-laptop_width_2)/2, 0, 0]) {
        translate([gap, 0, -shelf_height_1]) cube([laptop_width_2, laptop_depth_2, laptop_height_2]);
        shelf(laptop_width_2, laptop_depth_2, laptop_height_2, wall_width, 250, shelf_height_1, shelf_height_1, 8);
        translate([laptop_width_2 + gap*2, laptop_depth_1, 0]) rotate([0, 0, 180]) shelf(laptop_width_2, laptop_depth_2, laptop_height_2, wall_width, 250, shelf_height_1, shelf_height_1, 8);
    }
}

shelf_1();
shelf_2();