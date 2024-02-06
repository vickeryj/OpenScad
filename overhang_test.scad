$fn=120;

size = 50;
scale_factor = .6;

difference() {
    cylinder(h = size/4, r1 = size*scale_factor, r2 = size);
    translate([0,0,1]) cylinder(h = size/4, r1 = size*scale_factor-2, r2 = size-2);
    translate([0,0,-1]) cylinder(h = size/4+1, r = size*scale_factor-10);
}