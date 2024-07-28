include <BOSL2/std.scad>

height_diff = 3.83;
outer = 20;
inner = 5;

$fn = 120;

tube(h=height_diff, od=outer, id = inner);