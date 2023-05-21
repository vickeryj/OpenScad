wall_thickness = 1.5;
divider_thickness = 5;
wall_height = 10;
wall_length = 15;
u_length = 70;

module tee() {
    cube([2*wall_length+divider_thickness+2*wall_thickness, wall_thickness, wall_height]);
    translate([0, divider_thickness+wall_thickness, 0]) 
        cube([wall_length+wall_thickness, wall_thickness, wall_height]);
    translate([wall_length+divider_thickness+wall_thickness, divider_thickness+wall_thickness, 0]) 
        cube([wall_length+wall_thickness, wall_thickness, wall_height]);
    translate([wall_length, 2*wall_thickness+divider_thickness, 0]) 
        cube([wall_thickness, wall_length, wall_height]);
    translate([wall_length+divider_thickness+wall_thickness, 2*wall_thickness+divider_thickness, 0]) 
        cube([wall_thickness, wall_length, wall_height]);
    translate([0, 0, wall_height]) 
        cube([2*wall_length+divider_thickness+2*wall_thickness, wall_thickness*2+divider_thickness, wall_thickness]);
    translate([wall_length, 2*wall_thickness+divider_thickness, wall_height]) 
        cube([2*wall_thickness+divider_thickness, wall_length, wall_thickness]);
}

module you() {
    translate([-divider_thickness-wall_thickness, -wall_thickness, 0])
        cube([u_length+divider_thickness*2+wall_thickness*2, divider_thickness+wall_thickness*2, wall_thickness]);
    translate([-divider_thickness-wall_thickness, -wall_length, 0])
        cube([divider_thickness+wall_thickness*2, wall_length, wall_thickness]);
    translate([u_length-wall_thickness, -wall_length, 0])        
        cube([divider_thickness+wall_thickness*2, wall_length, wall_thickness]);
        
    translate([0, -wall_length, -wall_height])
        cube([wall_thickness, wall_length, wall_height]);
    translate([0, -wall_thickness, -wall_height])
        cube([u_length, wall_thickness, wall_height]);
    translate([u_length-wall_thickness, -wall_length, -wall_height])
        cube([wall_thickness, wall_length, wall_height]);
        
    translate([-divider_thickness-wall_thickness, -wall_length, -wall_height])
        cube([wall_thickness, wall_length, wall_height]);
    translate([u_length+divider_thickness, -wall_length, -wall_height])
        cube([wall_thickness, wall_length, wall_height]);
    translate([0, divider_thickness, -wall_height])
        cube([u_length, wall_thickness, wall_height]);


}

you();

module section() {
    translate([-u_length/2,0,0])
        cube([u_length*2, divider_thickness, 20]);
    translate([-divider_thickness, -wall_length, 0])
        cube([divider_thickness, wall_length*2, 20]);
    translate([u_length, -wall_length, 0])        
        cube([divider_thickness, wall_length*2, 20]);
}

//section();