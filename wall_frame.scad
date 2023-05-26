include <BOSL2/std.scad>
include <BOSL2/rounding.scad>

picture_width = 154;
picture_depth = 115;

back_wall_width = 4;
back_wall_thickness = 3;

hanger_width = 20;
hanger_depth = 10;

picture_slot_thickness = .2;

slider_cut_depth = 2;
slider_cut_thickness = 2;

frame_width = 10;
front_thickness = 2;
overlap = 3;
tolerance = .1;
slider_rail_depth = slider_cut_depth;
slider_rail_thickness = slider_cut_thickness - tolerance*2;


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

module slider_cuts() {
    cut_length = picture_depth+picture_slot_thickness*2+.02;
    translate([-picture_slot_thickness-.01, cut_length/2-picture_slot_thickness-.01, back_wall_thickness/2])
        prismoid(size1=[slider_cut_thickness,cut_length], size2=[0,cut_length], h=slider_cut_depth, orient=RIGHT);

    translate([picture_width+picture_slot_thickness+.01, cut_length/2-picture_slot_thickness-.01, back_wall_thickness/2])
        prismoid(size1=[slider_cut_thickness,cut_length], size2=[0,cut_length], h=slider_cut_depth, orient=LEFT);
}

module full_back() {
    difference() {
        back_frame();
        hanger_cutout();
        slider_cuts();
    }
}

module front_frame() {
    frame(picture_width + picture_slot_thickness * 2 + overlap * 2,
          picture_depth + picture_slot_thickness * 2 + overlap * 2,
          front_thickness, frame_width);
    
    //rail guides    
    rail_guide_height = back_wall_thickness+picture_slot_thickness;
    translate([overlap/2-tolerance, overlap, -rail_guide_height+tolerance])
        cube([overlap/2, picture_depth+picture_slot_thickness*2, rail_guide_height-tolerance]);                
    translate([picture_width+overlap+picture_slot_thickness*2+tolerance, overlap, -rail_guide_height+tolerance])
        cube([overlap/2, picture_depth+picture_slot_thickness*2, rail_guide_height-tolerance]);
    translate([overlap/2-tolerance,picture_depth+overlap+picture_slot_thickness*2,-rail_guide_height+tolerance])
        cube([picture_width+overlap+picture_slot_thickness*2+tolerance*2, overlap/2, rail_guide_height-tolerance]);
    
    //rails
    rail_length = picture_depth+picture_slot_thickness*2;
    translate([overlap-tolerance, rail_length/2+overlap, -back_wall_thickness/2-picture_slot_thickness])
        prismoid(size1=[slider_cut_thickness,rail_length], size2=[0,rail_length], h=slider_cut_depth, orient=RIGHT);    
    translate([picture_width+overlap+picture_slot_thickness*2+tolerance, rail_length/2+overlap,  -back_wall_thickness/2-picture_slot_thickness])
        prismoid(size1=[slider_cut_thickness,rail_length], size2=[0,rail_length], h=slider_cut_depth, orient=LEFT);
}

full_back();

//front_frame();

//translate([-picture_slot_thickness-overlap, -picture_slot_thickness-overlap, back_wall_thickness+picture_slot_thickness]) front_frame();

rotate([180,0,0]) translate([0,20,0]) front_frame();



