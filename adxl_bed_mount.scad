module stl() {
    import("/Users/vickeryj/Downloads/Ender-3-S1_ADXL345-Mount.STL");
}

include <BOSL2/std.scad>
include <BOSL2/rounding.scad>
include <BOSL2/screws.scad>

module filled_stl() {
    rotate([90,0,0]) stl();
    translate([28, -23, 0]) cube([23, 10, 5.5]);
}

difference() {
    filled_stl();
    translate([39,-16,0]) #screw_hole("M6,5.5", thread=true, anchor=BOTTOM, $fn=60);
}

