include <BOSL2/std.scad>
include <BOSL2/rounding.scad>

picture_width = 100;
picture_depth = 80;

back_wall_width = 3;
back_wall_thickness = 2;

hanger_width = 20;
hanger_depth = 10;

picture_slot_thickness = .6;

module frame(width, depth, height, thickness) {
    cube([thickness, depth, height]);
    cube([width, thickness, height]);
    translate([width - thickness, 0, 0]) cube([thickness, depth, height]);
    translate([0, depth-thickness, 0]) cube([width, thickness, height]);
}

module back_frame() {

    //square
    frame(picture_width, picture_depth, back_wall_thickness, back_wall_width);

    //diagonal
    picture_diagonal = sqrt(picture_width^2 + picture_depth^2);
    picture_angle = atan(picture_depth/picture_width);
    translate([back_wall_width/2,back_wall_width,0])
    rotate([0,0,picture_angle-90])
    cube([back_wall_width, picture_diagonal-2*back_wall_width, back_wall_thickness]);

    //hanger
    translate([picture_width/2 - hanger_width/2, picture_depth-back_wall_width-hanger_depth, 0])
    cube([hanger_width, hanger_depth, back_wall_thickness]);
    
    //picture slot
    translate([-picture_slot_thickness, -picture_slot_thickness, 0])
    frame(picture_width + picture_slot_thickness*2, picture_depth + picture_slot_thickness*2, back_wall_thickness+picture_slot_thickness, picture_slot_thickness);  
    
}

module hanger_cutout() {
    padding = .5;
    translate([picture_width/2,picture_depth-back_wall_width,-.01]) rotate([0,0,-135]) linear_extrude(height = back_wall_thickness-padding*2) right_triangle(hanger_width/2);
    
    translate([picture_width/2,picture_depth-back_wall_width+1.6,padding]) rotate([0,0,-135]) linear_extrude(height = back_wall_thickness-padding*2) right_triangle(hanger_width/1.6);
}

slider_cut_depth = 1;
slider_cut_thickness = 1;

module slider_cuts() {
    translate([-picture_slot_thickness-.01, -picture_slot_thickness-.01, (back_wall_thickness+picture_slot_thickness)/2-slider_cut_thickness/2])
        cube([slider_cut_depth, picture_depth+picture_slot_thickness*2+.02, slider_cut_thickness]);
        
    translate([picture_width+picture_slot_thickness-slider_cut_depth+.01, -picture_slot_thickness-.01, (back_wall_thickness+picture_slot_thickness)/2-slider_cut_thickness/2])
        cube([slider_cut_depth, picture_depth+picture_slot_thickness*2+.02, slider_cut_thickness]);
}

module full_back() {
    difference() {
        back_frame();
        hanger_cutout();
        slider_cuts();
    }
}

full_back();

frame_width = 10;
front_thickness = 3;
overlap = 3;
tolerance = .2;
slider_rail_depth = slider_cut_depth - tolerance;
slider_rail_thickness = slider_cut_thickness - tolerance;

module front_frame() {
    frame(picture_width + picture_slot_thickness * 2 + overlap * 2,
          picture_depth + picture_slot_thickness * 2 + overlap * 2,
          front_thickness, frame_width);
          
    //rails
    //rail_offset = 3;
    rail_guide_height = (back_wall_thickness+picture_slot_thickness)/2+slider_cut_thickness/2;


    translate([overlap/2-tolerance, overlap, -rail_guide_height])
        cube([overlap/2, picture_depth+picture_slot_thickness*2, rail_guide_height]);
    translate([overlap,0, -rail_guide_height+tolerance/2])
        cube([slider_rail_depth, picture_depth+picture_slot_thickness*2, slider_rail_thickness]);
    //translate([overlap+slider_rail_depth, overlap+slider_rail_depth, -slider_rail_thickness])
        //cube([slider_rail_depth, picture_depth, slider_rail_thickness]);
}

translate([-picture_slot_thickness-overlap, -picture_slot_thickness-overlap, back_wall_thickness+picture_slot_thickness]) front_frame();


