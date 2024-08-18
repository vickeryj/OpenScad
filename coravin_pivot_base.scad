include <BOSL2/std.scad>

$fn = 64;

slot_d = 30;
slot_top = 70;
slot_angle = 15;
wall_thickness = 3;
slot_bottom = 20;

base_w = 70;

module slot() {
    difference() {
        xrot(slot_angle) {
            difference() {
                cyl(d=slot_d+wall_thickness*2, h = slot_top, rounding = 1);
                cyl(d=slot_d, h = slot_top+.02, rounding = -1);
               back(wall_thickness+slot_d/2) up(wall_thickness+slot_bottom) cuboid([slot_d+wall_thickness*2, slot_d+wall_thickness*2, slot_top]);
            }
        }
        down(slot_bottom/2+wall_thickness/2+wall_thickness+slot_bottom) cuboid([slot_d+wall_thickness*2, base_w, slot_bottom]);
    }
}

module base() {
    cuboid([slot_d+wall_thickness*2+2, base_w, wall_thickness], rounding = 1);

}

slot();
down(wall_thickness*2+slot_bottom) base();