include <BOSL2/std.scad>

shelf_thickness = 6.2;
shelf_depth = 30;
rack_inset = 10;
bottle_d = 103;
bottle_offset = [7, 20];
rack_width = 109;

$fn = 128;

for(i = [[0, 0], [rack_width, rack_width-rack_inset]]) {
    right(i[0]) cyl(d=shelf_thickness, h=shelf_depth, anchor=BOTTOM);
    right(i[1]) cuboid([rack_inset, shelf_thickness, shelf_depth], anchor=BOTTOM+LEFT);
}


difference() {
    right(rack_inset-bottle_offset[0]) back(bottle_offset[1]) {
        difference() {
            cyl(d=bottle_d, h=shelf_depth, anchor=BOTTOM+LEFT);
            right(shelf_thickness) down(.01) cyl(d=bottle_d-shelf_thickness*2, h=shelf_depth+.02, anchor=BOTTOM+LEFT);
        }
    }

    back(shelf_thickness/2) down(.02) cuboid(rack_width, anchor=BOTTOM+LEFT+FRONT);
    
    for (i = [1,2,3]) {
        right(rack_width/4*i) up(shelf_depth/2) xrot(90) #cyl(d=shelf_depth/2, h = bottle_d);
    }
}


