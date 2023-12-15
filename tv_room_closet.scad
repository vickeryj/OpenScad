include <BOSL2/std.scad>

closet_width = 570;
closet_depth= 230;
bar_height = 620;
shelf_depth = 160;
above_shelf_height = 305;
bar_plus_shelf_height = 35;
closet_height = bar_height+above_shelf_height+bar_plus_shelf_height;
wall_thickness = 10;
door_width = 270;

module closet_shell() {

    difference() {
        cube([closet_width+wall_thickness*2, closet_depth, closet_height]);
        down(wall_thickness)
            fwd(wall_thickness)
            right(wall_thickness)
            cube([closet_width, closet_depth, closet_height]);
    }
}

module doors() {
    back(closet_depth-wall_thickness-.01) {
        right((closet_width - door_width*2)/2) color("red") cube([door_width, wall_thickness, closet_height-.01]);
        right(closet_width - door_width) color("orange") cube([door_width, wall_thickness, closet_height-.01]);
    }
}

module shelf_bar() {
    up(bar_height) right(wall_thickness) back(closet_depth-shelf_depth) cube([closet_width, shelf_depth, bar_plus_shelf_height]);
}

module hdx_52() {
    //$36
    shelf_gap = 144;
    unit_height = 520;
    unit_width = 280;
    unit_depth = 150;
    //color("yellow", 0.5) cube([unit_width, unit_depth, unit_height]);
    shelf_height = (unit_height - 3*shelf_gap)/4;
    for(i = [shelf_gap: shelf_height + shelf_gap: unit_height]) {
        up(i)
        cube([unit_width, unit_depth, shelf_height]);
    }
}

module hdx_36_18_74() {
    //$65
    cube([360, 180, 740]);
}

module 17g() {
    cube([270,180, 125]);
}

module 27g() {
    cube([200, 290, 155]);
}

module toolchest() {
    cube([265,180,330]);
}

closet_shell();
doors();
shelf_bar();

back(closet_depth - 180 - wall_thickness) right(wall_thickness*2) toolchest();

back(closet_depth - 150) {
    // hdx_52();
    right(closet_width - 280 + wall_thickness*2) hdx_52();
}
//back(closet_depth - 180) hdx_36_18_74();

up(bar_height+bar_plus_shelf_height) back(closet_depth - 180 - wall_thickness) {
    right(15) 17g();
    right(15) up(135) 17g();
}

right(closet_width - 280 + wall_thickness*2) back(closet_depth - 180 - wall_thickness)  17g();
