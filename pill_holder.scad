include <BOSL2/std.scad>
include <BOSL2/rounding.scad>
include <BOSL2/screws.scad>

inner_d = 18;
inner_h = 3.5;
wall_w = 1.5;
pitch = 1;
bottom_nut_height = (inner_h+wall_w)/2;
keychain_attachment_length = 15;

$fn=64;
$slop=.11;

module threaded_post() {
    spec = [["system","ISO"],
            ["type","screw_info"],
            ["pitch", pitch],
            ["head", "none"],
            ["diameter",inner_d+wall_w*2],
            ["thread_len", inner_h/2+wall_w/2],
            ["length",inner_h+wall_w]];
    xrot(180) screw(spec, bevel=false);
    down((inner_h+wall_w)/4) cyl(d=inner_d+wall_w*3, h = (inner_h+wall_w)/2);

}

module outer_nut(thickness) {
    spec = [["system","ISO"],
            ["type","nut_info"],
            ["shape", "hex"],   
            ["thickness", thickness],
            ["width", inner_d+wall_w*4],
            ["pitch", pitch],
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
       up(wall_w/2+0.01) cyl(d=inner_d, h=inner_h, rounding1=1.5);
    }

    down(inner_h/2+wall_w/2) outer_nut(bottom_nut_height);

}

keychain_back=14;
keychain_base=inner_d-3.5;
keychain_top=inner_d/3;
keychain_hole=5;
keychain_spacer=2.5;
keychain_spacer_offset=0.7;

module keychain_attachment() {
    back(keychain_back-keychain_spacer/2-keychain_spacer_offset)
    down(bottom_nut_height/2)
        cuboid([keychain_base, 
                keychain_spacer,
                bottom_nut_height],
                edges=[TOP+RIGHT,TOP+LEFT, BOTTOM+RIGHT, BOTTOM+LEFT],
                rounding=.5);
    difference() {
        back(keychain_back)
        down(bottom_nut_height/2)
            cyl(d=keychain_base, 
                h=bottom_nut_height,
                rounding=.5);
        back(keychain_back-keychain_base/2-1)
        down(bottom_nut_height/2)
            cuboid([keychain_base, 
                    keychain_base,
                    bottom_nut_height+.02]);
        back(keychain_back+keychain_base/4-1)
        down(bottom_nut_height/2)
            cyl(d=keychain_hole,
                h=bottom_nut_height+.02,
                rounding=-1);

    }
}

keychain_attachment();
base();

left(30) xrot(180) down(inner_h/2) cap();

