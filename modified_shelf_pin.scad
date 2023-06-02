module original() {
  import("/Users/vickeryj/Code/OpenSCAD/shelf-pin.stl");
}

//original();

module pin_only() {
  intersection() {
    original();
    cube([7.11,20,12]);
  }
}

module bracket() {
  intersection() {
    original();
    translate([7.11, 0, 0]) cube([11.7,14.85,12]);
  }
}

translate([0, 1.4, 0]) pin_only();
bracket();