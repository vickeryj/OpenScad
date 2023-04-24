width = 198;
depth = 100;
gap = 1.2;
stand_height = 4;
wall_thickness = 2;
height = 10;
tolerance = .3;
top_height = 5;
top_support_thickness = 6;

module stand() {
    for (i = [0:gap*2:width]) {
        translate([i,0,0]) cube([gap, depth, stand_height]);
    }
}

module box(width = width, depth = depth, height = height) {
    translate([0,0,0]) cube([width, wall_thickness, height]);
    translate([width-wall_thickness,0,0]) cube([wall_thickness, depth, height]);
    translate([0,depth-wall_thickness,0]) cube([width, wall_thickness, height]);
    translate([0,0,0]) cube([wall_thickness, depth, height]);
}

module side_slots(width = width, depth = depth, height = height, inset = 0) {
    for (i = [inset+gap*2:gap*2:width-gap*2]) {
        translate([i, -0.01, gap]) cube([gap, wall_thickness+.02, height - gap*2]);
        translate([i, depth-wall_thickness-.01+inset, gap]) cube([gap, wall_thickness+.02, height - gap*2]);
    }
    for (i = [inset+gap*2:gap*2:depth-gap*2]) {
        translate([-.01, i, gap]) cube([wall_thickness+.02, gap, height - gap*2]);
        translate([width-wall_thickness-.01+inset, i, gap]) cube([wall_thickness+.02, gap, height - gap*2]);
    }
}

module box_bottom() {
    stand();
    translate([0,(depth-wall_thickness)/2,0]) cube([width, wall_thickness, height]);
    difference() {
        translate([0,0,stand_height-.01]) box();
        translate([0,0,stand_height-.01]) side_slots();
    }
}

module top_support() {
    
}

module box_top() {
    difference() {
        box(width + wall_thickness*2 + tolerance, depth+wall_thickness*2+tolerance, top_height);
        side_slots(width + wall_thickness + tolerance, depth+wall_thickness+tolerance, top_height, wall_thickness);
    }
    translate([wall_thickness,(depth+wall_thickness*2)/2-top_support_thickness/2,top_height - wall_thickness]) cube([width+tolerance*2+.02, top_support_thickness, wall_thickness]);
    for (i = [wall_thickness+gap:gap*2:width]) {
        translate([i,wall_thickness-.01,top_height - wall_thickness]) cube([gap, depth+2*tolerance+.02, wall_thickness]);
    }
}

box_bottom();
//translate([-wall_thickness-tolerance/2,-wall_thickness-tolerance/2,stand_height+height-top_height+wall_thickness]) box_top();
translate([0, -10, top_height]) rotate([180,0,0]) box_top();

