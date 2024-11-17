include <BOSL2/std.scad>

height = 25;
outer = 22.7;
inner = 18.7;

$fn = 120;

difference() {
    tube(h=height+0.02, od=outer, id=inner);

    xrot(90) cyl(h = outer, r = inner/2-1);
}