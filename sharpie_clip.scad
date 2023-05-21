sharpie_max_diam = 12;
sharpie_min_diam = 11.7;
clip_width = 17;
clip_depth = 13;
clip_height = 15;

$fn = 120;

module clip() {
    difference() {
        translate([-clip_width/2, -clip_depth/2, 0]) cube([clip_width, clip_depth, clip_height]);

        translate([0,-sharpie_max_diam/3,-.01]) cylinder(h = clip_height+.02, d1 = sharpie_min_diam, d2 = sharpie_max_diam);
    }
}

clip_spacing = 12;

clip();
translate([clip_width + clip_spacing, 0, 0]) clip();

translate([-clip_width/2,clip_depth/2,0]) rotate([90,0,0]) cube([clip_width*2+clip_spacing, clip_height, 2]);