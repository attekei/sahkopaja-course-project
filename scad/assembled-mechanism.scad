

module polkky() {
	rotate([0, -90, 0]) import("mekanismipolkyt.stl", convexity=3);
}
	//import("new-spring-trigger.stl", convexity=3);

translate([-25, 0, 0]) rotate([0,90,0]) import("spring-component.stl", convexity=3);

module bar() {
	rotate([0, 90, 0]) cylinder(h = 70, r=3, center=true, $fn = 50);
}

translate([25, 22.5, 0])  bar();
translate([25, -22.5, 0]) bar();
//import("varsi.stl", convexity=3);

translate([65, 22.5, 0]) polkky();
translate([65, -22.5, 0]) polkky();

translate([5,0,19]) rotate([180,0,90]) import("varsi.stl", convexity=3);