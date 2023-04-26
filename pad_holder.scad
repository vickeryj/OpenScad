slot_gap = 12;
wall_width = 4;
slots = 3;
depth = wall_width*slots+1+slot_gap*(slots);
length = 170;
height = 50;
post_width = 8;


triangle_leg = sqrt(((2*height)^2)/2);
triangle_base = sqrt(2*triangle_leg^2);

module triangle() {
    triangle_points =[[0,0],[triangle_leg,0],[0,triangle_leg],[post_width,post_width],[triangle_leg-post_width*2,post_width],[post_width,triangle_leg-post_width*2]];
    triangle_paths =[[0,1,2],[3,4,5]];
    height_to_point = sqrt(2*(100*100))/2;
    translate([0,0,height]) rotate([0,135,0]) rotate([0,-90,-90]) linear_extrude(wall_width) polygon(triangle_points,triangle_paths,post_width);
}

for (i = [triangle_base/2:triangle_base/3:length]) {
    for (j = [0:slot_gap+wall_width:depth + 1]) {
        translate([i,j,0]) triangle();
     }
 }
 
 for (i = [0:(length+22)/5:length+22]) {
     translate([i, 0, 0]) cube([post_width, depth, wall_width]);
 }