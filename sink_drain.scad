include <BOSL2/std.scad>

hole_diameter = 15.54;
hole_height = 1.2;
hole_slop = 0.2;
plug_diameter = 18;
plug_height = 3.5;
plug_taper = 3;
plug_squish = 2;
handle_height = 22;
handle_top_height = 3;
handle_top_d = plug_diameter + 3;
total_height = hole_height + plug_height + handle_height + handle_top_height;

$fn = 120;

module solid() {
    down(plug_height/2) cyl(h = plug_height, d1 = hole_diameter - plug_taper, d2 = hole_diameter + plug_squish);

    up(hole_height/2) cyl(h = hole_height, d = hole_diameter - hole_slop);

    up(handle_height/2 + hole_height) cyl(h = handle_height, d = plug_diameter, chamfer1=1.2);

    up(handle_height + hole_height + handle_top_height/2) cyl(h = handle_top_height, d = handle_top_d, rounding=1);
}

center_hole_d = 9;
side_hole_d = 4;

difference() {
    solid();
    up(total_height/2 - plug_height - .01) cyl(h = total_height + .03, d = center_hole_d, rounding2=-3);
    
    for (up = [1,2,4.3]) {
        up(total_height/5*up) { 
            xrot(90) cyl(h = 2* plug_diameter, d = side_hole_d);
            yrot(90) cyl(h = 2* plug_diameter, d = side_hole_d);
        }
     }
    
}