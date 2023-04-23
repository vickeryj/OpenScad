width = 78.67;
depth = 82.21;
bar_thickness = 2;
bar_space = 3;

module insert() {
    for (i = [0:bar_space+bar_thickness:depth - bar_space - bar_thickness]) {
        if (i < width - bar_space - bar_thickness) {
            translate([bar_space + i, 0, 0]) cube([bar_thickness, depth, bar_thickness]);
        }

        translate([0, bar_space + i, 0]) cube([width, bar_thickness, bar_thickness]);
    }
}

insert();


basket_width = 74.8;
basket_depth = 77.3;
basket_bar_thickness = 2.7;

module basket() {
    //cube([basket_width, basket_depth, 2]);
    translate([0, 0, 0]) cube([5.05, bar_thickness, 20]);
    translate([0, 0, 0]) cube([bar_thickness, 4, 20]);
    translate([5+5, 0, 0]) cube([bar_thickness, bar_thickness, 20]);
    for (i = [8:8+bar_thickness: width - 10 - bar_thickness]) {
        translate([5+5+i, 0, 0]) cube([bar_thickness, bar_thickness, 20]);
    }
    translate([width-bar_space, 0, 0]) cube([bar_thickness, bar_thickness, 20]);
}

//color("red") translate([bar_space, bar_space, 0]) basket();