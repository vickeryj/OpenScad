include <BOSL2/std.scad>

r = 40;

$fn = 128;

intersection() {
    resize(newsize=[80, 60, 80]) 
    sphere(r);
    fwd(r) cube(2*r);
}