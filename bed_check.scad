//cube([40, 40, .2]);
//translate([50, 0, 0]) cube([40, 40, .2]);

height = .28;

module legs() {
cube([220, .5, height]);
cube([.5, 220, height]);
}

for (i = [0 : 5 : 20]) {
translate([10*i, 0, 0]) cube([20, 20, height]);
for (j = [0 : 5 : 20]) {
translate([10*i, 10*j, 0]) cube([20, 20, height]);
}
}

legs();
translate([220, 0, 0]) mirror([1, 0, 0]) legs();
translate([0, 220, 0]) mirror([0, 1, 0]) legs();

//color("red", .2) cube(220);