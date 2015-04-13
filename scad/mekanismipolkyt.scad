module outline() {
    translate([-7, -7,0]) cube([14,14,55], [0,0]);
}

module inside(){
    translate([0, 0, 5]) cylinder(51,5,5, [0,0]);
}

difference(){
    outline();
    inside();
}