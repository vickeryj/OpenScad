front_width = 62;
front_depth = 25;
side_width = 14;
side_depth = 36;
space_height = 61;

module space() {
    color("blue", 0.1) {
        cube([front_width, front_depth, space_height]);
        translate([0, -side_depth, 0])
        cube([side_width, side_depth, space_height]);
    }
}
//space();

side_shelf_width = 36;
side_shelf_depth = 14;

module side_shelf() {
    cube([side_shelf_width, side_shelf_depth, 1]);
}

shelf_gap = 12;

module side_shelves() {
    rotate([0, 0, 90])
    translate([-side_shelf_width, -side_shelf_depth, 0])
    for(i = [shelf_gap : shelf_gap : shelf_gap * 4]) {
        translate([0, 0, i])
        side_shelf();
    }

}

color("gray", 1)
side_shelves();

module front_shelf(width, depth) {
    cube([width, depth, 1]);
}

module front_shelves(width, depth) {
    for(i = [3*shelf_gap : shelf_gap : 4*shelf_gap]) {
        translate([0, 0, i])
        front_shelf(width, depth);
    }
}

front_shelf_width = 60;


color("orange", 1) front_shelves(front_shelf_width, 24);

translate([0, 0, shelf_gap]) front_shelf(24, 24);
translate([0, 0, shelf_gap*2]) front_shelf(24, 24);

translate([ front_shelf_width - 12, 0, shelf_gap ]) front_shelf(12, 24);
translate([ front_shelf_width - 12, 0, shelf_gap*2 ]) front_shelf(12, 24);
    
 
 module workspace() {
     translate([side_width+10, 0, 0])
     color("blue", .2) cube([24, front_depth, 33]);
 }
 
//workspace();


module post(h = 54) {
    cylinder(h =h, r = .5, center = false);
}

color("gray") post();
color("green", .5) translate([24, 0, 0]) post(34);
color("gray", 1) translate([0, -side_depth, 0]) post();
color("gray", 1) translate([side_width, -side_depth, 0]) post();
color("gray") translate([0, front_depth, 0]) post();
color("green", .5) translate([24, front_depth, 0]) post(34);
color("green", .5) translate([front_shelf_width-12, front_depth, 0]) post(34);
translate([front_shelf_width, front_depth, 0]) post();
translate([front_shelf_width, 0, 0]) post();
color("green", .5)translate([front_shelf_width-12, 0, 0]) post(34);
