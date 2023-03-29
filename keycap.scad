mx_height = 3.4;
mx_diameter = 6.4;

// 6.5 diameter too big, try 6.4
// 1.17, 4.1 cutouts appear too small, try 1.2, 4.2 -- very tight fit

module mx_mount(){
    circle_clip = .5;
    difference(){
        intersection() {
            cylinder( h=mx_height, d=mx_diameter, center=false, $fn=360 );
            translate( [0, 0, mx_height/2])cube([mx_diameter-circle_clip, mx_diameter-circle_clip, mx_height], center = true);
        }
        translate( [0, 0, mx_height/2]) {
            cube( size=[1.2,4.2,mx_height+.02], center = true);
            cube( size=[4.2,1.2,mx_height+.02], center = true);
        }
    }
}


module top() {
    $fn = 360;
    for (i = [0:.02:1]) {
        translate([0, 0, i]) cylinder( h=.1, d=6.1+(i)*4.4, center=true);
    }
    translate([0, 0, 1.5]) cube([2,2,1], center = true);
}

mx_mount();

translate([0,0,mx_height]) top();

//top();

