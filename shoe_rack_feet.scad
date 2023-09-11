include <BOSL2/std.scad>
include <BOSL2/rounding.scad>

base_width = 30;
base_depth = 30;
wall_thickness = 3;

base = square([base_width, base_depth]);
rbase = round_corners(base, method="smooth", cut=1, $fn=30);

clip_gap = 10.2;
clip_height = 7;
clip = square([wall_thickness, base_depth-3.6]);
rclip = round_corners(clip, method="circle", radius=1, $fn=30);
fillet = 1;
 
right((base_width - clip_gap)/2-wall_thickness) 
    join_prism(rclip, base="plane", length=clip_height, fillet=fillet, n=12, end_round=1);
    
    
right(((base_width - clip_gap)/2+clip_gap))
    join_prism(rclip, base="plane", length=clip_height, fillet=fillet, n=12, end_round=1);
   
    
back(base_depth/2-1.7) right(base_width/2)
    offset_sweep(rbase, height=wall_thickness, bottom=os_circle(r=.5), top=os_circle(r=.5), anchor=TOP);
