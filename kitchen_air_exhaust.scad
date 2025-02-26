include <BOSL2/std.scad>

inset_width = 195;
inset_height = 4.9;
inset_length = 297;
inset_half_length = inset_length/2;
inset_depth = 20;

cuboid([inset_width, inset_depth, inset_height]);
back(inset_half_length/2) left(inset_width/2-inset_depth/2)
    cuboid([inset_depth, inset_half_length-inset_depth, inset_height]);
back(inset_half_length/2) right(inset_width/2-inset_depth/2)
    cuboid([inset_depth, inset_half_length-inset_depth, inset_height]);