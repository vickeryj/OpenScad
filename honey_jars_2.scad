include <BOSL2/std.scad>
include <BOSL2/rounding.scad>

jars_across = 3;
num_shelves = 3;
dia = 45; // spice jar hole diameter
shroud = 35; // shroud height
total = 167; // total height including handle (excluding bottom surface)
handle = 10; // handle diameter
bottom = 2; // bottom surface thickness
top = 3.2; // top surface thickness
wall = 2; // vertical wall thickness
post_d = 6;
rotated_shelf_height = sqrt(shroud^2+dia^2);
height = rotated_shelf_height*num_shelves;


$fa = 5;
$fs = 0.5;

//$fn = $preview ? 30 : 60;
pitch = dia + post_d;
outer_dia = dia + 2*wall;
n = jars_across - 1;
y = .5;

module shelf_shape() {
	offset(r=-dia/6) offset(delta=dia/6) {
        y=.5;
		for (x=[-n/2:n/2]) translate([x,y]*pitch) circle(d=outer_dia);
	}
}

module holes() {
	for (x=[-n/2:n/2]) translate([x,y]*pitch) circle(d=dia);
}

module shelf() {
    linear_extrude(height=bottom) shelf_shape();
    linear_extrude(height=shroud) difference() {
        shelf_shape();
        holes();
    }
}

module post() {
    cyl(d=post_d, h=height-rotated_shelf_height/2);
}

module base() {
    cuboid([outer_dia*jars_across,rotated_shelf_height,wall], rounding=1);
}

xrot(60) shelf();
up (rotated_shelf_height-wall/2) xrot(60) shelf();
up (rotated_shelf_height*2-wall) xrot(60) shelf();

up(height/2-12) {
    right(dia/2+post_d/2) post();
    left(dia/2+post_d/2) post();
}

up(wall-.1) fwd(outer_dia/3) base();
