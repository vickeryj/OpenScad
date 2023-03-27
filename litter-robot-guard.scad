module single_hole() {
    import("/Users/vickeryj/Downloads/Litter-Robot_3_Button_Guard_4822186/files/Litter_Robot_3_Button_Guard.stl");
}
module paw() {
    import("/Users/vickeryj/Downloads/Litter_Robot_III_Button_Guard_3756391/files/Litter_Robot_Button_Guard.stl");
}

//color("red") translate([0,0,1]) paw();

//rotate([0,180,0]) translate([0,0,-5]) single_hole();

$fn = 120;

//11.4 diameter inner circle resulted in 11.1 diameter print, but 13mm outer diamer is 13mm in print
// 13*1.6 = 20.8, measured outer width = 20.7

difference() {
    scale([1.6, 1, 1]) color("orange") cylinder(h = 4.7, d = 15);
    translate([0, 0, 1]) scale([1.65, 1, 1]) color("green") cylinder(h = 6, d = 11.45);
    translate([0,0,-.01]) linear_extrude(height = .6)
        rotate([0, 180, 0]) text("NO!", size = 6, font = "Helvetica", halign = "center", valign = "center");
}

// h of 4.7 could have been a touch higher, but it overall works well