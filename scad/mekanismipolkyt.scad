module outline() {
    translate([-6, -6,0]) cube([12,12,55], [0,0]);
}

module inside(){
    translate([0, 0, -1])
    cylinder(50,4,4, [0,0]);
}

module hold(){
    translate([-12, -6, 20]) cube([24,2,15], [0,0]);

}

difference(){
    outline();
    inside();
}

hold();

//suurensin nyt tota keskustaa ja vähän koko palasta, nyt pitäis mahtua


