difference() {
cube([100, 20, 20]);
translate([2, 2, -.01])
cube([96, 16, 20+.02]);
translate([-.01, -.01, -.01])
cube([20, 20+.02, 10]);
translate([100-20+.01, -.01, 10+.01])
cube([20, 20+.02, 10]);
};
translate([20, 2.01, 0])
cube([2, 16.02, 10.01]);
translate([100-20-2, 2.01, 10])
cube([2, 16.02, 10.01]);
