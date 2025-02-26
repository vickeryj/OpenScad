include <BOSL2/std.scad>

margin = .3;
bumper_width = 20;
shelf_depth = 260;
shelf_height = 15.9;

module shelf_end() {
    cuboid([bumper_width+margin*2, shelf_depth+margin*2, shelf_height+margin*2]);
}

bumper_thickness = 2.5;

module bumper() {
    difference() {
        cuboid([bumper_thickness+bumper_width+margin*2, bumper_thickness*2+shelf_depth+margin*2, bumper_thickness*2+shelf_height+margin*2], rounding=2, $fn=32);
        translate([bumper_thickness*2, 0, 0])
            shelf_end();
    }
}

bumper();