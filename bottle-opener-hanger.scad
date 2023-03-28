$fn = 60;

module all_together() {

    back_width = 43;
    back_depth = 3.6;
    back_height = 20;    
    shelf_width = 30;
    shelf_depth = 10;
    shelf_thickness = 4;
    opener_rest_depth = 7;
        
    module magnet_hole() {
        rotate([90, 0, 0]) 
        cylinder(h = 2.6, d = 5.2, center = false);
    }
    
    module back() {
        difference() {
            cube([back_width, back_depth, back_height]);
            for (i = [-1:1:1]) {            
                translate([back_width/3*(i+1)+7.1, back_depth+.01, back_height/4])
                    magnet_hole();
                translate([back_width/3*(i+1)+7.1, back_depth+.01, back_height/4*3])
                    magnet_hole();
            }
        }
    }
    
    module shelf() {
        difference() {
            translate([(back_width - shelf_width)/2, -shelf_depth - .01, 0]) cube([shelf_width, shelf_depth, shelf_thickness]);
        
            translate([(back_width-shelf_width)/2-.01, -shelf_depth/2, shelf_thickness+1]) rotate([0, 90, 0]) cylinder(h = shelf_width+.02, r = shelf_depth/2 - 1);
        }
        
            translate([(back_width - shelf_width)/2, -shelf_depth+(shelf_depth-opener_rest_depth)/2, 1]) cube([shelf_width, opener_rest_depth, 2]);
    }
    
    translate([0, 0, -5]) back();
    shelf();

}

 
//rotate([-90, 0, 0]) all_together();
all_together();

//printed nicely at .2 faster profile
//magnet holes were very tight, had to push them in with pliers
//6 magnets wasn't enough to hold up the cast iron on, but the steel one held