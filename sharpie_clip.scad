sharpie_max_diam = 12;
sharpie_min_diam = 11.7;
clip_width = 17;
clip_depth = 13;
clip_height = 15;

difference() {
    translate([-clip_width/2, -clip_depth/2, 0]) cube([clip_width, clip_depth, clip_height]);

    translate([0,-sharpie_max_diam/3,-.01]) cylinder(h = clip_height+.02, d1 = sharpie_min_diam, d2 = sharpie_max_diam);
}