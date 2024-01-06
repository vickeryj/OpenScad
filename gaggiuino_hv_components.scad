include <BOSL2/std.scad>
include <BOSL2/screws.scad>

$slop=0.11;

base_w = 110;
base_d = 90;
wall_thickness = 2;
post_d = 6;
post_h = 4;
dimmer_centers = [21.5, 47];
relay_centers = [21, 28];
ps_centers = [24.5, 60];

component_padding_w = 7;
component_back = 14;

snubber_back = 10;

module base() { 
    cuboid([base_w,base_d,wall_thickness]);
    up(post_h/2+wall_thickness/2) fwd(base_d/2 - component_back) left(base_w/2 - component_padding_w) {
        posts(dimmer_centers);
        right(component_padding_w*2+dimmer_centers[0]) {
            posts(relay_centers);
            right(component_padding_w*2+relay_centers[0]) posts(ps_centers);
        }
    }
    back(snubber_back) up(wall_thickness/2) snubber_slide();

}

module post() {

    difference() {
        cyl(d = post_d, h = post_h);
        screw_hole("M3,4", thread = true);
    }
}

module posts(centers) {
    for(i = [0, centers[0]]) {
        right(i) post();
        for(j = [0, centers[1]]) {
            right(i) back(j) post();
        }
    }
}

module snubber_slide() {
    snubber_w = 31.5;
    snubber_d = 14;
    rail_thickness = 1.5;
    top_rail_center = 5;
    wall_height = top_rail_center + 4;
    
    up(rail_thickness/2) {
        for(i = [rail_thickness/2, snubber_d-rail_thickness/2]) {
            back(i) {
                for(j = [0, top_rail_center]) {
                    up(j) {
                        cuboid([snubber_w/3*2, rail_thickness, rail_thickness]);
                    }
                }
            }
        }
        for(i = [-wall_thickness/2, snubber_d+wall_thickness/2]) {
            up(wall_height/2-rail_thickness/2) back(i) 
                cuboid([snubber_w/3*2, wall_thickness, wall_height]);
        }
        up(wall_height/2-rail_thickness/2)
        left(snubber_w/3+wall_thickness/2)
        back(snubber_d/2)
            cuboid([wall_thickness, snubber_d+wall_thickness*2, wall_height]);
    }
}

intersection() {
    base();
    left(15) back(6) cube([28, 22, 30]);
}

//base();
