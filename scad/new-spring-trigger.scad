module springTrigger(minRadius, maxRadius, vertexCount, startPoint, height) {
	function vertexAt(vertexIndex) = 
		let(fraction = vertexIndex / vertexCount)
		let(angle = fraction * 360) 
		
		let(lengthFraction = vertexIndex > startPoint ? fraction : startPoint / vertexCount + sin(360 * (startPoint - vertexIndex) / startPoint ) / 20)
		let(length = minRadius + lengthFraction * (maxRadius - minRadius)) 
		[cos(angle) * length, sin(angle) * length];
	
	range = [0:(vertexCount-1)];
	path = [for (i = range) i];
	vertices = [for (i = range) vertexAt(i)];

	linear_extrude(height = height) polygon(points=vertices, paths=[path]);
}

module drawSpring() {
	union() {
		color([1,0,0]) translate([4.4, -0.8, 1]) {
			difference() {
				cylinder(h = 2, r=26.5, center=true, $fn = 50);
				cylinder(h = 2.2, r=22.5, center=true, $fn = 50);
			}
		}
		
		difference() {
			springTrigger(12,30, 500, 65, 9);
			translate([0, 0, 3]) springTrigger(8.5,26.5, 500, 65, 8);
			translate([4.4, -0.8, 0]) cylinder(h = 2, r=0.75, center=true, $fn = 20);
		}
		
		translate([12, 0, 0]) rotate([0, 0, -5]) cube([17.9, 4, 9]);
		
	}
}

scale(1.2) drawSpring();