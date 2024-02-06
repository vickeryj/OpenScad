height = .2;
size = 20;

module legs() {
cube([size, .5, height]);
cube([.5, size, height]);
}

module unfilled() {
    legs();
    translate([size, 0, 0]) mirror([1, 0, 0]) legs();
    translate([0, size, 0]) mirror([0, 1, 0]) legs();
}

module filled() {
    cube([size, size, height]);
}

unfilled();