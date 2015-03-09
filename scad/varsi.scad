module hole() {
    translate([0, -35, -2])
    cylinder(7,2,2, [0,0]);
}

module sylinder(){
    translate([0, 35, 3])
    cylinder(5,3,3, [0,0]);
}

module upperpart(){
    translate([-7, -40, 0])
    cube([14,80,3], [0,0]);
}

difference(){
    upperpart();
    hole();
}


sylinder();



