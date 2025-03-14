include <BOSL2/std.scad>
include <BOSL2/rounding.scad>
include <BOSL2/screws.scad>

inner_d = 18;
inner_h = 3.5;
wall_w = 1.5;



module threaded_post() {
    spec = [["system","ISO"],
            ["type","screw_info"],
            ["pitch", .8],
            ["head", "none"],
            ["diameter",inner_d+wall_w*2],
            ["thread_len", inner_h/2+wall_w/2],
            ["length",inner_h+wall_w]];
    xrot(180)screw(spec,tolerance=0, bevel=false);
    down((inner_h+wall_w)/4) cyl(d=inner_d+wall_w*3, h = (inner_h+wall_w)/2);

}

module outer_nut(thickness) {
    spec = [["system","ISO"],
            ["type","nut_info"],
            ["shape", "hex"],   
            ["thickness", thickness],
            ["width", inner_d+wall_w*4],
            ["pitch", .8],
            ["diameter",inner_d+wall_w*2],
            ];
            
    nut(spec, ibevel=false, bevel=false);
}

module cap() {
    outer_nut(inner_h+wall_w/2);
    up(inner_h) cyl(d=inner_d+wall_w*3, h = wall_w);
}

module base() {

    difference() {
       threaded_post();
       up(wall_w/2+0.01) cyl(d=inner_d, h=inner_h);
    }

    down(inner_h/2+wall_w/2) outer_nut((inner_h+wall_w)/2);

}

base();



//cap();

