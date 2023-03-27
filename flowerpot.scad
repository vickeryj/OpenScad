module pot() {
    translate([190,130, 0])
    import("/Users/vickeryj/Downloads/Low_Poly_Planter__-_Wide_Top_2999036/files/Low_Poly_Planter.stl");
}

difference() {
    pot();
    translate([0,0,-10]) cylinder(h=100, d = 5);
}