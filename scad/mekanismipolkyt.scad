module outline() {
    translate([-5, -5,0]) cube([10,10,55], [0,0]);
}

module inside(){
    translate([0, 0, -1])
    cylinder(50,3,3, [0,0]);
}

module hold(){
    translate([-15, -5, 20]) cube([30,2,15], [0,0]);

}

difference(){
    outline();
    inside();
}

hold();



