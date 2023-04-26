module original() {
  import("/Users/vickeryj/Downloads/Shelf_Support_Pin_26850/files/shelf-pin.stl");
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
    translate([7.11, 0, 0]) cube([11.7,20,12]);
  }
}

translate([0, 2, 0]) pin_only();
bracket();