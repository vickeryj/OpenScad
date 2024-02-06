
difference() {
    difference() {
        translate([0, 0, -.2])
        import("/Users/vickeryj/Downloads/Cherry_MX_Low_Profile_Keycap_5180641/files/Cherry-MX-Low-Profile-Keycap.stl");


        translate([.6, -9.4, -19])
        cube(19);
    };

    $fn=360;
    translate([10, 0, -.001]) {
        difference() {
            cylinder(h=6, r=12, center = false);
            cylinder(h=12, r=5.4/2, center = false);
        };
    };
};

$fn=180;
translate([10, 0, 0])
    cylinder( h=.501, r=5, center=false);
   
/*    
translate([0, 0, 0])
cylinder( h=.501, r=5, center=false, $fn=360);

translate([-1, -1, 0])
cube([2,2,1.01], center = false);*/

translate([10,0,.01])
difference() {
    cylinder(h=1.5, r=5, center = false);
    translate([0,0,-.01])
    cylinder(h=1.52, r=4.5, center = false);
};