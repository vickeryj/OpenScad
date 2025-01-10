include <BOSL2/std.scad>

$fn = 64;

slot_d = 34.645;
wall_thickness = 3;
slot_top = 45;

base_w = 70;


module slot() {
    up(slot_top/2 - .01)
    difference() {

                cyl(d=slot_d+wall_thickness*2, h = slot_top, rounding = 1);
                cyl(d=slot_d, h = slot_top+.02, rounding = -1);
    }
}

module base() {
    cuboid([slot_d+wall_thickness*2+2, base_w, wall_thickness], rounding = 1);

}

slot();
base();