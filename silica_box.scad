width = 198;
depth = 100;
gap = 1.2;
stand_height = 4;
wall_thickness = 2;
top_thickness = 3;
height = 10;
tolerance = .2;
top_height = 5;
top_support_thickness = 6;

module stand() {
    for (i = [0:gap*2:width]) {
        translate([i,0,0]) cube([gap, depth, stand_height]);
    }
    cube([width, wall_thickness, gap]);
    translate([0, depth-wall_thickness, 0]) cube([width, wall_thickness, gap]);
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

module box_top() {
    difference() {
        box(width + wall_thickness*2 + tolerance, depth+wall_thickness*2+tolerance, top_height+top_thickness);
        side_slots(width + wall_thickness + tolerance, depth+wall_thickness+tolerance, top_height, wall_thickness);
    }
    translate([wall_thickness,(depth+wall_thickness*2)/2-top_support_thickness/2,top_height]) cube([width+tolerance*2+.02, top_support_thickness, top_thickness]);
    translate([wall_thickness,(depth+wall_thickness*2)/4-top_support_thickness/2,top_height]) cube([width+tolerance*2+.02, top_support_thickness/2, top_thickness]);
    translate([wall_thickness,(depth+wall_thickness*2)/4*3-top_support_thickness/2,top_height]) cube([width+tolerance*2+.02, top_support_thickness/2, top_thickness]);
    for (i = [wall_thickness+gap:gap*2:width+wall_thickness]) {
        translate([i,wall_thickness-.01,top_height]) cube([gap, depth+2*tolerance+.02, top_thickness]);
    }
}

box_bottom();
//translate([-wall_thickness-tolerance/2,-wall_thickness-tolerance/2,stand_height+height-top_height+wall_thickness]) box_top();
translate([-wall_thickness, -5, top_height+top_thickness]) rotate([180,0,0]) box_top();

