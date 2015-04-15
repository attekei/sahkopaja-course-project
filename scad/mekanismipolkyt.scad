 module outline() {
    translate([-5, -5,0]) cube([10,10,55], [0,0]);
 }
 
 module inside(){
    translate([0, 0, 5]) cylinder(51,3.3,3.3, [0,0]);
 }
 
 difference(){
     outline();
     inside();
 }