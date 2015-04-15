anglePhase = $t  * 360;

minRadius = 8.5;
maxRadius = 26.5;
vertexCount = 500;
startPoint = 65;
height= 8;

function lengthAt(vertexIndex) = 
	let(fraction = vertexIndex / vertexCount)
	let(angle = fraction * 360) 
	
	let(lengthFraction = vertexIndex > startPoint ? fraction : startPoint / vertexCount + sin(360 * (startPoint - vertexIndex) / startPoint ) / 20)
	minRadius + lengthFraction * (maxRadius - minRadius);
		
		
module polkky() {
	color([0,1,1]) rotate([0, -90, 0]) import("mekanismipolkyt.stl", convexity=3);
}



module bar() {
	rotate([0, 90, 0]) cylinder(h = 70, r=3, center=true, $fn = 50);
}

//import("varsi.stl", convexity=3);

translate([65, 22.5, 0]) polkky();
translate([65, -22.5, 0]) polkky();

module movingPart() {
	translate([-25, 0, 0]) rotate([0,90,0]) import("spring-component.stl", convexity=3);

	translate([25, 22.5, 0])  bar();
	translate([25, -22.5, 0]) bar();

	translate([5,0,24]) rotate([180,0,90]) import("varsi.stl", convexity=3);
	translate([-30, 0, 0]) cylinder(h = 25, r=1,  $fn = 50);	
}

translate([-(lengthAt(500 - $t * 500)),0,0]) movingPart();

color([1,0,0]) translate([42, 0,8]) rotate([0,0,180 + anglePhase + 9]) import("new-spring-trigger.stl", convexity=3);