include <BOSL2/std.scad>
include <BOSL2/rounding.scad>

$fn = 64;


wall_width = 2;
straight = 5;
top_width = 20/2;
middle = 15;
clip_width = 5;

    
clip_path = turtle([
    //top straight outside
    "arcleft", wall_width, 90,
    "move", straight,
    
    //top curve outside
    "arcleft", top_width+wall_width*2, 180,
    
    //left curve outside
    "arcleft", top_width, 45,
    "move", middle,
    
    //right curve inside
    "arcright", middle-wall_width*2, 45,
    
    //bottom curve inside
    "arcright", top_width-wall_width+2, 180,
    
    //bottom straight inside 
    "move", straight,
    "arcleft", wall_width, 90,
    
    //bottom straight outside
    "arcleft", wall_width, 90,
    "move", straight,
    
    //bottom curve outside
    "arcleft", top_width+wall_width*2, 180,
    
    //right curve outside
    "arcleft", middle, 45,
    "move", middle,
    
    //left curve inside
    "arcright", top_width-wall_width*2, 45,
    
    //top curve inside
    "arcright", top_width, 180,
    
    //top straight inside
    "move", straight,
    "arcleft", wall_width, 89,
    


]);

//stroke(clip_path);

    
offset_sweep(clip_path, 
height = clip_width,
bottom=os_circle(r=1.2),
top=os_circle(r=1.2)
);
