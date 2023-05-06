//wheel_rise_height = 45;
slot_width = 23;
slot_depth = 58;
wheel_diameter = 45;
total_wheel_riser_height = 95;
total_wheel_height = 42;
$fn = 120;
feet_height = 66;


module wheel_riser() {
    difference() {
        scale([.7,1,1])
            cylinder(h = total_wheel_riser_height, d2 = max(slot_width, slot_depth) + 20, d1 = max(slot_width, slot_depth));
            
        translate([-slot_width/2,-slot_depth/2,total_wheel_riser_height - total_wheel_height+wheel_diameter/2])
            cube([slot_width, slot_depth, total_wheel_riser_height]);

        translate([-slot_width/2,0,total_wheel_riser_height-total_wheel_height+wheel_diameter/2]) 
            rotate([90, 0, 90]) cylinder(h = slot_width, d = wheel_diameter);
            
    }
}

foot_lift = total_wheel_riser_height - feet_height + 19.4;
foot_hole_top_diameter = 52;
foot_hole_bottom_diameter = 46;
foot_hole_height = 20;
top_wall_thickness = 4;

module foot_riser() {

    difference() {
        translate([foot_hole_top_diameter/2, foot_hole_top_diameter/2, 0])
            cylinder(h = foot_lift+foot_hole_height, d2 = foot_hole_top_diameter+top_wall_thickness, d1 = foot_hole_bottom_diameter);

        translate([foot_hole_top_diameter/2, foot_hole_top_diameter/2, foot_lift+.01])
            cylinder(h = foot_hole_height, d2 = foot_hole_top_diameter, d1 = foot_hole_bottom_diameter);
    }
}

foot_riser();