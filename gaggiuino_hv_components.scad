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

snubber_back = 18;
snubber_wall_height = 9;
snubber_w = 31.5;
snubber_d = 14;

ss_slot_width = 5;
ss_slot_height = 3;
ss_slot_length = 6;
ss_back = 11;

module base() { 
    cuboid([base_w,base_d,wall_thickness]);
    up(wall_thickness/2) fwd(base_d/2) left(base_w/2) {
        up(post_h/2) right(component_padding_w) back(component_back) {
            posts(dimmer_centers);
            right(component_padding_w*2+dimmer_centers[0]) {
                posts(relay_centers);
                right(component_padding_w*2+relay_centers[0]) posts(ps_centers);
            }
        }
        up(snubber_wall_height/2) right(snubber_w/3+wall_thickness/2) back(snubber_d/2+wall_thickness) // bottom left
        right(dimmer_centers[0]+component_padding_w*2)
        back(relay_centers[1]+snubber_d+snubber_back)
            snubber_slide();
            
        up(ss_slot_height/2) 
        right(+component_padding_w+dimmer_centers[0]/2)
        back(dimmer_centers[1]+component_back+ss_back)
            stepdown_slot();
    }
    

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
    rail_thickness = 1;
    top_rail_center = 5;
    
    //#cuboid([snubber_w/3*2, snubber_d, snubber_wall_height]);
    
    down(snubber_wall_height/2-rail_thickness/2) right(wall_thickness/2) {
        for(i = [-snubber_d/2+rail_thickness/2, snubber_d/2-rail_thickness/2]) {
            back(i) {
                for(j = [0, top_rail_center]) {
                    up(j) {
                        cuboid([snubber_w/3*2, rail_thickness, rail_thickness]);
                    }
                }
            }
        }
        
        back(snubber_d/2-rail_thickness/2) up(top_rail_center-rail_thickness/2) back(rail_thickness/2) xrot(90) zrot(90) prismoid(size1=[rail_thickness*1.5, snubber_w/3*2], size2=[0,snubber_w/3*2], h=rail_thickness);
        
        fwd(snubber_d/2+rail_thickness/2) up(top_rail_center-rail_thickness/2) back(rail_thickness/2) xrot(270) zrot(90) prismoid(size1=[rail_thickness*1.5, snubber_w/3*2], size2=[0,snubber_w/3*2], h=rail_thickness);
        
        
        
        for(i = [-snubber_d/2-wall_thickness/2, snubber_d/2+wall_thickness/2]) {
            up(snubber_wall_height/2-rail_thickness/2) back(i) 
                cuboid([snubber_w/3*2, wall_thickness, snubber_wall_height]);
        }
        up(snubber_wall_height/2-rail_thickness/2)
        left(snubber_w/3+wall_thickness/2)
        fwd(0)
            cuboid([wall_thickness, snubber_d+wall_thickness*2, snubber_wall_height]);
    }
}

//snubber_slide();

module snubber_test() {
    intersection() {
        base();
        left(15) back(6) cube([28, 22, 30]);
    }
}

module stepdown_slot() {
    cuboid([ss_slot_length, wall_thickness, ss_slot_height]);
    back(ss_slot_width) cuboid([ss_slot_length, wall_thickness, ss_slot_height]);
}


//stepdown_slot();

base();
