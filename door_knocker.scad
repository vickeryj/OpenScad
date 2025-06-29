include <BOSL2/std.scad>
include <BOSL2/rounding.scad>

peephole_cutout_d = 14;
peephole_delta_top = 35;
door_hole_d = 25;
door_thickness = 44.5;
plate_height = 165;
thickness = 1.5;


module outside_plate() {

    width = 80;
    
    difference() {
        cuboid([width, thickness, plate_height], rounding=1, edges=[FRONT]);
        up(plate_height/2) down(peephole_delta_top) xrot(90) cyl(d=peephole_cutout_d, h=thickness+.02);
    }

}

module interior_tube() {

    interior_ring_d = 35;
    interior_peephole_outder_d = 18;
    
    module tube() {
        back(door_thickness/2+thickness/2) xrot(90) cyl(d=interior_ring_d, h=thickness, rounding1=.5);
        xrot(90) cyl(d=door_hole_d, h = door_thickness);
    }

    difference() {
        tube();
        xrot(90) cyl(d=peephole_cutout_d, h = door_thickness+thickness+.02);
        back(door_thickness/2+thickness/2+.01) xrot(90) cyl(d=interior_peephole_outder_d, h = thickness);
    }
    
    

}

//display
//outside_plate();
//back(50) up(plate_height/2) down(peephole_delta_top) interior_tube();

//printing
$fn=64;
outside_plate();
right(100) fwd(door_thickness/2+thickness) yrot(90) interior_tube();