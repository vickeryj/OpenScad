use </Users/vickeryj/Code/OpenSCAD/threads.scad>

diameter = 6;
bolt_length = 28;
thread_length = 6;
head_thickness = 3;
head_diameter = 15;

$fn = 10;

cylinder(h = head_thickness, d = head_diameter);
translate([0,0,head_thickness-.01]) RodStart(diameter, bolt_length, thread_len = thread_length);

translate([20, 0, 0]) ScrewHole(diameter*.75, head_thickness)
    cylinder(h=head_thickness, d=head_diameter);