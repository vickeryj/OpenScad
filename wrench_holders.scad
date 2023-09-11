// -----------------------------------------------------
// Schraubenschluesselhalter v2
//
//  Detlev Ahlgrimm, 11.2018
// -----------------------------------------------------

/* metric   
//labels
werte=  ["6", "7", "8", "10", "12", "13", "13", "14", "17", "19"];
//widths
breiten=[3.4, 3.5, 3.5, 4.6, 4.9, 5, 5, 5.3, 6.8, 7.3];
//heights
hoehen= [6.9, 7.5, 8.3, 8.7, 10.2, 10.2, 10.6, 11.4, 13, 13.6];
*/

//sae
//labels
werte=  ["1/4", "5/16", "7/16", "1/2", "5/8", "11/16", "3/4"];
//widths
breiten=[3.4, 3.5, 4.5, 5.1, 6.4, 6.9, 7.3];
//heights
hoehen= [6.7, 8.2, 9.3, 10.6, 12.7, 14.2, 15.5];


hole_length = 52;
hoehe_boden=8;    // height
tiefe=5;          // auf dieser Laenge werden die Schluessel gehalten
part=1  ;   // [0:assembled, 1:print]

/* [Hidden] */
$fn=100;
fix=0;            // dieser Wert wird zu jedem Wert aus breiten[] addiert

// -----------------------------------------------------
//  wie cube() - nur abgerundet
// -----------------------------------------------------
module BoxMitAbgerundetenEcken(v, r=1) {
  hull() {
    translate([    r,     r,     r]) sphere(r=r);
    translate([v.x-r,     r,     r]) sphere(r=r);
    translate([    r, v.y-r,     r]) sphere(r=r);
    translate([v.x-r, v.y-r,     r]) sphere(r=r);

    translate([    r,     r, v.z-r]) sphere(r=r);
    translate([v.x-r,     r, v.z-r]) sphere(r=r);
    translate([    r, v.y-r, v.z-r]) sphere(r=r);
    translate([v.x-r, v.y-r, v.z-r]) sphere(r=r);
  }
}

// -----------------------------------------------------
// Liefert die Summe der Elemente in "arr"
// -----------------------------------------------------
function sum(arr, idx=0) = idx==len(arr) ? 0 : arr[idx]+sum(arr, idx+1);

// -----------------------------------------------------
// Liefert die Summe der Elemente in "arr" bis zum
// Element "maxidx" (exkl.).
// Beispiel:  sum_to([1, 2, 4, 8], 3) == 7
//    Index:          0  1  2  3
// -----------------------------------------------------
function sum_to(arr, maxidx, idx=0) = idx>=maxidx ? 0 : arr[idx]+sum_to(arr, maxidx, idx+1);

// -----------------------------------------------------
//  wie cube() - nur oben etwas verengt
// -----------------------------------------------------
module Ausschneider(v, enger=0.5) {
  linear_extrude(v.z) polygon([ [0,0], [0,v.y-1], [enger,v.y], [v.x-enger,v.y], [v.x,v.y-1], [v.x, 0] ]);
}

// -----------------------------------------------------
//
// -----------------------------------------------------
module Langloch(ra, ri, l) {
  hull() {
    translate([0, 0, -0.1]) cylinder(r1=ra, r2=ri, h=1.1);
    translate([l, 0, -0.1]) cylinder(r1=ra, r2=ri, h=1.1);
  }
  hull() {
    translate([0, 0, 0.99]) cylinder(r=ri, h=tiefe-1.98);
    translate([l, 0, 0.99]) cylinder(r=ri, h=tiefe-1.98);
  }
  hull() {
    translate([0, 0, tiefe-1]) cylinder(r1=ri, r2=ra, h=1.1);
    translate([l, 0, tiefe-1]) cylinder(r1=ri, r2=ra, h=1.1);
  }
}


breite_koerper=2.5*sum(breiten) + 2.5*len(breiten)*fix + breiten[0]*1.5 - 4;  // die 1.5'fache Breite als Abstand
hoehe_koerper=max(hoehen)+hoehe_boden+2;

// -----------------------------------------------------
//
// -----------------------------------------------------
module Seite() {
  difference() {
    translate([-breiten[0]*1.5, 0, 0]) BoxMitAbgerundetenEcken([breite_koerper, hoehe_koerper+5, tiefe], 2);

    for(i=[0:len(werte)-1]) {
      translate([(sum_to(breiten, i)+(i+1)*fix)*2.5, hoehe_koerper-2-hoehen[i], -0.1])
        Ausschneider([breiten[i]+fix, hoehen[i]+2.01, tiefe+0.2]);
      translate([(sum_to(breiten, i)+(i+1)*fix)*2.5, hoehe_koerper-0.01, -0.1])
        cube([breiten[i]+fix, 5.02, tiefe+0.2]);
    }
    translate([-breiten[0]*1.5-0.1, hoehe_koerper+1, tiefe-2.9]) rotate([0, 90, 0]) linear_extrude(breite_koerper+0.2) polygon([ [0,0], [-3,0], [-3,3] ]);
    translate([-breiten[0]*1.5-0.1, hoehe_koerper+2, tiefe-0.5]) cube([breite_koerper+0.2, 3, 2]);

    translate([-breiten[0]*1.5+6, 6, 0]) Langloch(3, 2, hole_length);
  }
}


// -----------------------------------------------------
//
// -----------------------------------------------------
module Verschluss() {
  difference() {
    BoxMitAbgerundetenEcken([breite_koerper+2, 7, tiefe+6], 2);
    translate([-3, -2, 6/2-0.3]) BoxMitAbgerundetenEcken([breite_koerper+3.3, 2+5.3, tiefe+0.6], 2);
  }
  translate([1, 1, tiefe+0.5]) rotate([0, 90, 0]) linear_extrude(breite_koerper) polygon([ [0,0], [-3,0], [-3,3] ]);
}

if(part==0) {
  Seite();
  translate([-breiten[0]*1.5, hoehe_koerper, -6/2]) Verschluss();
} else if(part==1) {
  Seite();
  translate([-breiten[0]*1.5, hoehe_koerper+7, 7]) rotate([-90, 0, 0]) Verschluss();
}
