include <BOSL2/std.scad>
include <BOSL2/rounding.scad>
include <BOSL2/screws.scad>

interior_width = 100;
interior_height = 240;
interior_depth = 220;
wall_thickness = 2;

bottom_height = 50;

$fn = 60;

module box(height) {
    box = square([interior_width+wall_thickness*2, interior_depth+wall_thickness*2]);
    rbox = round_corners(box, method="smooth", cut=4, $fn=12);


    difference() {
        offset_sweep(rbox, height=height, check_valid=false, steps=22,
                     bottom=os_circle(r=3));
                     
        up(wall_thickness)
            offset_sweep(offset(rbox, r=-wall_thickness, closed=true,check_valid=false),
                     height=height, steps=22, check_valid=false,
                     bottom=os_circle(r=4), top=os_circle(r=-1,extra=1));

    }
}

lip_thickness = 2;
lip_height = 10;
lip_start = bottom_height - lip_height/2;

module lip() {

    lip = square([interior_width+wall_thickness*2+lip_thickness*2, interior_depth+wall_thickness*2+lip_thickness*2]);
    rlip = round_corners(lip, method="smooth", cut=4, $fn=12);

    translate([-lip_thickness,-lip_thickness,lip_start]) {
        difference() {
            offset_sweep(rlip, height=lip_height, check_valid=false, steps=22,
                         bottom=os_circle(r=3));
            down(0.01)
                offset_sweep(offset(rlip, r=-lip_thickness, closed=true,check_valid=false),
                     height=lip_height+.02, steps=22, check_valid=false);
        }
    }
}

filament_hole_length = 25;
filament_hole_d = 20;

module filament_hole() {
    diff()
        cylinder(h=filament_hole_length, r=filament_hole_d/2)
        attach(BOTTOM)
            screw_hole("M10", length=filament_hole_length+.01, thread=true, anchor=TOP);
}

reinforcement_size = filament_hole_d*3;

module box_top() {
    
    reinforcement = square(reinforcement_size);

    box(interior_height-bottom_height);
    up((interior_height-bottom_height)/2-filament_hole_d)
        right(interior_width/2-reinforcement_size/2)
        back(wall_thickness*2) 
        xrot(90) offset_sweep(reinforcement, height=3*wall_thickness, check_valid=false, steps=22,
                     bottom=os_circle(r=3), top=os_circle(r=3));
}

module box_bottom() {
    box(bottom_height);
    lip();
}

module box_top_with_filament_hole() {
    difference() { 
        box_top();
        up((interior_height-bottom_height)/2)
            right(interior_width/2)
            fwd(filament_hole_length/2-3)
            xrot(-45)
            cylinder(h = filament_hole_length, r = 5);
    }
    up((interior_height-bottom_height)/2)
        right(interior_width/2)
        fwd(filament_hole_length/2-3)
        xrot(-45)
    filament_hole();
}

//box_bottom();
//translate([150, 0, 0]) box_top_with_filament_hole();
filament_hole();
