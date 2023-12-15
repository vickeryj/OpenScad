include <BOSL2/std.scad>

holder_height = 75;
inside_diameter = 88;
wall_thickness = 2;

$fn = 120;


module holder() {
    up(holder_height/2) difference() {
        cyl(h=holder_height, d = inside_diameter + wall_thickness*2);
        up(wall_thickness) cyl(h=holder_height, d = inside_diameter, chamfer1=5);
    }

    left(inside_diameter/2) fwd(wall_thickness) up(wall_thickness/2) cuboid([inside_diameter,inside_diameter,wall_thickness]);
    back(inside_diameter/2) up(wall_thickness/2) right(wall_thickness) cuboid([inside_diameter,inside_diameter,wall_thickness]);

    back(inside_diameter/2) left(inside_diameter/2) up(wall_thickness/2) cuboid([inside_diameter,inside_diameter,wall_thickness]);
 }
 
 
 
 cutout_d = 20;
 
 module cutouts() {
    for (up = [1,3]) {
        up(holder_height/4*up) { 
            xrot(90) cyl(h = 2* inside_diameter, d = cutout_d);
            yrot(90) cyl(h = 2* inside_diameter, d = cutout_d);
        }
     }
     cyl(h = wall_thickness*4, d = inside_diameter/2);
 }
 
 difference() {
     holder();
     cutouts();
 }