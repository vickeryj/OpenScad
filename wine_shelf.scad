include <BOSL2/std.scad>

shelf_thickness = 4;
tab_thickness = 10.4;
shelf_depth = 30;
rack_inset = 10;
bottle_d = 180;
bottle_offset = [7, 20];
rack_width = 109;
shelf_bottom = 18;

$fn = 128;

for(i = [[0, 0, [BACK+RIGHT]], [rack_width, rack_width-rack_inset, [BACK+LEFT]]]) {
    right(i[0]) cyl(d=tab_thickness, h=shelf_depth, anchor=BOTTOM);
    right(i[1]) cuboid([rack_inset, tab_thickness, shelf_depth], anchor=BOTTOM+LEFT, rounding=4,
    edges=i[2]);
}


difference() {
    right(bottle_d/4+rack_inset) back(bottle_d/2-shelf_bottom) {
        difference() {
            cyl(d=bottle_d, h=shelf_depth, anchor=BOTTOM);
            back(0) down(.01) cyl(d=bottle_d-shelf_thickness*2, h=shelf_depth+.02, anchor=BOTTOM);
            fwd(bottle_d/2-shelf_bottom-.01) down(.01) {
                for (left = [bottle_d/4+rack_inset, -bottle_d/4-rack_inset]) {
                    left(left) cuboid([rack_inset+tab_thickness/2, tab_thickness, shelf_depth+.02], anchor=BOTTOM);
                }
            }
        }
    }

    back(tab_thickness/2) down(.02) left(bottle_d/4-rack_inset) cuboid(bottle_d, anchor=BOTTOM+LEFT+FRONT);
    
    for (i = [1,2,3]) {
        right(rack_width/4*i) up(shelf_depth/2) xrot(90) cyl(d=shelf_depth/2, h = bottle_d);
    }
}


