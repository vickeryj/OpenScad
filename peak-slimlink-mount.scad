module stl() {
    import("/Users/vickeryj/Code/OpenSCAD/peak-slimlink-mount.stl");
}

module tripod_stl() {
    import("/Users/vickeryj/Code/OpenSCAD/holder_lower1.stl");
}

include <BOSL2/std.scad>
include <BOSL2/rounding.scad>
include <BOSL2/screws.scad>

$fn = 24;
$slop=0.08;

module plate() {
    difference() {
        rotate([90,0,0]) stl();
        for (coords = [[15,-20], [41,-20], [15,-35], [41,-35]]) {
            translate([coords[0], coords[1], -1]) #screw_hole("M3", length=2, counterbore=4, thread=false, head="socket", anchor=BOTTOM);
        }
    }
}

module tripod_connector() {
    
    module filled_in() {
        left(28) fwd(100) up(12.5) yrot(90) tripod_stl();
        left(53) fwd(51) cube([50, 60, 8]);
    }
    
    difference() {
        filled_in();
        left(54) fwd(51) up(14) cube([52, 60, 12]);
        left(31) fwd(58) up(25) cube(6);
        fwd(5) left(56) for (coords = [[15,-20], [41,-20], [15,-35], [41,-35]]) {
            translate([coords[0], coords[1], -1]) {
                screw_hole("M3", length=12, counterbore=4, thread=false, head="socket", anchor=BOTTOM);
                up(9) nut_trap_inline(2, "M3", anchor=TOP);
            }
        }
    }
    
    
}

//fwd(5) yrot(180) plate();
tripod_connector();
