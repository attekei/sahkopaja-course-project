module bar() {
	totalHeight = 30;
	widerHeight = 6;
	transitionHeight = 2;
	narrowHeight = totalHeight - widerHeight - transitionHeight;
	
	cylinder(h = narrowHeight, r=4, center=true, $fn = 50);
	translate([0, 0, narrowHeight / 2 + transitionHeight / 2]) cylinder(h = transitionHeight, r1=4, r2= 6, center=true, $fn = 50);
	translate([0,0,totalHeight / 2 - widerHeight / 2 + widerHeight / 2]) cylinder(h = 4, r=6, center=true, $fn = 50);
}

translate([0,10,0]) bar();
translate([0,-10,0]) bar();
translate([0, 0, -7]) cube([8, 20, 8], center=true) bar();

module differenceShape() {
	difference() {
		circle(4);
		translate([-4,0]) square([8,4]);
	}
}
differenceShape();