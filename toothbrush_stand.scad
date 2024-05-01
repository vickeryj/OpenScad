include <BOSL2/std.scad>

$fn = 64;

depth = 50;
height = 20;
width = 160;

module base() {
    cyl(d = depth, h = height, anchor = BOTTOM, rounding = 2);
    right(width/2) cuboid([width, depth, height], anchor = BOTTOM, rounding = 2);
    right(width) cyl(d = depth, h = height, anchor = BOTTOM, rounding = 2);
}

//base();

paste_tip_d = 15.3;
paste_end_d = 17.5;
paste_h = 17.5;

module paste_cutout() {
    cyl(d1 = paste_tip_d, d2 = paste_end_d, h = paste_h, anchor = BOTTOM, rounding = -2, edges = TOP);
}

brush_d = 18.1;
brush_h = 6;

module brush_cutout() {
    cyl(d = brush_d, h = brush_h, anchor = BOTTOM, rounding = -2, edges = TOP);
}

handle_w = 30.2;
handle_d = 32.2;
handle_h = 10;

module handle_cutout() {
    cuboid([handle_w, handle_d, handle_h], anchor = BOTTOM, rounding = -2, edges = TOP);
}

module magnet_hole() {
    cyl(h = 3.2, d = 6.4, anchor = BOTTOM);
}

paste_right = 0;
brush_right = 45;
handle_right = 55;
brush_2_right = 55;

module base_with_cutouts() {
    difference() {
        base();
        for (i = [1,3,5]) {
            up(.2) right (width/6*i) #magnet_hole();
        }
        right(paste_right) up(height - paste_h + .01) paste_cutout();
        right(brush_right) up(height - brush_h + .01) brush_cutout();
        right(brush_right + handle_right) up(height - handle_h + .01) handle_cutout();
        right(brush_right + handle_right + brush_2_right) up(height - brush_h + .01) brush_cutout();
    }
}

base_with_cutouts();