include <BOSL2/std.scad>
include <BOSL2/rounding.scad>
include <BOSL2/screws.scad>

$slop=0.11; //trident

plug_r = 12;
plug_l = 16;
plug_extra = plug_r/5;
plug_cut = 14.5;

module full_plug() {
    xrot(270) screw("5/8", thread="fine", length = plug_l, thread_len=plug_l-plug_extra-2);
    back(plug_l/2) intersection() {
        left(plug_r) down(plug_r) fwd(plug_extra) cube(2*plug_r);
        sphere(r=plug_r);
    }
}

intersection() {
    down(plug_cut/2)
    fwd(plug_l/2)
    left(plug_r)
    
    cube([plug_r*2, plug_l+plug_r, plug_cut]);
    full_plug();
 }

