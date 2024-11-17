include <BOSL2/std.scad>

height = 31;
outer = 22.9;
inner = 18.3;

$fn = 120;

difference() {
    tube(h=height+0.02, od=outer, id=inner);

    xrot(90) cyl(h = outer, r = inner/2-1);
}